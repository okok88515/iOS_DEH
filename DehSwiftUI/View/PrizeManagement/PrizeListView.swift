//
//  PrizeListView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/11/3.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine

struct PrizeListView: View {
    @State var prizeList:[Prize] = []
    @State private var cancellable: AnyCancellable?
    @EnvironmentObject var settingStorage:SettingStorage
    
    var body: some View {
        VStack {
            VStack {
                Text("Prize List".localized)
                    .font(.title)
                    .padding(.top)
                    .foregroundColor(.white)
                Link(destination: URL(string: "http://deh.csie.ncku.edu.tw")!) {
                    Text("Go to the website".localized)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(Color.black)
                        .background(Color.gray)
                }
            }
            List {
                ForEach(self.prizeList) { prize in
                    NavigationLink(destination: PrizeDetailView(prize: prize)) {
                        Text(prize.startTime ?? "")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(.white)
                    }
                    
                }
                .listRowBackground(Color(UIColor(rgba: lightGreen)))
            }
//            .listStyle(PlainListStyle())
        }
        .background(Color(UIColor(rgba: darkGreen)))
        .onAppear {
            getPrizeList()
        }
        
        
    }
}
extension PrizeListView {
    
    func getPrizeList() {
        let url = PrizeGetListUrl
        let parameters = ["user_id":settingStorage.userID]
        let publisher: DataResponsePublisher<[Prize]> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        cancellable = publisher.sink(receiveValue: { (values) in
            print(values.debugDescription)
            self.prizeList = values.value ?? []
        })
    }
}


struct PrizeListView_Previews: PreviewProvider {
    static var previews: some View {
        PrizeListView()
    }
}
