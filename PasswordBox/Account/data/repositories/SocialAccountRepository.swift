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
    func fetch() -> [SocialAccount]
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
    
    func fetch() -> [SocialAccount] {
        let accountDTOs: [SocialAccountDTO] = fetchDTO()
        var socialAccounts: [SocialAccount] = []
        
        for dto in accountDTOs {
            do {
                let socialAccount = try encryptor.toEntity(dto: dto)
                socialAccounts.append(socialAccount)
            } catch {
                print("⚠️ 복호화 실패 (id: \(dto.id)): \(error)")
            }
        }
        return socialAccounts
    }
    
    func fetchDTO() -> [SocialAccountDTO] {
        let descriptor = FetchDescriptor<SocialAccountDTO>(
            sortBy: [SortDescriptor(\.updateDate, order: .reverse)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ SiteDTO 가져오기 실패: \(error)")
            return []
        }
    }
}
