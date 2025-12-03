//
//  ResolverRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver

@MainActor
extension Resolver: @MainActor @retroactive ResolverRegistering {
    public static func registerAllServices() {
        registerSwiftData()
        registerSubjects()
        registerRepositories()
        registerUsecases()
        registerController()
    }
}
