//
//  UsecaseRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

@MainActor
extension Resolver {
    public static func registerUsecases() {
        register {
            DefaultAccountService() as AccountService
        }
        
        register {
            DefaultSocialAccountService() as SocialAccountService
        }
        
        register {
            DefaultUserService() as UserService
        }
    }
}
