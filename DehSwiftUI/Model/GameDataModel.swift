//
//  GameDataModel.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2022/1/28.
//  Copyright © 2022 mmlab. All rights reserved.
//

import Foundation

class GameData:Decodable{
    var start_time:String
    var end_time:Int
    var play_time:Int
    var room_id:Int
    var id:Int
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case room_id = "room_id_id"
        case start_time = "start_time"
        case end_time = "end_time"
        case play_time = "play_time"
    }
    init() {
        start_time = ""
        end_time = -1
        play_time = 0
        room_id = -1
        id = -1
    }
}
