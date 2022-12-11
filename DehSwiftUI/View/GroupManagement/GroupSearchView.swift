//
//  GroupSearchView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/10/14.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire

struct GroupSearchView: View {
    
    @EnvironmentObject var settingStorage:SettingStorage
    @State var searchText:String = ""
    @State var reqAlertState:Bool = false
    @State var resAlertState:Bool = false
    @State var alertText:String = ""
    @State var selectedGroup:String = ""
    @State var groupNameList:[GroupName] = []
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List {
                ForEach(self.groupNameList) { groupName in
                    if(groupName.name.hasPrefix(searchText)) {
                        Button {
                            self.selectedGroup = groupName.name
                            self.reqAlertState = true
                            MemberApplyMessage()
                        } label: {
                            Text(groupName.name)
                        }
                        .alert(isPresented: $reqAlertState) { () -> Alert in
                            return Alert(title: Text("Join".localized),
                                         message: Text("Join".localized + "\(selectedGroup)?"),
                                         primaryButton: .default(Text("Yes".localized),
                                                                 action: {                  self.resAlertState = true
                            }),
                                         secondaryButton: .default(Text("No".localized), action: {}))
                        }
                        
                    }
                }
                
            }
            .listStyle(PlainListStyle())
        }
        .onAppear { getGroupNameList() }
        .alert(isPresented: $resAlertState) {
            return Alert(title:Text(alertText.localized),dismissButton: .default(Text("OK".localized), action: {}))
        }
    }
}
extension GroupSearchView {
    func getGroupNameList() {
        let url = GroupGetListUrl
        print(settingStorage.account)
        let parameters = ["username":settingStorage.account,
                          "coi_name":coi]
        let publisher:DataResponsePublisher<GroupNameList> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                print(values.debugDescription)
                self.groupNameList = values.value?.result ?? []
            })
    }
    func MemberApplyMessage() {
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

struct GroupNameList:Decodable{
    let result:[GroupName]
}
struct GroupSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSearchView()
    }
}

