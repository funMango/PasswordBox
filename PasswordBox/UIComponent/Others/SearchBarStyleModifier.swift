//
//  SearchBar.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI

struct SearchBarStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 25)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .disableAutocorrection(true)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(.ultraThinMaterial)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
    }
}

extension View {
    func searchBarStyle() -> some View {
        self.modifier(SearchBarStyleModifier())
    }
}

#Preview {
    @Previewable @State var text: String = ""
    
    VStack {
        TextField("검색", text: $text)
            .searchBarStyle()
    }
    .padding()
    
}
