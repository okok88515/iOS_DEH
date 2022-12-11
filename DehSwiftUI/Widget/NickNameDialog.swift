//
//  NickNameAlertView.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2022/1/2.
//  Copyright © 2022 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
struct NickNameDialog: View {
    @State var account:String = ""
    @State private var cancellable: AnyCancellable?
    @State var alertState:Bool = false
    @State var showLoginDialog:Bool = false
    @EnvironmentObject var settingStorage:SettingStorage
    @Binding var show:Bool
    var body: some View {
            VStack {
                Text("Nickname".localized)
                    .padding(.top)
                TextField("name".localized, text: $account)
                    .keyboardType(.asciiCapable)
                    .disableAutocorrection(true)
                    .frame(height: 35)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.1))
                    
                Button("Do you have an account?"){
                    showLoginDialog = true
                }
                .padding([.horizontal,.bottom])
                .frame(width:UIScreen.main.bounds.width-30, alignment: .leading)
                Divider()
                HStack {
                    Button("Cancel".localized){
                        show.toggle()
                    }
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    Button("OK".localized){
                        if account != "" {
                            createTempAccount(name: account)
                            show.toggle()
                        }
                        else {
                            alertState = true
                        }
                    }
                    .alert(isPresented: $alertState) {() -> Alert in
                        return Alert(title: Text("Please enter your nickname".localized),
                                     dismissButton:.default(Text("OK".localized), action: {
                        })
                        )
                    }
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)

                }
                .padding(.bottom)
            }
            .frame(width: UIScreen.main.bounds.width-30, height: 200)
            .background(Color.white)
            .cornerRadius(12)
            .clipped()
            if showLoginDialog {
                LoginDialog(showLoginDialog: $showLoginDialog, showNicknameDialog: $show)
            }
        
        
    }
}
extension NickNameDialog {
    func createTempAccount(name:String) {
        let url = CreateTempAccountUrl
        let parameters = ["user_name":name]
        let publisher:DataResponsePublisher<NickAccount> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher.sink(receiveValue: { values in
            settingStorage.account = values.value?.account ?? ""
            settingStorage.password = values.value?.password ?? ""
            settingStorage.userID = String(values.value?.id ?? -1)
        })
    }
}

struct NickNameAlertView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameDialog(show: .constant(false))
    }
}
