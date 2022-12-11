//
//  testfile.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/2.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI

class ExternalModel: ObservableObject {
    @Published var textToUpdate: String = "Update me!"
    func registerRequest() {
        // other functionality
        textToUpdate = "I've been updated!"
    }
}

struct UpdateTextViewExternal: View {
    @ObservedObject var viewModel: ExternalModel
    var body: some View {
        VStack {
            Button(action: {
                self.viewModel.registerRequest()
            }) {
                Text("SignUp")
            }
            Text(self.viewModel.textToUpdate)
        }
    }
}

struct UpdateTextViewExternal_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTextViewExternal(viewModel: ExternalModel())
    }
}
