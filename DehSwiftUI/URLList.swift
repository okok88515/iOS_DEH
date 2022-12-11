//
//  URLList.swift
//  DEH-Make-II
//
//  Created by Ray Chen on 2018/3/19.
//  Copyright © 2018年 Ray Chen. All rights reserved.
//

import Foundation

let UploadPOIUrl:           String = "http://deh.csie.ncku.edu.tw:8080/api/v1/pois/upload"
let POIDetailUrl:           String = "http://deh.csie.ncku.e`du.tw/poi_detail/"                       //Share POI used
let DEHHomePageUrl:         String = "http://deh.csie.ncku.edu.tw"
let ExpTainanHomePageUrl:   String = "http://exptainan.liberal.ncku.edu.tw/"
let SDCHomePageUrl:         String = "http://deh.csie.ncku.edu.tw/sdc"
let UserRegistUrl:          String = "http://deh.csie.ncku.edu.tw/regist/"
let UserLoginUrl:           String = "http://deh.csie.ncku.edu.tw:8080/api/v1/users/loginJSON"

let GetCOIListUrl:  String = "http://deh.csie.ncku.edu.tw:8080/api/v1/users/checkCOI"
//MARK:- XOIUrl
let POIClickCountUrl: String = "http://deh.csie.ncku.edu.tw:8080/api/v1/poi_count_click_with_column_name"

//MARK:- GroupUrl
let GroupMemberJoinUrl: String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/memberJoin"
let GroupGetNotifiUrl:  String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/notification"
let GroupGetGroupUrl:   String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/search"
let GroupInviteUrl:     String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/message"
let GroupGetMemberUrl:  String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/checkMembers"
let GroupCreatUrl:      String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/add"
let GroupUpdateUrl:     String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/update"
let GroupGetListUrl:    String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/groupList"
let GroupGetUserGroupListUrl:    String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/searchUserGroups"
let addGroupCountUrl:   String = "http://deh.csie.ncku.edu.tw:8080/api/v1/groups/addGroupLog"
//let addGroupCountUrl:   String = "http:/140.116.82.130:8080//groups/addGroupLog"
//MARK:- GameUrl
let NEW_DEH_API                = "http://deh.csie.ncku.edu.tw:8080/api/v1"
let _DEH_API                   = "http://140.116.82.130:8080/api/v1"
let qrCodeAPI = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data="
let requestURL = "http://deh.csie.ncku.edu.tw/prize_exchange/"
let GamePrizeAttributeUrl      = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_prize_attribute"
let GameGroupListUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_group_list"
let GameRoomListUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_room_list"
let GameIDUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_game_id"
let GameStartUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/start_game"
let GameHistoryUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_game_history"
let GameDataUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1//get_game_data"
let getUserAnswerRecord = "http://deh.csie.ncku.edu.tw:8080/api/v1/getUserAnswerRecord"
let privateGetGroupList = "http://deh.csie.ncku.edu.tw:8080/api/v1/getGroupList"
let getRoomList = "http://deh.csie.ncku.edu.tw:8080/api/v1/getRoomList"
let getGameHistory = "http://deh.csie.ncku.edu.tw:8080/api/v1/getGameHistory"
let getChestList = "http://deh.csie.ncku.edu.tw:8080/api/v1/getChestList"
let getChestMediaUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/getChestMedia"
let insertAnswerUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/insertAnswer"
let chestMinusUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/chestMinus"
let getMemberPointUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/getMemberPoint"
let getGameDataUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/getGameData"

let CreateTempAccountUrl:      String = "http://deh.csie.ncku.edu.tw:8080/api/v1/users/createtempaccount"
let AttachTempAccountUrl:      String = "http://deh.csie.ncku.edu.tw:8080/api/v1/users/attachtempaccount"

//MARK: -PriceUrl
let PrizeGetListUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/get_prize"

//MARK:- XoiUrl
let getPois = "http://deh.csie.ncku.edu.tw:8080/api/v1/users/poisJSON"
//let getXois = [
//    "/API/userPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/poisJSON",
//    "/API/userLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/loisJSON",
//    "/API/userAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/aoisJSON",
//    "/API/userSOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/soisJSON",
//]
let getXois = [
    "searchMyPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/poisJSONResponseNormalize",
    "searchMyLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/loisJSONResponseNormalize",
    "searchMyAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/aoisJSONResponseNormalize",
    "searchMySOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/users/soisJSONResponseNormalize",
    
    "searchGroupMyPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userPOIs",
    "searchGroupMyLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userLOIs",
    "searchGroupMyAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userAOIs",
    "searchGroupMySOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userSOIs",
    
    "searchGroupPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/nearbyPOIs",
    "searchGroupLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/nearbyLOIs",
    "searchGroupAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/nearbyAOIs",
    "searchGroupSOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/nearbySOIs",
    
    
]

let getNearbyXois = [
    "searchNearbyPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/nearby/pois",
    "searchNearbyLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/nearby/lois",
    "searchNearbyAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/nearby/aois",
    "searchNearbySOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/nearby/sois",
]
let addPoiCountUrl = "http://deh.csie.ncku.edu.tw:8080/api/v1/add_poi_log"
//let getGroupXois = [
//    "searchGroupPOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userPOIs",
//    "searchGroupLOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userLOIs",
//    "searchGroupAOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userAOIs",
//    "searchGroupSOI":"http://deh.csie.ncku.edu.tw:8080/api/v1/group/userSOIs",
//]
