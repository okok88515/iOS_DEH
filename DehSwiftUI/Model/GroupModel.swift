//
//  GroupModel.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/14.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire



class Group:Identifiable,Decodable,Hashable {
    
    var id:Int
    var name:String
    var leaderId:Int?
    var info:String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case leaderId = "learderId"
        case info = "group_info"
    }
    init(id:Int,name:String, leaderId:Int, info:String) {
        self.id = id
        self.name = name
        self.leaderId = leaderId
        self.info = info
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
}
class GroupMember:Decodable,Identifiable {
    var memberName:String
    var memberRole:String
    enum CodingKeys:String, CodingKey {
        case memberName = "member_name"
        case memberRole = "member_role"
    }
    init(memberName:String, memberRole:String) {
        self.memberName = memberName
        self.memberRole = memberRole
    }
}
class GroupName:Decodable,Identifiable {
    var name:String
    init(name:String) {
        self.name = name
    }
    
    enum CodingKeys:String, CodingKey {
        case name = "group_name"
    }
}
class GroupNotification:Decodable, Identifiable,Equatable {
    var groupName:String
    var senderName:String
    var messageType:String
    var groupId:Int
    
    static func == (lhs: GroupNotification, rhs: GroupNotification) -> Bool {
        return lhs.groupId == rhs.groupId
    }
    
    
    enum CodingKeys:String, CodingKey {
        case groupName = "group_name"
        case senderName = "sender_name"
        case messageType = "group_role"
        case groupId = "group_id"
    }
}

class GroupMessage:Decodable {
    var message:String
}
class GroupMemberList:Decodable {
    let result:[GroupMember]
}
