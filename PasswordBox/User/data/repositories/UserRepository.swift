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
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "⚠️ 사용자 정보를 찾을 수 없습니다."
        case .updateFailed:
            return "⚠️ 사용자 정보를 업데이트 하는데 실패하였습니다."
        }
    }
}

@MainActor
protocol UserRepository {
    func create() throws -> User
    func isUserExist() -> Bool
    func fetch() -> User?
    func update<T: AccountOption>(_ option: T) throws
}

@MainActor
class DefaultUserRepository: UserRepository {
    @Injected var modelContext: ModelContext
    
    func create() throws -> User {
        let userDTO = UserDTO()
        modelContext.insert(userDTO)
        
        try modelContext.save()
        print("💾 User 생성완료 (id: \(userDTO.id)")
        
        return userDTO.toEntity()
    }
    
    func isUserExist() -> Bool {
        let user = fetch()
        
        if user == nil {
            return false
        }
        
        return true
    }
    
    func fetch() -> User? {
        let userDTO: [UserDTO] = fetchDTO()
        return userDTO.map{ $0.toEntity() }.first
    }
    
    func update<T: AccountOption>(_ option: T) throws {
        print("user update 시작")
        // 현재 저장된 UserDTO 가져오기 (단일 사용자 전제)
        let userDTOs: [UserDTO] = fetchDTO()
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
            print("✏️ User 업데이트 완료 (id: \(userDTO.id))")
        } catch {
            throw UserError.updateFailed
        }
    }
    
    private func fetchDTO() -> [UserDTO] {
        let descriptor = FetchDescriptor<UserDTO>()
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ UserDTO 가져오기 실패: \(error)")
            return []
        }
    }
}

