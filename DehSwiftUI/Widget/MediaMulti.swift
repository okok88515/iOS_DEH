//
//  Media.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/1/20.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import AVKit
enum format:Int{
    case Commentary = 8
    case Video = 4
    case Voice = 2
    case Picture = 1
    case Default = 0
}
class MediaMulti {
//    var id:Int
    var mediaFormat:format = .Default
    var data:Data
    
    var player : AVPlayer?
    
    init(data:Data,format:format) {
        self.data = data
        self.mediaFormat = format
        if(self.mediaFormat == .Video){
            self.player = AVPlayer(url:dataToUrl(data:data))
        }
        
    }
    @ViewBuilder func view() -> some View{
        switch self.mediaFormat {
        case .Commentary:
            Button(action: {
                Sounds.playSounds(soundData: self.data)
            }, label: {
                Image("audio_picture")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 400)
            })
        case .Video:
            VideoPlayer(player:player)
        case .Voice:
            Button(action: {
                Sounds.playSounds(soundData: self.data)
            }, label: {
                Image("audio_picture")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 400)
            })
        case .Picture:
            Image(uiImage:UIImage(data: data ) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 400)
        default:
            Image("none")
        }
    }
}
extension MediaMulti{
    func dataToUrl(data:Data) -> URL{
        let tmpFileURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent("video").appendingPathExtension("mp4")
        let wasFileWritten = (try? data.write(to: tmpFileURL, options: [.atomic])) != nil

        if !wasFileWritten{
            print("File was NOT Written")
        }
        return tmpFileURL
    }
}
