//
//  SearchTextFieldView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//

import SwiftUI

struct SearchTextFieldView: View {
    @FocusState private var focusedField: Bool
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var onChange: (Bool) -> ()
    
    
    var body: some View {
        Section {
            TextField(
                placeholder,
                text: $text
            )
            .textFieldOptions()
            .focused($focusedField)
            .onChange(of: focusedField) { _ , focusState in
                if focusState {
                    focusedField = false
                }
                
                onChange(focusState)
            }
        }
    }
}

//#Preview {
//    SearchTextFieldView()
//}
