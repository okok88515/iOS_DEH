//
//  GameHistoryView.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/4/29.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
struct GameHistoryView: View {
    @State private var showingSheet = false
    @State var selection: Int? = nil
    @State var roomID:Int = -1
    @State var gameHistoryList :[GameHistoryModel] = []
    @EnvironmentObject var settingStorage:SettingStorage
    @State private var cancellable: AnyCancellable?
    var body: some View {
        List{
            ForEach(gameHistoryList,id:\.id){
                gameHistory in
                NavigationLink(
                    destination: GameMemberPoint( roomID: self.roomID,
                                                  gameID: gameHistory.id),
                    label: {
                            Text(gameHistory.name ?? "error" )
                                .foregroundColor(Color.white)
                                .allowsTightening(true)
                                .lineLimit(1)
                                .background(Color.init(UIColor(rgba:lightGreen)))

                       
                    })
                    .listRowBackground(Color.init(UIColor(rgba: lightGreen)))
            }
        }
            .onAppear(){
                getHistory()
            }
    }
}
extension GameHistoryView{
    func getHistory(){
        let url = getGameHistory
        let parameters:[String:String] = [
            "room_id": "\(roomID)"
        ]
        let publisher:DataResponsePublisher<[GameHistoryModel]> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
//                print(values.data?.JsonPrint())
                print(values.debugDescription)
                print(Date())
                if let value = values.value{
                    self.gameHistoryList = value
//                    let isoFormatter = ISO8601DateFormatter()
//                    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//                    let date = isoFormatter.date(from: self.gameHistoryList[0].startTime)
//                    print(date)
                }
                
            })
    }
}
struct GameHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GameHistoryView()
    }
}
