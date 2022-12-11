//
//  GamePointModel.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/9/8.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import SwiftUI

class GamePointModel:Decodable,Hashable,Identifiable{
    var correctness:Bool
    var id:Int
    var point:Int
    var name:String
    var answer_time:String
    init(correctness:Bool,id:Int,point:Int,nickname:String,answer_time:String) {
        self.correctness = correctness
        self.id = id
        self.point = point
        self.name = nickname
        self.answer_time = answer_time
    }
    enum CodingKeys: String, CodingKey{
        case correctness
        case id = "user_id_id"
        case point
        case name = "nickname"
        case answer_time
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: GamePointModel, rhs: GamePointModel) -> Bool {
        return lhs.id == rhs.id
    }
}
