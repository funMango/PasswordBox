//
//  AccountEncrytor.swift
//  PasswordBox
//
//  Created by 이민호 on 9/15/25.
//

import Foundation
import CryptoKit

struct AccountEncryptor {
    private let crypto = CryptoManager()
    
    func toDTO(entity: Account) throws -> AccountDTO {
        let dto = AccountDTO(
            id: entity.id,
            sitename: entity.sitename,
            username: try crypto.encryptString(entity.username),
            password: try crypto.encryptString(entity.password),
            pin: entity.pin != nil ? try crypto.encryptString(entity.pin!) : nil,
            memo: entity.memo != nil ? try crypto.encryptString(entity.memo!) : nil,
            createDate: entity.createDate,
            updateDate: entity.updateDate
        )
        return dto
    }
    
    func toEntity(dto: AccountDTO) throws -> Account {
        return Account(
            id: dto.id,
            sitename: dto.sitename,
            username: try crypto.decryptString(dto.username),
            password: try crypto.decryptString(dto.password),
            pin: dto.pin != nil ? try crypto.decryptString(dto.pin!) : nil,
            memo: dto.memo != nil ? try crypto.decryptString(dto.memo!) : nil,
            createDate: dto.createDate,
            updateDate: dto.updateDate
        )
    }
}
