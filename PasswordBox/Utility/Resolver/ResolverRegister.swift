//
//  ResolverRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        registerSubjects()
    }        
}
