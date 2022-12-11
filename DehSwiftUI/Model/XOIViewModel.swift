//
//  WoofResponse.swift
//  DehSwiftUI
//
//  Created by mmlab on 2020/12/23.
//  Copyright © 2020 mmlab. All rights reserved.
//
import SwiftUI
import Alamofire

final class XOIViewModel:ObservableObject, Decodable{
    @Published var XOIs:[String:[XOI]] = [
        "favorite" : [],
        "nearby" : [],
        "group" : [],
        "mine" : [],
    ]
    enum CodingKeys: String, CodingKey {
        case XOIs = "results"
    }
    init(){}
    init(from decoder: Decoder) throws {
        print("start decode...")
        do{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.XOIs["group"] = try container.decode([XOI].self, forKey: .XOIs)
        }catch{
            print("出現錯誤 ： \(error)")
        }
    }
    
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
    
    func getData(url: String, para: Dictionary<String, String>) {
        print("getData..."+url)
        AF.request(url, method: .post, parameters: para)
            .responseDecodable { [weak self] (response: DataResponse<XOIViewModel, AFError>) in
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? XOIViewModel else {
                print("response error...")
                return
            }
            self?.XOIs = response.XOIs
            print(self?.XOIs["group"]?.first?.id ?? 8787)
        }
    }
}

