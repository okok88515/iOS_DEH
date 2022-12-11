//
//  IntExtension.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/1/20.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation

extension Int{
///    to set a border that avoid to get over the index
    func lowBound(_ lowBound:Int) -> Int{
        if self < lowBound{
            return lowBound
        }
        else{
            return self
        }
        
    }
}
