//
//  NetworkConnector.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/29.
//  Copyright © 2020 mmlab. All rights reserved.
//

import SwiftUI
import Alamofire

class NetworkConnector{
    
    func getDataPublisherDecodable<T:Decodable>(url: String, para: Parameters) ->  DataResponsePublisher<T> {
        return AF.request(url, method: .post, parameters: para)
            .publishDecodable(type: T.self, queue: .main)
    }
    func getDataPublisherData(url: String, para: Parameters) ->  DataResponsePublisher<XOI> {
        return AF.request(url, method: .post, parameters: para)
            .publishDecodable(type: XOI.self, queue: .main)
    }
    func getDataPublisher(url: String, para: Parameters) -> DataResponsePublisher<Data> {
        return AF.request(url, method: .post, parameters: para)
            .publishData()
    }
    func getMediaPublisher(url: String) -> DataResponsePublisher<Data> {
        return AF.request(url, method: .get)
            .validate()
              .responseData(emptyResponseCodes: [200, 204, 205]) { response in
               debugPrint(response)
              }
            
            .publishData()
    }
    func getMediaPublisher(url: URL) -> DataResponsePublisher<Data> {
        return AF.request(url, method: .get)
            .validate()
              .responseData(emptyResponseCodes: [200, 204, 205]) { response in
               debugPrint(response)
              }
            
            .publishData()
    }
    func uploadMediaPublisher<T:Decodable>(url: String, para: Parameters,inputData:Data)->  DataResponsePublisher<T>{
        return AF.upload(multipartFormData: { (data) in
//                    let imageData = UIImage().jpegData(compressionQuality: 0.9)
            for(key,value) in para{
                if let valueData = (value as? String)?.data(using: String.Encoding.utf8){
                    data.append(valueData, withName: key)
                }
                
            }
                    data.append(inputData, withName: "imageData")
                    
                }, to: url)
                    .publishDecodable(type: T.self, queue: .main)
    }
    
    
}


