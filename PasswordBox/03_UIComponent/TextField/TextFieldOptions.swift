//
//  TextFieldOptions.swift
//  PasswordBox
//
//  Created by 이민호 on 9/11/25.
//

import SwiftUI

struct TextFieldOptions: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}

extension View {
    func textFieldOptions() -> some View {
        self.modifier(TextFieldOptions())
    }
}
