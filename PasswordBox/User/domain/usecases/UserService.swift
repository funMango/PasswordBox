//
//  UserService.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver

@MainActor
protocol UserService {
    func getOrderAndOrderBy() async throws -> (order: AccountOrder, orderBy: AccountOrderBy)
    func update(option: AccountOption) async throws
}

@MainActor
class DefaultUserService: UserService {
    @Injected var repository: UserRepository
            
    func getOrderAndOrderBy() async throws -> (order: AccountOrder, orderBy: AccountOrderBy) {
        let fetched = try await fetch()
        return (order: fetched.siteOrder, orderBy: fetched.siteOrderBy)
    }
    
    func update(option: AccountOption) async throws {
        try await repository.update(option)
    }
    
    private func fetch() async throws -> User {
        try await repository.fetch()
    }
    
    
}
