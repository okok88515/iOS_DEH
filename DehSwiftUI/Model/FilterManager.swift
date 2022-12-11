//
//  FilterModel.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2022/1/23.
//  Copyright © 2022 mmlab. All rights reserved.
//

import Foundation

final class FilterManager:ObservableObject {
    let ids = ["All".localized, "Expert's map".localized, "User's map".localized, "Docent's map".localized]
    let types = ["All".localized, "Image".localized, "Audio".localized, "Video".localized]
    let formats = ["All".localized,"Historical Site, Buildings".localized,"Ruins".localized,"Cultural Landscape".localized,"Natural Landscape".localized,"Traditional Art".localized,"Cultural Artifacts".localized,"Antique".localized,"Necessities of Life".localized,"Others".localized]
    @Published var filterState = false
    @Published var showFilterButton = true
    @Published var index:[String:Int] = ["id":0,"type":0,"format":0]
    @Published var pickerState = false
    @Published var key = ""
}
