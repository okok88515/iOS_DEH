//
//  TabViewElement.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/2.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

struct TabViewElement: View {
    @State var title: String
    var image1: String
    var image2: String
    var tabItemImage: String
    var tabItemName: String
    @State var alertString:String = ""
    @State var alertState:Bool = false
    @ObservedObject var xoiViewModel = XOIViewModel()
    @EnvironmentObject var settingStorage:SettingStorage
    @ObservedObject var locationManager = LocationManager()
    @State var selectSearchXOI = false
    @State private var cancellable: AnyCancellable?
    @State var group = Group(id: 0, name: "-111", leaderId: 0, info: "")
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .onAppear{
                        if(group.name != "-111"){
                            title = group.name
                        }
                    }
                    .foregroundColor(Color.white)
                Spacer()
                //this will cause an warning but no idea about it
                NavigationLink(destination: GroupList(group: $group)) {
                    Image(image1).hidden(image1=="Empty")
                }
                .disabled(image1=="Empty")

                
                Button(action: {
//                    searchXOIs()
                    selectSearchXOI = true
                }){
                    Image(image2).hidden(image2=="Empty")
                }
                .disabled(image2=="Empty")
                .actionSheet(isPresented: $selectSearchXOI) {
                    actionSheetBuilder(tabItemName:tabItemName)
                }
            }
            .padding([.top, .leading, .trailing])
            List{
                ForEach(self.settingStorage.XOIs[tabItemName] ?? []){xoi in
                    XOIRow(xoi:xoi,tabItemName:tabItemName)
                        .padding(.horizontal)
                }
                .listRowBackground(Color.init(UIColor(rgba: darkGreen)))
                
            }
        }
        .background(Color.init(UIColor(rgba: lightGreen)))
        .alert(isPresented: $alertState) { () -> Alert in
            return Alert(title: Text(alertString),
                 dismissButton:.default(Text("OK".localized), action: {}))
        }
        .tabItem{
            Image(tabItemImage)
            Text(tabItemName.localized)
                .foregroundColor(.white)
        }
    }
    
}
extension TabViewElement{
    func searchXOIs(action:String){
        print("User icon pressed...")
        if (group.id == 0) && (tabItemName == "group") {
            alertString = "please choose group".localized
            alertState = true
            return
        }
        let parameters:[String:String] = [
            "username": "\(settingStorage.account)",
            "lat" :"\(locationManager.coordinateRegion.center.latitude)",
            "lng": "\(locationManager.coordinateRegion.center.longitude)",
            "dis": "\(settingStorage.searchDistance * 1000)",
            "num": "\(settingStorage.searchNumber)",
            "coi_name": coi,
            "action": action,
            "user_id": "\(settingStorage.userID)",
            "group_id": "\(group.id)",
            "language": "中文",
        ]
        print(action)
        let url = getXois[action] ?? ""
        let publisher:DataResponsePublisher<XOIList> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
//                print(values.data?.JsonPrint())
//                print(values.debugDescription)
//                print(values.value?.results[0].containedXOIs)
                let xois = values.value?.results
                if  xois != [] {
                    self.settingStorage.XOIs[tabItemName] = xois
                    self.settingStorage.mapType = tabItemName
                }
                else {
                    alertString = "No Data".localized
                    alertState = true
                }
                
            })
        
    }
    func actionSheetBuilder(tabItemName:String) -> ActionSheet{
        print(tabItemName)
        if(tabItemName == "group"){
            return ActionSheet(title: Text("Select Search XOIs"), message: Text(""), buttons: [
                .default(Text("Group POI")) { searchXOIs(action: "searchGroupPOI") },
                .default(Text("Group LOI")) { searchXOIs(action: "searchGroupLOI") },
                .default(Text("Group AOI")) { searchXOIs(action: "searchGroupAOI") },
                .default(Text("Group SOI")) { searchXOIs(action: "searchGroupSOI") },
                .default(Text("Group My POI")) { searchXOIs(action: "searchGroupMyPOI") },
                .default(Text("Group My LOI")) { searchXOIs(action: "searchGroupMyLOI") },
                .default(Text("Group My AOI")) { searchXOIs(action: "searchGroupMyAOI") },
                .default(Text("Group My SOI")) { searchXOIs(action: "searchGroupMySOI") },
                .cancel()
            ])
        }
        else{
            return ActionSheet(title: Text("Select Search XOIs"), message: Text(""), buttons: [
                .default(Text("POI")) { searchXOIs(action: "searchMyPOI") },
                .default(Text("LOI")) { searchXOIs(action: "searchMyLOI") },
                .default(Text("AOI")) { searchXOIs(action: "searchMyAOI") },
                .default(Text("SOI")) { searchXOIs(action: "searchMySOI") },
                .cancel()
            ])
        }
    }
}


struct TabViewElement_Previews: PreviewProvider {
    static var previews: some View {
        TabViewElement(title: "page2", image1: "member_grouplist", image2: "search",tabItemImage: "member_favorite",tabItemName: "favorite")
            .environmentObject(SettingStorage())
    }
}

