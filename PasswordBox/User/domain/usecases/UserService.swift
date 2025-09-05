//
//  UserService.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import Resolver

protocol UserService {
    func fetch() -> User?
}

class DefaultUserService: UserService {
    @Injected var repository: UserRepository
    
    func fetch() -> User? {
        if !repository.isUserExist() {
            return try? repository.create()
        } else {
            return repository.fetch()
        }
    }
}
