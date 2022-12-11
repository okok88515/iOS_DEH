//
//  PickerView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2022/1/10.
//  Copyright © 2022 mmlab. All rights reserved.
//

import SwiftUI
import CryptoKit

struct PickerView: View {
    var dataArray:[String]
    @Binding var myViewState:Bool
    @Binding var indexSelection:Int
    var body: some View {
        Picker(selection: $indexSelection) {
            ForEach(dataArray.indices) { item in
                Button {
                    myViewState = false
                } label: {
                    Text(dataArray[item]).tag(item)
                }
            }
        } label: {
        }
        .pickerStyle(.wheel)
        .frame(width: UIScreen.main.bounds.width,height: 150)
        .background(Color.white)
        .cornerRadius(12)
        .clipped()
        
        
    }
}


struct PickerView_Previews: PreviewProvider {
    @State static var test = false
    @State static var index = 0
    static var previews: some View {
        PickerView(dataArray: ["1","2","3"], myViewState: $test, indexSelection: $index)
    }
}
