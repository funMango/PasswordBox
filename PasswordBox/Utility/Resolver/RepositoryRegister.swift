//
//  RepositoryRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerRepositories() {
        register{
            DefaultAccountRepository() as AccountRepository
        }
        
        register{
            DefaultUserRepository() as UserRepository
        }
    }
}
