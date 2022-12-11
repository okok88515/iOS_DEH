//
//  PrizeDetailView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/11/3.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine

struct PrizeDetailView: View {
    @State var prize:Prize
    @State var prizeName:String = ""
    @State var cancellable:AnyCancellable?
    @State var image:UIImage?
    init(prize:Prize) {
        self.prize = prize
        
    }
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Prize Item".localized)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                Text(prizeName)
                    .font(.body)
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .frame( maxWidth: 250, maxHeight: 250,alignment: .center)
            }
            NavigationLink(destination: QRcodeView(prize:prize)) {
                Text("Exchange".localized)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 20)
                    .foregroundColor(.white)
                    .background(Color(UIColor(rgba: lightGreen)))
            }
        }
        .onAppear {
            getPrizeAttribute()
        }
        
    }
}
extension PrizeDetailView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getPrizeAttribute() {
        let url = GamePrizeAttributeUrl
        let parameters = ["player_prize_id": prize.id ?? -1]
        let publisher: DataResponsePublisher<[Prize]> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        cancellable = publisher.sink(receiveValue: { (values) in
            print(values.debugDescription)
            if let prizeAttribute = values.value {
                prizeName = prizeAttribute[0].name ?? ""
                let prizeImg = prizeAttribute[0].img ?? ""
                var tempUrl = prizeImg
                if let idx = tempUrl.firstIndex(of: "/") {
                    tempUrl = String(tempUrl.suffix(from: idx))
                }
                let imgUrl = URL(string: "http://deh.csie.ncku.edu.tw" + tempUrl)
                self.getData(from: imgUrl!) { data, response, error in
                    guard let data = data, error == nil else {return}
                    print("Download Finished")
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data, scale: 1)
                        
                    }
                }
                
            }
        })
        
    }
}

struct PrizeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PrizeDetailView(prize: Prize(id: 0, ptpId: 0, startTime: "", name: "", img: ""))
    }
}
