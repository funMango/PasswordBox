//
//  PasswordField.swift
//  PasswordBox
//
//  Created by 이민호 on 9/11/25.
//

import SwiftUI

enum PasswordFieldType: String {
    case password = "password"
    case pin = "pin"
    
    var localized: String {
        String(localized: String.LocalizationValue(rawValue))
    }
    
    func getKeyboardType() -> UIKeyboardType {
        switch self {
        case .password:
            return .default
        case .pin:
            return .numberPad
        }
    }
}

struct PasswordField: View {
    @Binding var password: String
    @State private var isSecured: Bool = true
    var type: PasswordFieldType = .password    

    var body: some View {
        HStack {
            if isSecured {
                SecureField(type.localized, text: $password)
                    .keyboardType(type.getKeyboardType())
            } else {
                TextField(type.localized, text: $password)
                    .keyboardType(type.getKeyboardType())
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    PasswordField(password: .constant("1234"))
}
