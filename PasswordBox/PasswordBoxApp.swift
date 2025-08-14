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
    
    init() {
        Resolver.registerAllServices()
    }
    
    var body: some Scene {
        WindowGroup {
            SiteView()
        }
        .modelContainer(container)
    }
}
