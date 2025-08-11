//
//  PasswordBoxApp.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI
import Resolver

@main
struct PasswordBoxApp: App {
    
    init() {
        Resolver.registerAllServices()
    }
    
    var body: some Scene {
        WindowGroup {
            SiteView()
        }
    }
}
