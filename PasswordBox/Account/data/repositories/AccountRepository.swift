//
//  SiteRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import SwiftData

enum AccountListError: Error {
    case fetchFailed
    
    func asLocalizedDescription() -> String {
        switch self {
        case .fetchFailed:
            return "⚠️ Account 목록을 가져오는 데 실패했습니다."
        }
    }
}

@MainActor
protocol AccountRepository {
    func save(_ account: Account)
    func fetch() async throws -> [Account]
    func delete(id: String)
}

@MainActor
class DefaultAccountRepository: AccountRepository {
    @Injected var modelContext: ModelContext
    private let encryptor = AccountEncryptor()
    
    func save(_ account: Account) {
        do {
            let dto = try encryptor.toDTO(entity: account)
            modelContext.insert(dto)
            try modelContext.save()
            print("💾 Account 저장완료 (id: \(account.id), site: \(account.sitename))")
        } catch {
            print("⚠️ Account 저장 실패: \(error)")
        }
    }
    
    func fetch() async throws -> [Account] {
        let dtos = try await fetchDTO()
        
        return try await withThrowingTaskGroup(of: Account?.self) { [weak self] group in
            guard let self else { throw AccountListError.fetchFailed }
            for dto in dtos {
                group.addTask {
                    do { return try self.encryptor.toEntity(dto: dto) }
                    catch {
                        print("⚠️ Account 복호화 실패: \(dto.id)")
                        return nil
                    }
                }
            }
            
            /// 복호화 실패한것들 제거
            var result: [Account] = []
            for try await account in group {
                if let account { result.append(account) }
            }
            return result
        }
    }
    
    func delete(id: String) {
        Task {
            do {
                let fetchedSites = try await fetchDTO()
                if let accountToDelete = fetchedSites.first(where: { $0.id == id }) {
                    modelContext.delete(accountToDelete)
                    try modelContext.save()
                    print("🗑️ Account 삭제완료 (id: \(accountToDelete.id), title: \(accountToDelete.sitename))")
                }
            } catch {
                print("⚠️ Site 삭제실패: \(error)")
            }
        }
    }
    
    private func fetchDTO() async throws -> [AccountDTO] {
        let descriptor = FetchDescriptor<AccountDTO>(
            sortBy: [SortDescriptor(\.updateDate, 
            order: .reverse)]
        )
        
        return try modelContext.fetch(descriptor)
    }
    
    
}
