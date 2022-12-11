//
//  ViewExtension.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/15.
//  Copyright © 2020 mmlab. All rights reserved.
//https://github.com/George-J-E/HidingViews

import SwiftUI
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
//to hide view without error
extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}

