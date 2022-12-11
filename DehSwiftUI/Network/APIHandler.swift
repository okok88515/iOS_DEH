//
//  APIHandler.swift
//  DehSwiftUI
//
//  Created by mmlab on 2020/12/23.
//  Copyright © 2020 mmlab. All rights reserved.
//

import Foundation

import Alamofire
import Combine

class APIHandler {
        
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
