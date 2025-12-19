//
//  SubjectRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine

extension Resolver {
    public static func registerSubjects() {
        register {
            PassthroughSubject<ControlMessage, Never>()
        }.scope(.application)
        
        register {
            PassthroughSubject<AccountMessage, Never>()
        }.scope(.application)
                
        register {
            CurrentValueSubject<String?, Never>(nil)
        }.scope(.application)
                
        register {
            CurrentValueSubject<[AccountDTO]?, Never>(nil)
        }.scope(.application)
    }
}

extension Resolver {
    public static func registerDTOSubjects() {
        register {
            CurrentValueSubject<[AccountDTO]?, Never>(nil)
        }.scope(.application)
        
        register {
            CurrentValueSubject<[SocialAccountDTO]?, Never>(nil)
        }.scope(.application)
        
        register {
            CurrentValueSubject<UserDTO?, Never>(nil)
        }.scope(.application)
    }
}
