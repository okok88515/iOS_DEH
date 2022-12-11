//
//  LoginDialog.swift
//  DehSwiftUI
//
//  Created by 陳家庠 on 2022/1/2.
//  Copyright © 2022 mmlab. All rights reserved.
//

import SwiftUI
import Combine
import Alamofire
enum ActiveAlert {
    case fail, success
}
struct LoginDialog: View {
    @State var account:String = ""
    @State var password:String = ""
    @State private var cancellable: AnyCancellable?
    @State var alertState:Bool = false
    @State var activeAlert:ActiveAlert = .fail
    @EnvironmentObject var settingStorage:SettingStorage
    @Binding var showLoginDialog:Bool
    @Binding var showNicknameDialog:Bool
    var body: some View {
        VStack{
            Text("User login")
            TextField("Account".localized, text: $account)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .frame(height: 35)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
            SecureField("Password".localized, text: $password)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .frame(height: 35)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
            Divider()
            HStack {
                Button("Cancel".localized){
                    showLoginDialog.toggle()
                }
                .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                Button("OK".localized){
                    login()
                }
                .alert(isPresented: $alertState) {() -> Alert in
                    switch activeAlert {
                    case .fail:
                        return Alert(title: Text("Account or Password is not correct".localized.localized),
                                     dismissButton:.default(Text("OK".localized), action: {
                        })
                        )
                    case .success:
                        return Alert(title: Text("Login Success".localized),
                                     dismissButton:.default(Text("OK".localized), action: {
                            showLoginDialog.toggle()
                            showNicknameDialog.toggle()
                        })
                        )
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 200)
        .background(Color.white)
        .cornerRadius(12)
        .clipped()
    }
}
extension LoginDialog {
    func login() {
        let parameters:Parameters = [
            "username" : self.account,
            "password" : self.password.md5(),
            "coi_name" : coi,
        ]
        let url = UserLoginUrl
        let publisher:DataResponsePublisher<LoginModel> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                if let _ = values.value?.message{
                    print("User" + "\(values.value?.message ?? "Not Found")")
                    self.activeAlert = .fail
                    self.alertState = true
                }
                else{
                    self.settingStorage.account = self.account
                    self.settingStorage.password = self.password.md5()
                    self.settingStorage.userID = "\(values.value?.user_id ?? 0)"
                    self.settingStorage.loginState = true
                    self.activeAlert = .success
                    self.alertState = true
                }
            })
    }
}

struct LoginDialog_Previews: PreviewProvider {
    static var previews: some View {
        LoginDialog(showLoginDialog: .constant(false),showNicknameDialog:.constant(false))
    }
}
