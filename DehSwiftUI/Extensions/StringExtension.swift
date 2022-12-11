//
//  StringExtension.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/10/9.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func hidden(_ shouldHide: Bool) ->String{
        switch shouldHide {
        case true: return ""
        case false: return self
        }
    }
}
