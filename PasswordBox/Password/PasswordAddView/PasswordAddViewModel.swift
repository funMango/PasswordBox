//
//  PasswordAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation

class PasswordAddViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var pin: String = ""
    @Published var memo: String = ""
    
    var isValid: Bool {
        return !name.isEmpty && !password.isEmpty
    }
}

