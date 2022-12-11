//
//  SessionModel.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/28.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import SwiftUI

class SessionModel:Decodable,Hashable,Identifiable{
    var id:Int
    var name:String
    var gameID:Int
    var status:String
    init(id:Int,name:String,gameID:Int,status:String) {
        self.id = id
        self.name = name
        self.gameID = gameID
        self.status = status
    }
    enum CodingKeys: String, CodingKey{
        case id
        case name = "room_name"
        case gameID = "is_playing"
        case status
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: SessionModel, rhs: SessionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
