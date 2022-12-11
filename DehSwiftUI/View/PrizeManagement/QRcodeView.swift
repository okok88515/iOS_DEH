//
//  QRcodeView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2021/11/4.
//  Copyright © 2021 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire
import Combine
struct QRcodeView: View {
    @State var prize:Prize
    @State var cancellable:AnyCancellable?
    @State var QRcode:UIImage?
    init(prize:Prize) {
        self.prize = prize
    }
    var body: some View {
        VStack {
            Text("Prize Exchange".localized)
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Image(uiImage: QRcode ?? UIImage())
                .resizable()
                .frame( maxWidth: 250, maxHeight: 250, alignment: .center)
        }
        .onAppear {
            getQRcode()
        }
        
    }
}
extension QRcodeView {
    func getQRcode() {
        let url = qrCodeAPI + requestURL + String(describing: prize.ptpId)
        let publisher:DataResponsePublisher<Data> = AF.request(url, method: .get)
            .publishDecodable(type: Data.self, queue: .main)
        self.cancellable = publisher.sink(receiveValue: { data in
            QRcode = UIImage(data: data.data!, scale: 1)
            
        })
    }
}

struct QRcodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRcodeView(prize: Prize(id: 0, ptpId: 0, startTime: "", name: "", img: ""))
    }
}
