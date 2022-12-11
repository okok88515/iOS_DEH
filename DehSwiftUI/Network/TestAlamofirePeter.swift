//
//  TestAlamofire.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/22.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine
struct UploadImageResult: Decodable {
    struct Data: Decodable {
        let link: URL
    }
    let data: Data
}
struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
        }
    }

struct ContentView2: View {
    @State private var cancellable: AnyCancellable?
    @State var image:UIImage = UIImage()
    let testImage = "http://deh.csie.ncku.edu.tw/player_pictures/media/20200723024057_Hyb-WnUev.jpeg"
    func upload2(){
        let parameters:Parameters = [
            "user_name" : "GuestFromIosLite/Micro",
            "coi_name" : "deh",
        ]
        let url = GroupGetListUrl
        let publisher = NetworkConnector().getDataPublisher(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
//                print(values.data?.JsonPrint())
                print("")
            })
    }
    func upload(){
        let _:Parameters = [
            "username" : "et00",
            "password" : "et00".md5(),
            "coi_name" : "deh",
            "lat" : "22.997",
            "lng" : "120.221",
            "dis" : "10000",
            "num" : "3",
            "action":"",
            "dveviceID":"",
            "poi_id" : "7",
            "user_id": "2947",
            
        ]
        let url = testImage
        
            
        let publisher:DataResponsePublisher = NetworkConnector().getDataPublisher(url: url, para: Parameters())
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
//                print(values.data?.JsonPrint())
                print(values.value.debugDescription)
                image = UIImage(data: values.data ?? Data()) ?? UIImage()
            })
    }
    
    var body: some View {
        
        
        VStack(spacing: 15) {
            Image(uiImage: image).resizable()
            Button(action: {
                self.upload()
            }) {
                Text("upload")
            }
        }
        .onDisappear {
            self.cancellable = nil
        }
        
    }
}

