//
//  SocialAccountRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 9/25/25.
//

import Foundation
import Resolver
import SwiftData

@MainActor
protocol SocialAccountRepository {
    func save(_ socialAccount: SocialAccount)
    func fetch() async throws -> [SocialAccount]
    func delete(id: String)
}

@MainActor
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
    
    func fetch() async throws -> [SocialAccount] {
        let accountDTOs: [SocialAccountDTO] = try await fetchDTO()
        
        return await withTaskGroup(of: SocialAccount?.self) { [weak self] group in
            for dto in accountDTOs {
                group.addTask {
                    do {
                        return try await self?.encryptor.toEntity(dto: dto)
                    } catch {
                        print("⚠️ 복호화 실패 (id: \(dto.id)): \(error)")
                        return nil
                    }
                }
            }
            var result: [SocialAccount] = []
            for await item in group {
                if let account = item {
                    result.append(account)
                }
            }
            return result
        }
    }
    
    func fetchDTO() async throws -> [SocialAccountDTO] {
        let descriptor = FetchDescriptor<SocialAccountDTO>(
            sortBy: [SortDescriptor(\.updateDate, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    func delete(id: String) {
        Task {
            do {
                let fetchedSites = try await fetchDTO()
                if let accountToDelete = fetchedSites.first(where: { $0.id == id }) {
                    modelContext.delete(accountToDelete)
                    try modelContext.save()
                    print("🗑️ SocialAccount 삭제완료 (id: \(accountToDelete.id), title: \(accountToDelete.sitename)")
                }
            } catch {
                print("⚠️ SocialAccount 삭제실패: \(error)")
            }
        }
    }
}
