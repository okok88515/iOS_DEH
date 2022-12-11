//
//  MD5Extension.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/11.
//  Copyright © 2020 mmlab. All rights reserved.
//https://gist.github.com/shnhrrsn/c55f1e686b4bdf0d78d62b456fc2a3a1
//https://stackoverflow.com/a/60451938
//基於CommonCrypto的舊有code會噴warning 

import Foundation
import CommonCrypto
import CryptoKit

extension Insecure.MD5: ByteCountable { }
private protocol ByteCountable {
  static var byteCount: Int { get }
}
//MD5
extension String {
    func md5() -> String {
        let result = Insecure.MD5.hash(data: self.data(using: .utf8)!).prefix(Insecure.MD5.byteCount).map{
            String(format: "%02hhx", $0)
          }.joined()
        return result
    }

}
