//
//  KeychainDEKStore.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import Foundation
import Security

enum KeychainError: Error { case notFound, duplicate, unexpectedStatus(OSStatus) }

struct KeychainDEKStore {
    private let service = "com.yourcompany.passwordbox.dek"
    private let account = "data-encryption-key"

    /// 없으면 새로 생성하고, 있으면 기존 DEK 반환
    func createAndStoreIfNeeded() throws -> Data {
        if let existing = try? fetch() {
            return existing
        }
        // 32바이트 랜덤 키 생성
        var keyBytes = [UInt8](repeating: 0, count: 32)
        let status = SecRandomCopyBytes(kSecRandomDefault, keyBytes.count, &keyBytes)
        guard status == errSecSuccess else { throw KeychainError.unexpectedStatus(status) }
        let keyData = Data(keyBytes)
        try add(keyData)
        return keyData
    }

    /// Keychain에서 기존 키 가져오기
    func fetch() throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrSynchronizable as String: kSecAttrSynchronizableAny,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.notFound }
        guard status == errSecSuccess, let data = item as? Data else {
            throw KeychainError.unexpectedStatus(status)
        }
        return data
    }

    /// Keychain에 새 키 추가
    private func add(_ keyData: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrSynchronizable as String: kCFBooleanTrue as Any,   // 🔑 iCloud Keychain 동기화
            kSecValueData as String: keyData
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status != errSecDuplicateItem else { throw KeychainError.duplicate }
        guard status == errSecSuccess else { throw KeychainError.unexpectedStatus(status) }
    }
}
