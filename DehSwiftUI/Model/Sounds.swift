//
//  Sounds.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/1/20.
//  Copyright © 2021 mmlab. All rights reserved.
//

import Foundation
import AVFoundation

class Sounds {
    
    static var audioPlayer:AVAudioPlayer?
    var audioRecoder:AVAudioRecorder?
    var tempVideoFileUrl: URL {
        return FileManager.default.temporaryDirectory.appendingPathComponent("tempAudio")
    }
    
    static func playSounds(soundfile: String) {
        
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil){
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                
            }catch {
                print("Error")
            }
        }
    }
    static func playSounds(soundData: Data) {
        do{
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        catch {
            print("Error")
        }
    }
    
    func recordSounds(){
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do{
            audioRecoder = try AVAudioRecorder(url: tempVideoFileUrl,settings: settings)
            audioRecoder?.record()
        }
        catch{
            
        }
    }
    func stopRecord(){
        audioRecoder?.stop()
        
    }
    
}
