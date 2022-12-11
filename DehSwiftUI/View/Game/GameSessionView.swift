//
//  Session.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/28.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
struct SessionView: View {
    var group:Group
    @StateObject var gameVM:GameViewModel
    @State private var showingSheet = false
    @State var selection: Int? = nil
    @EnvironmentObject var settingStorage:SettingStorage
    var body: some View {
        ZStack{
            List{
                ForEach(gameVM.sessionList,id: \.self){
                    session in
                    Button(session.name) {
                        gameVM.selectedSession = session
                        showingSheet = true
                    }
                    .actionSheet(isPresented: $showingSheet) {
                        ActionSheet(
                            title: Text("What do you want to do?".localized),
                            buttons: [
                                .default(Text("History".localized),action: {
                                    selection = 1
                                }),
                                .default(Text("Game".localized),action: {
                                    selection = 2
                                    
                                }),
                                .cancel()]
                        )
                    }
                }
                .foregroundColor(Color.white)
                .allowsTightening(true)
                .lineLimit(1)
                .background(Color.init(UIColor(rgba:lightGreen)))
                .listRowBackground(Color.init(UIColor(rgba: lightGreen)))
            }
            NavigationLink(
                destination: GameHistoryView(roomID:gameVM.selectedSession?.id ?? -1),
                tag:1, selection: $selection){
                    EmptyView()
                }
            NavigationLink(
                destination: GameMap(gameVM: gameVM, group: self.group, session: gameVM.selectedSession ?? testSession),
                tag:2, selection: $selection){
                    EmptyView()
                }
        }
        
        .onAppear(){
            gameVM.getSessions(userID: settingStorage.userID, groupID: group.id)
        }
    }
}

struct Session_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(group: Group(id: -1, name: "testGroup", leaderId: -1, info: ""),gameVM: GameViewModel())
            .environmentObject(SettingStorage())
    }
}
