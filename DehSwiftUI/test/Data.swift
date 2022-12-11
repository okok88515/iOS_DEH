//
//  Data.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/3.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI

var testxoi:[XOI] = [
    XOI(id: 0, name: "name", latitude: 22.997, longitude: 120.221, creatorCategory: "expert",  xoiCategory: "poi", detail: "detail", viewNumbers: 100, mediaCategory: "image"),
    XOI(id: 1, name: "name1", latitude: 22.987, longitude: 120.221, creatorCategory: "user",  xoiCategory: "poi", detail: "detail", viewNumbers: 100, mediaCategory: "image"),
    XOI(id: 2, name: "name2", latitude: 0.0, longitude: 0.0, creatorCategory: "user",  xoiCategory: "poi", detail: "detail", viewNumbers: 100, mediaCategory: "image"),
    XOI(id: 3, name: "name3", latitude: 0.0, longitude: 0.0, creatorCategory: "user",  xoiCategory: "poi", detail: "detail", viewNumbers: 100, mediaCategory: "image"),
]
var testGroup = Group(id: -1, name: "", leaderId: -1, info: "")
var testSession = SessionModel(id: -1, name: "", gameID: 0, status: "")
//var testChest = ChestModel(id: 39, srcID: 0, latitude: 0, longitude: 0, avaliableNumber: 0, remainNumber: 0, point: 0, discoverDistance: 0, questionType: 0, option1: "", option2: "", option3: "", option4: "", hint1: "", hint2: "", hint3: "", hint4: "", question: "", answer: "", gameID: 0, poiID: 0)
var testChest = ChestModel(id: 39, srcID: 4, latitude: 22.997, longitude: 120.222, avaliableNumber: 20, remainNumber: 200, point: 49, discoverDistance: 2000, questionType: 2, question: "TTTTTT", answer: "T", gameID: 21)
