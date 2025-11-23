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
    func fetch() async -> [Account]
    func delete(id: String)
}

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
    
    func fetch() -> [Account] {
        let accountDTOs: [AccountDTO] = fetchDTO()
        var accounts: [Account] = []
        
        for dto in accountDTOs {
            do {
                let account = try encryptor.toEntity(dto: dto)
                accounts.append(account)
            } catch {
                print("⚠️ 복호화 실패 (id: \(dto.id)): \(error)")
            }
        }
        return accounts
    }
    
    func fetch() async -> [Account] {
      let dtos = fetchDTO()

      // 2) CPU 바운드 복호화는 백그라운드에서
      return await withTaskGroup(of: Account?.self) { [weak self] group in
          for dto in dtos {
              group.addTask {
                  do { return try self?.encryptor.toEntity(dto: dto) }
                  catch {
                      print("복호화 실패: \(error)")
                      return nil
                  }
              }
          }
          var result: [Account] = []
          for await account in group {
              if let account { result.append(account) }
          }
          return result
      }
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
    
    func delete(id: String) {
        do {
            let fetchedSites = fetchDTO()
            if let accountToDelete = fetchedSites.first(where: { $0.id == id }) {
                modelContext.delete(accountToDelete)
                try modelContext.save()
                print("🗑️ Account 삭제완료 (id: \(accountToDelete.id), title: \(accountToDelete.sitename)")
            }
        } catch {
            print("⚠️ Site 삭제실패: \(error)")
        }
    }
}
