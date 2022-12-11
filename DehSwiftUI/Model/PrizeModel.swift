//
//  PriceModel.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/11/3.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import SwiftUI

class Prize:Decodable,Identifiable {
    var id:Int?
    var ptpId:Int?
    var startTime:String?
    var name:String?
    var img:String?
    
    init(id:Int, ptpId:Int, startTime:String, name:String, img:String) {
        self.id = id
        self.ptpId = ptpId
        self.startTime = startTime
        self.name = name
        self.img = img
    }
    enum CodingKeys: String, CodingKey {
        case id = "player_prize_id"
        case ptpId = "PTP_id"
        case startTime = "start_time"
        case name = "prize_name"
        case img = "prize_url"
    }
}
