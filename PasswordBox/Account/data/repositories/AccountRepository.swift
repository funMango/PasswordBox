//
//  SiteRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import SwiftData

protocol AccountRepository {
    func save(_ account: Account)
    func fetch() -> [Account]
    func delete(siteId: String)
}

class DefaultAccountRepository: AccountRepository {
    @Injected var modelContext: ModelContext
    
    func save(_ account: Account) {
        let accountDTO = AccountDTO(
            id: account.id,
            sitename: account.sitename,
            username: account.username,
            password: account.password,
            pin: account.pin,
            memo: account.memo
        )
        
        modelContext.insert(accountDTO)
                
        do {
            try modelContext.save()
            print("💾 Site 저장완료 (id: \(account.id), title: \(account.sitename)")
        } catch {
            print("⚠️ Site 저장실패: \(error)")
        }
    }
    
    func fetch() -> [Account] {
        let accountDTOs: [AccountDTO] = fetchDTO()
        return accountDTOs.map{ $0.toEntity() }
    }
    
    func fetchDTO() -> [AccountDTO] {
        let descriptor = FetchDescriptor<AccountDTO>(sortBy: [SortDescriptor(\.updateDate, order: .reverse)])
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ SiteDTO 가져오기 실패: \(error)")
            return []
        }
    }
    
    func delete(siteId: String) {
        do {
            let fetchedSites = fetchDTO()
            if let accountToDelete = fetchedSites.first(where: { $0.id == siteId }) {
                modelContext.delete(accountToDelete)
                try modelContext.save()
                print("🗑️ Site 삭제완료 (id: \(accountToDelete.id), title: \(accountToDelete.sitename)")
            }
        } catch {
            print("⚠️ Site 삭제실패: \(error)")
        }
    }
}
