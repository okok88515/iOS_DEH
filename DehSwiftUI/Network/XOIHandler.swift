//
//  XOIHandler.swift
//  DehSwiftUI
//
//  Created by mmlab on 2020/12/23.
//  Copyright © 2020 mmlab. All rights reserved.
//

import Combine
import Alamofire
import SwiftUI

class XOIHandler: ObservableObject{
    //let networkconnector = NetworkConnector()
    @Published var responseFormat = ResponseFormat(){
        willSet {
            objectWillChange.send()
        }
    }
    //@EnvironmentObject var settingStorage:SettingStorage
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init() {

    }

    
    func getPOI(){
        //self.settingStorage.XOIs["group"] = networkconnector.ResponseFormat?.results
        let para = ["username": "et00", "lat" :"22.9", "lng": "120.3", "dis": "20000.0", "num": "50", "coi_name": "deh", "action": "/API/userPOI","user_id": "2947","password":"et00".md5()]
        
        responseFormat.getData(url: getXois["/API/userPOI"] ?? "", para: para)
        //print(networkconnector.ResponseFormat?.results.first?.id ?? 8787)
        
        
//        for item in networkconnector.ResponseFormat?.results ?? []{
//            print(xoi.id)
//            //settingStorage.XOIs["group"]?.append(xoi)
//        }
    }
    
    func getLOI(){
        //networkconnector.getData(url: getXois["/API/userLOI"] ?? "")
        
    }
    
    func getAOI(){
        //networkconnector.getData(url: getXois["/API/userAOI"] ?? "")
        
    }
    
    
}
