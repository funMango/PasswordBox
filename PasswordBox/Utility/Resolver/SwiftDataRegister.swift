//
//  SwiftDataRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import SwiftData

extension Resolver {
    public static func registerSwiftData() {
        register {
            do {
                let schema = Schema([SiteDTO.self, UserDTO.self])
                let container = try ModelContainer(
                    for: schema,
                    configurations: ModelConfiguration(
                        isStoredInMemoryOnly: false,
                        cloudKitDatabase: .automatic
                    )
                )
                return container
            } catch {
                fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
            }
        }.scope(.application)
        
        register {
            let container: ModelContainer = resolve()
            return ModelContext(container)
        }
    }
}
