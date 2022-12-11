//
//  ImageWithNumber.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/13.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI

struct ImageWithNumber: View {
    var number: Int
//    var xoiCategory: String
    var body: some View {
        ZStack{
            Image("player_pin_b")
            Text(String(number+1))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.black )
        }
        
    }
}

struct ImageWithNumber_Previews: PreviewProvider {
    static var previews: some View {
        ImageWithNumber(number: 1)
    }
}

