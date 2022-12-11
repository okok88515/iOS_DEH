//
//  GameMemberPoint.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/9/8.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
struct GameMemberPoint: View {
    @EnvironmentObject var settingStorage:SettingStorage
    @State private var cancellable: AnyCancellable?
    @State var roomID:Int = -1
    @State var gameID:Int = -1
    @State var gamePointList :[GamePointModel] = []
    var body: some View {
        List{
            ForEach(gamePointList,id:\.id){
                gamePoint in
                HStack{
                    Text(gamePoint.name)
                        .foregroundColor(Color.white)
                        .allowsTightening(true)
                        .lineLimit(1)
                        .background(Color.init(UIColor(rgba:lightGreen)))
                    Spacer()
                    Text("Point:\(gamePoint.point)")
                        .foregroundColor(Color.white)
                }
                .listRowBackground(Color.init(UIColor(rgba: lightGreen)))
//                NavigationLink(
//                    destination: GameMemberPoint( roomID: self.roomID,gameID: gamePoint.id),
            }
        }
        .onAppear(){
            getMemberPoint()
        }
    }
    
}

extension GameMemberPoint{
    func getMemberPoint(){
        let url = getMemberPointUrl
        let parameters:[String:String] = [
            "room_id": "\(roomID)",
            "game_id": "\(gameID)",
            "user_id": "\(settingStorage.userID)",
            "rank": "1",
        ]
        let publisher:DataResponsePublisher<[GamePointModel]> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                print(values.debugDescription)
                print(Date())
                if let value = values.value{
                    self.gamePointList = value
                    removeUncorrectness()
                }
                
            })
    }
    func removeUncorrectness(){
        for gamePoint in gamePointList{
            if gamePoint.correctness == false{
                gamePointList.remove(at: gamePointList.firstIndex(where: {$0 === gamePoint}) ?? 0)
            }
        }
    }
}

struct GameMemberPoint_Previews: PreviewProvider {
    static var previews: some View {
        GameMemberPoint()
    }
}
