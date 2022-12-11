//
//  NetworkCombineTest.swift
//  DehSwiftUI
//
//  Created by mmlab on 2020/12/23.
//  Copyright © 2020 mmlab. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class LoginHandler: APIHandler {
    
    @Published var ResponseFormat: ResponseFormat?
    @Published var isLoading = false
            
    func getRandomDog() {
        isLoading = true
        
        let url = "https://random.dog/woof.json"
        
        AF.request(url, method: .post).responseDecodable { [weak self] (response: DataResponse<ResponseFormat, AFError>) in
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? ResponseFormat else {
                weakSelf.isLoading = false
                return
            }
                            
            weakSelf.isLoading = false
            weakSelf.ResponseFormat = response
        }
    }
    
}
