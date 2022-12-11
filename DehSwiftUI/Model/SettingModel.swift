//
//  SettingStorage.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/10.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI
//import Combine

final class SettingStorage:ObservableObject{
    //    let objectWillChange = PassthroughSubject<Void, Never>()
    init(){
        
        if let data = UserDefaults.standard.data(forKey: "favorite") {
            print(data.JsonPrint())
            if let decoded = try? JSONDecoder().decode([XOI].self, from: data){
                XOIs = [
                    "favorite" :decoded,
                    "nearby" : [],
                    "group" : [],
                    "mine" : [],
                    "temp": [],
                ]
            }
            else{
                XOIs = emptyXOIs
            }
        }
        else{
            XOIs = emptyXOIs
        }
        //print(XOIs)
        
    }
    // 讀取跟讀取設定 當變更時所有用到的人都會自動變更
    @Published var advancedSetting:Bool = UserDefaults.standard.bool(forKey: "advancedSetting"){
        didSet{
            UserDefaults.standard.set(advancedSetting,forKey: "advancedSetting")
        }
    }
    @Published var searchDistance:Double = UserDefaults.standard.double(forKey: "searchDistance") {
        didSet{
            UserDefaults.standard.set(searchDistance,forKey: "searchDistance")
        }
    }
    @Published var searchNumber:Double = UserDefaults.standard.double(forKey: "searchNumber") {
        didSet{
            UserDefaults.standard.set(searchNumber,forKey: "searchNumber")
        }
    }
    @Published var account:String = UserDefaults.standard.string(forKey: "account") ?? "EmptyAccount"{
        didSet{
            UserDefaults.standard.set(account,forKey: "account")
        }
    }
    @Published var password:String = UserDefaults.standard.string(forKey: "password") ?? "NoPassword"{
        didSet{
            UserDefaults.standard.set(password,forKey: "password")
        }
    }
    @Published var loginState:Bool = UserDefaults.standard.bool(forKey: "loginState"){
        didSet{
            UserDefaults.standard.set(loginState,forKey: "loginState")
        }
    }
    @Published var userID:String = UserDefaults.standard.string(forKey: "userID") ?? "-1"{
        didSet{
            UserDefaults.standard.set(userID,forKey: "userID")
        }
    }
    
    //正常來說不應該擺在這邊
    @Published var XOIs:[String:[XOI]]!{
        didSet{
            if let encoded = try? JSONEncoder().encode(XOIs["favorite"]) {
                UserDefaults.standard.set(encoded, forKey: "favorite")
            }
        }
    }
    @Published var mapType = ""
    var emptyXOIs:[String:[XOI]] = ["favorite" : [],
                     "nearby" : [],
                     "group" : [],
                     "mine" : [],
    ]
    func save() {
        if let encoded = try? JSONEncoder().encode(XOIs["favorite"]) {
            UserDefaults.standard.set(encoded, forKey: "favorite")
        }
    }
}
