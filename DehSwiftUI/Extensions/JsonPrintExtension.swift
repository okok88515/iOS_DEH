//
//  JsonPrintExtension.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/1/14.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation

extension Data{
    func JsonPrint() ->String{
        return String(data: self , encoding: .utf8) ?? "decode Json Failed"
    }
}
