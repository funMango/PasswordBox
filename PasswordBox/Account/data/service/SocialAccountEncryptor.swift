//
//  SocialAccountEncryptor.swift
//  PasswordBox
//
//  Created by 이민호 on 9/25/25.
//

import Foundation
import CryptoKit

struct SocialAccountEncryptor {
    private let crypto = CryptoManager()
    
    func toDTO(entity: SocialAccount) throws -> SocialAccountDTO {
        let dto = SocialAccountDTO(
            id: entity.id,
            sitename: entity.sitename,
            socialSitename: try crypto.encryptString(entity.socialSitename),
            username: entity.username != nil ? try crypto.encryptString(entity.username!) : nil,
            accountId: entity.accountId != nil ? try crypto.encryptString(entity.accountId!) : nil,
            createDate: entity.createDate,
            updateDate: entity.updateDate
        )
        return dto
    }
    
    func toEntity(dto: SocialAccountDTO) throws -> SocialAccount {
        return SocialAccount(
            id: dto.id,
            sitename: dto.sitename,
            socialSitename: try crypto.decryptString(dto.socialSitename),
            username: dto.username != nil ? try crypto.decryptString(dto.username!) : nil,
            accountId: dto.accountId != nil ? try crypto.decryptString(dto.accountId!) : nil,
            createDate: dto.createDate,
            updateDate: dto.updateDate
        )
    }
}
