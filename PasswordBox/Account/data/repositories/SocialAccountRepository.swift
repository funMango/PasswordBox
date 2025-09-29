//
//  SocialAccountRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 9/25/25.
//

import Foundation
import Resolver
import SwiftData

protocol SocialAccountRepository {
    func save(_ socialAccount: SocialAccount)
}

class DefaultSocialAccount: SocialAccountRepository {
    @Injected var modelContext: ModelContext
    private var encryptor = SocialAccountEncryptor()
    
    func save(_ socialAccount: SocialAccount) {
        do {
            let dto = try encryptor.toDTO(entity: socialAccount)
            modelContext.insert(dto)
            try modelContext.save()
            print("💾 SocialAccount 저장완료 (id: \(socialAccount.id), site: \(socialAccount.sitename))")
        } catch {
            print("⚠️ SocialAccount 저장 실패: \(error)")
        }
    }
}
