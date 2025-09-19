//
//  PasswordBoxApp.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI
import Resolver
import SwiftData

@main
struct PasswordBoxApp: App {
    @Injected var container: ModelContainer
    var dek = KeychainDEKStore()
    
    
    init() {
        Resolver.registerAllServices()
        // try? dek.delete()
    }
    
    var body: some Scene {
        WindowGroup {
            AccountView()
        }
        .modelContainer(container)
    }
}
