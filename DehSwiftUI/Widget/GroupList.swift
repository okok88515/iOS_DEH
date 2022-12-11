//
//  GroupList.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/14.
//  Copyright © 2021 mmlab. All rights reserved.

//往上跳一層
//https://stackoverflow.com/questions/56513568/ios-swiftui-pop-or-dismiss-view-programmatically/57279591

import SwiftUI
import Combine
import Alamofire
class GroupLists:Decodable{
    let results: [Group]?
    let eventList:[Group]?
    let groupList:[Group]?
}

struct GroupList: View {
    @State private var cancellable: AnyCancellable?
    @EnvironmentObject var settingStorage:SettingStorage
    @State var groups:[Group] = []
    @Binding var group:Group
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View{
        List{
            ForEach(self.groups) {group in
                Button(action:{
                    print(group.name)
                    self.group = group
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text(group.name)
                        .foregroundColor(Color.white)
//                        .allowsTightening(true)
//                        .lineLimit(1)
                }
                .listRowBackground(Color.init(UIColor(rgba:lightGreen)))
                
            }
        }
        .onAppear(perform: {
            getGroupList()
        })
    }
}
extension GroupList{
    func getGroupList(){
        let url = GroupGetUserGroupListUrl
        let parameters:[String:String] = [
            "user_id": "\(settingStorage.userID)",
            "coi_name": coi,
            "language": "中文",
        ]
        let publisher:DataResponsePublisher<GroupLists> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
//                print(values.data?.JsonPrint())
                print(values.debugDescription)
                self.groups = values.value?.results ?? []
                print(self.groups)
            })
    }
}

//struct GroupList_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupList(groups:[Group(id: 0, name: "123"),Group(id: 0, name: "123")], group: <#Binding<Group>#>)
//    }
//}
