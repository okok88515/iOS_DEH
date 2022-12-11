//
//  BeginView.swift
//  DehSwiftUI
//
//  Created by 廖偉博 on 2022/11/6.
//  Copyright © 2022 mmlab. All rights reserved.
//
//
import SwiftUI
import Combine
import Alamofire

struct BeginView: View {
    
    @EnvironmentObject var settingStorage:SettingStorage
    @State var groupSelectedOver: Bool = false
    @State var searchText:String = ""
    @State var reqAlertState:Bool = false
    @State var resAlertState:Bool = false
    @State var alertText:String = ""
    @State var selectedGroup:String = ""
    @State var groupNameList:[GroupName] = []
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        VStack {
            if #available(iOS 15, *) {
                NavigationLink(destination: ContentView(), isActive: self.$groupSelectedOver) { EmptyView() }
            }
            SearchBar(text: $searchText)
            List {
                ForEach(self.groupNameList) { groupName in
                    if(groupName.name.hasPrefix(searchText)) {
                        Button {
                            self.selectedGroup = groupName.name
                            self.reqAlertState = true
                            GroupApplyMessage()
                        } label: {
                            Text(groupName.name)
                        }
                        .alert(isPresented: $reqAlertState) { () -> Alert in
                            return Alert(title: Text("Join".localized),
                                         message: Text("Join".localized + "\(selectedGroup)?"),
                                         primaryButton: .default(Text("Yes".localized),
                                                            action: {             self.resAlertState = true
                                                                self.groupSelectedOver = true}),
                                         secondaryButton: .default(Text("No".localized), action: {}))
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .onAppear { getGroupNameList() }
    }
}

extension BeginView {
    func getGroupNameList() {
        let url = GroupGetListUrl
        print(settingStorage.account)
        let parameters = ["username":settingStorage.account,
                          "coi_name":coi]
        let publisher:DataResponsePublisher<GroupNameList2> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                print(values.debugDescription)
                self.groupNameList = values.value?.result ?? []
            })
    }
    func GroupApplyMessage() {
        let url = GroupMemberJoinUrl
        let temp = """
        {
            "sender_name": "\(settingStorage.account)",
            "group_name": "\(selectedGroup)"
        }
"""
        let parameters = ["join_info":temp]
        let publisher:DataResponsePublisher<GroupMessage> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                print(values.debugDescription)
                self.alertText = values.value?.message ?? ""
            })
        
    }
}

struct GroupNameList2:Decodable{
    let result:[GroupName]
}

struct BeginView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSearchView()
    }
}
