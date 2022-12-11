//
//  NickAccountModel.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/12/4.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation

class NickAccount:Decodable{
    var account:String
    var password:String
    var id:Int
    enum CodingKeys: String, CodingKey{
        case account = "username"
        case id 
        case password
    }
    init(account:String,password:String,id:Int) {
        self.id = id
        self.account = account
        self.password = password
    }
}
