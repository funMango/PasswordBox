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
        headLineOption()
    }
    
    var body: some Scene {
        WindowGroup {
            AccountView()
        }
        .modelContainer(container)
    }
}

extension PasswordBoxApp {
    /// navigationTitle밑의 라인 제거
    func headLineOption() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
