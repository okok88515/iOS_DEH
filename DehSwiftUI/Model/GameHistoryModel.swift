//
//  GameHistoryModel.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/29.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import SwiftUI

class GameHistoryModel:Decodable,Hashable,Identifiable{
    var id:Int
    var startTime:String
    var name:String?
    let isoFormatter = ISO8601DateFormatter()
    init(id:Int,startTime:String) {
        self.id = id
        self.startTime = startTime
        
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoFormatter.date(from: self.startTime){
            self.name = "\(date)"
        }
        else{
            self.name = "no date"
        }
    }
    required init(from decoder:Decoder){
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            startTime = try container.decode(String.self, forKey: .startTime)
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = isoFormatter.date(from: startTime){
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm E, d MMM y"
                name = formatter.string(from:date)
            }
            else{
                name = "no date"
            }
        }
        catch{
            id = -1
            startTime = ""
            name = "decode error"
        }
    }
    enum CodingKeys: String, CodingKey{
        case id
        case startTime = "start_time"
        case name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: GameHistoryModel, rhs: GameHistoryModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class gameListtuple : Identifiable, Hashable{
    var id = UUID()
    var sectionName:String = ""
    var groupList:[Group] = []
    init(_ sectionName:String, _ groupList:[Group]) {
        self.sectionName = sectionName
        self.groupList = groupList
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: gameListtuple, rhs: gameListtuple) -> Bool {
        return lhs.id == rhs.id
    }
}

class ScoreRecord:Decodable {
    var answer:String
    var chest_id:Int
    var correctness:Int
    var option1:String?
    var option2:String?
    var option3:String?
    var option4:String?
    var point:Int
    var question:String
    var question_type:Int
    
    enum CodingKeys: String, CodingKey{
        case answer
        case chest_id = "chest_id_id"
        case correctness
        case option1
        case option2
        case option3
        case option4
        case point
        case question
        case question_type
    }
}
