//
//  UserRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver
import SwiftData

enum UserError: LocalizedError {
    case userNotFound
    case updateFailed
    case fetchFailed
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "⚠️ 사용자 정보를 찾을 수 없습니다."
        case .updateFailed:
            return "⚠️ 사용자 정보를 업데이트 하는데 실패하였습니다."
        case .fetchFailed:
            return "⚠️ UserDTO를 조회하는데 실패하였습니다."
        }
    }
}

@MainActor
protocol UserRepository {
    func fetch() async throws -> User
    func update<T: AccountOption>(_ option: T) async throws
}

@MainActor
class DefaultUserRepository: UserRepository {
    @Injected var modelContext: ModelContext
    
    func fetch() async throws -> User {
        let userDTOs: [UserDTO] = try await fetchDTO()
        if let existing = userDTOs.first?.toEntity() {
            return existing
        }
                
        let created = try await create()
        return created
    }
    
    func update<T: AccountOption>(_ option: T) async throws {
        let userDTOs: [UserDTO] = try await fetchDTO()
        guard let userDTO = userDTOs.first else {
            throw UserError.userNotFound
        }
        
        if let order = option as? AccountOrder {
            userDTO.sortOrder = order
        } else if let orderBy = option as? AccountOrderBy {
            userDTO.sortBy = orderBy
        }
                        
        do {
            try modelContext.save()
            print("✅ User 업데이트 완료 (id: \(userDTO.id))")
        } catch {
            throw UserError.updateFailed
        }
    }
    
    private func create() async throws -> User {
        let userDTO = UserDTO()
        modelContext.insert(userDTO)
        
        try modelContext.save()
        print("✅ User 생성완료 (id: \(userDTO.id)")
        
        return userDTO.toEntity()
    }
    
    private func fetchDTO() async throws -> [UserDTO] {
        let descriptor = FetchDescriptor<UserDTO>()
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            throw UserError.fetchFailed
        }
    }
}

