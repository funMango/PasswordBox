//
//  ControllerRegister.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerController() {
        register {
            DefaultAccountFetcher() as AccountFetcher
        }
        
        register {
            DefaultAccountListSorter() as AccountListSorter
        }
    }
}
