//
//  CryptoService.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import Foundation
import CryptoKit

struct CryptoService {
    enum CryptoError: Error { case invalidSealedBox }
    
    /// 암호화 (AES-GCM)
    func encrypt(plaintext: Data, keyData: Data, aad: Data? = nil) throws -> Data {
        let key = SymmetricKey(data: keyData)
        let sealedBox = try AES.GCM.seal(plaintext, using: key, authenticating: aad ?? Data())
        
        guard let combined = sealedBox.combined else {
            throw CryptoError.invalidSealedBox
        }
        return combined   // nonce + ciphertext + tag
    }
    
    /// 복호화 (AES-GCM)
    func decrypt(combined: Data, keyData: Data, aad: Data? = nil) throws -> Data {
        let key = SymmetricKey(data: keyData)
        let box = try AES.GCM.SealedBox(combined: combined)
        return try AES.GCM.open(box, using: key, authenticating: aad ?? Data())
    }
}
