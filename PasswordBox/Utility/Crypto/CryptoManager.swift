//
//  CryptoManager.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import Foundation

struct CryptoManager {
    private let keyStore = KeychainDEKStore()
    private let crypto = CryptoService()
    
    private var dek: Data {
        (try? keyStore.createAndStoreIfNeeded()) ?? Data()
    }
    
    func encryptString(_ value: String) throws -> Data {
        try crypto.encrypt(plaintext: Data(value.utf8), keyData: dek)
    }
    
    func decryptString(_ data: Data) throws -> String {
        let plain = try crypto.decrypt(combined: data, keyData: dek)
        return String(data: plain, encoding: .utf8)!
    }
}
