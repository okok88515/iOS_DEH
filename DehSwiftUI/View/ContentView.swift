//
//  ContentView.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/1.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire
import CryptoKit
import Combine
import simd
// the personal entry is here
#if SDC
let coi = "sdc"
let app = "sdc"
#elseif EXTN
let coi = "extn"
let app = "extn"
#elseif DEHLITE
let coi = "deh"
let app = "dehLite"
#elseif DEHMICRO
let coi = "deh"
let app = "dehMicro"
#elseif SDCMICRO
let coi = "sdc"
let app = "sdcMicro"
#elseif SDCLITE
let coi = "sdc"
let app = "sdcLite"
#else
let coi = "deh"
let app = "deh"
#endif

var language = ""
struct ContentView: View {
    init(){
        //list底下的背景色
        UITableView.appearance().backgroundColor = UIColor(rgba:darkGreen)
        UserDefaults.standard.register(defaults: [
            "advancedSetting" : false,
            "searchDistance" : 10.0,
            "searchNumber" : 50.0,
            "account" : "",
            "password" : "",
            "loginState" : false,
            "userID" : "0",
        ])
        let languageList = ["zh": "中文",
                            "jp": "日文",
                            "en": "英文",
        ]
        language = languageList[Locale.current.languageCode ?? ""] ?? "英文"
        
        //https://stackoverflow.com/questions/69111478/ios-15-navigation-bar-transparent
        if #available(iOS 15, *) {
            // White non-transucent navigation bar, supports dark appearance
            // iOS 14 doesn't have extra separators below the list by default.
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        else {
            // To remove only extra separators below the list:
            UITableView.appearance().tableFooterView = UIView()
        }
        
        
        //解決tab bar半透明的問題
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(rgba: lightGreen)
        
        UINavigationBar.appearance().backgroundColor = UIColor(rgba: darkGreen)
        //選取不反白
        UITableViewCell.appearance().selectionStyle = .none
        
    }
    //帶有State 的變數可以動態變更ＵＩ上的值
    @State var sheetState = false
    @State var alertState = false
    @State var textState = false
    @State private var cancellable: AnyCancellable?
    @State var searchTitle = "title"
    @EnvironmentObject var settingStorage:SettingStorage
    //若使用classModel的值則必須使用observation pattern
    //https://stackoverflow.com/questions/60744017/how-do-i-update-a-text-label-in-swiftui
    @State var selection: Int? = nil
    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 0){
                    TabView{
                        TabViewElement(title: "My Favorite".localized, image1: "Empty", image2: "Empty",tabItemImage: "member_favorite",tabItemName: "favorite")
                        TabViewElement(title: "Searched Xois".localized, image1: "Empty", image2: "Empty",tabItemImage:"member_searched",tabItemName: "nearby")
                        if isMini() {
                            TabViewElement(title: "Group Interests".localized, image1: "member_grouplist", image2: "search",tabItemImage:"member_group",tabItemName:"group")
                            TabViewElement(title: "My Xois".localized, image1: "Empty", image2: "search",tabItemImage:"member_interests",tabItemName:"mine")
                        }
                        
                    }
                }
                .navigationBarTitle(Text("HI ".localized +  self.settingStorage.account), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    NavigationLink(destination: Setting(), tag: 1, selection: $selection) {
                        Button {
                            print("setting tapped")
                            self.selection = 1
                        } label: {
                            Image("member_setting")
                                .foregroundColor(.blue)
                        }
                        if isMini() {
                            Button {
                                sheetState = settingStorage.loginState
                                alertState = !settingStorage.loginState
                            } label: {
                                Image(systemName: "ellipsis.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .actionSheet(isPresented: $sheetState) {
                                ActionSheet(title: Text("Select more options".localized), message: Text(""), buttons: [
                                    .default(Text("Group".localized)) {
                                        self.selection = 2
                                    },
                                    .default(Text("Prize".localized)) {
                                        self.selection = 3
                                    },
                                    .cancel()
                                ])
                            }
                            .alert(isPresented: $alertState) {() -> Alert in
                                return Alert(title: Text("Please login first".localized),
                                             dismissButton:.default(Text("OK".localized), action: {
                                })
                                )
                            }
                            NavigationLink(tag: 2, selection: $selection, destination: {GroupListView()}){}
                            NavigationLink(tag: 3, selection: $selection, destination: {PrizeListView()}){}
                        }
                    }
                },trailing: HStack {
                    NavigationLink(tag: 4, selection: $selection, destination: {GameView()}){
                        Button{
                            print("game tap")
                            if !isMini() && settingStorage.userID == "0" {
                                textState = true
                            }
                            else {
                                self.selection = 4
                            }
                        } label: {
                            Image(systemName: "gamecontroller")
                        }
                    }
                    NavigationLink(tag: 5, selection: $selection, destination: {DEHMap()}) {
                        Button{
                            print("map tapped")
                            self.selection = 5
                        } label: {
                            Image("member_back")
                                .foregroundColor(.blue)
                        }
                    }

                })
            }
            .blur(radius: textState ? 30:0)
            .navigationViewStyle(StackNavigationViewStyle())
            if textState {
                NickNameDialog(show: $textState)
            }
        }
    }
    //this line to avoid lots of warning
    //https://stackoverflow.com/questions/65316497/swiftui-navigationview-navigationbartitle-layoutconstraints-issue/65316745
}
extension ContentView {
    func isMini() -> Bool {
        if app == "deh" || app == "sdc" {
            return true
        }
        return false
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SettingStorage())
    }
}
