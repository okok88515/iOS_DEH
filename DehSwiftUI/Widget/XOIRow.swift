//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by 阮盟雄 on 2020/11/17.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct XOIRow: View {
    var xoi: XOI
    var tabItemName:String
    var body: some View {
        ZStack{
            NavigationLink(destination:  XOIDetail(xoi:xoi)){
                HStack{
                    Image(xoi.xoiCategory.checkImageExist(defaultPic: "none"))
                    Image(secondImage(xoi.creatorCategory.checkImageExist(defaultPic: "none")))
    //                多媒體處理尚未解決
                    Image(xoi.mediaCategory.checkImageExist(defaultPic: "none"))
                    Text(xoi.name)
                        .foregroundColor(Color.white)
                        .allowsTightening(true)
                        .lineLimit(1)
                    
                    //here cause Trying to pop to a missing destination at and no solution
    //                Spacer()
                }
                .background(Color.init(UIColor(rgba:darkGreen)))
            }
        
            
            
        
    }
    }
}
extension XOIRow{
    func secondImage(_ originalString:String) -> String{
        if self.tabItemName != "mine" {
            return originalString
        }
        else if xoi.open == true{
            return "public"
        }
        else if xoi.open == false{
            return "private"
        }
        else{
            return "none"
        }
    }
}
struct XOIRow_Previews: PreviewProvider {
    static var previews: some View {
        XOIRow(xoi: testxoi[0], tabItemName: "mine")
            .environmentObject(SettingStorage())
    }
}
