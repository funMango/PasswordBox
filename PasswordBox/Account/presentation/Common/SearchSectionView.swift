//
//  SearchSectionView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/19/25.
//

import SwiftUI

struct SearchSectionView: View {
    let placeholder: LocalizedStringKey
    var textBinding: Binding<String>
    @FocusState private var isFocused: Bool
    var onSubmit: (() -> Void)?
    
    var body: some View {
        Section {
            TextField(placeholder, text: textBinding)
                .textFieldOptions()
                .focused($isFocused)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                    isFocused = true
                }
                .onSubmit {
                    onSubmit?()
                }
        }
    }
}
