//
//  HideKeyboardOnTap.swift
//  PasswordBox
//
//  Created by 이민호 on 9/11/25.
//

import SwiftUI

struct HideKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
    }
}

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        modifier(HideKeyboardOnTap())
    }
}
