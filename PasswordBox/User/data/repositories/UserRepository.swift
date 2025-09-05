//
//  UserRepository.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver
import SwiftData

protocol UserRepository {
    func create() throws -> User
    func isUserExist() -> Bool
    func fetch() -> User?
}

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
    
    func fetchDTO() -> [UserDTO] {
        let descriptor = FetchDescriptor<UserDTO>()
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("⚠️ UserDTO 가져오기 실패: \(error)")
            return []
        }
    }
}
