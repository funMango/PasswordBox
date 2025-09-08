//
//  SiteTextFieldView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import SwiftUI

struct SiteTextFieldView: View {
    @FocusState private var focusedField: Bool
    @StateObject var viewModel = SiteTextFieldViewModel()
        
    var body: some View {
        Section {
            TextField(
                String(localized: "siteName"),
                text: $viewModel.siteName
            )
            .focused($focusedField)
            .onChange(of: focusedField) { _ , newValue in
                if newValue {
                    focusedField = false // 키보드 닫기
                    viewModel.sendControlMessage()
                }
            }
        }
    }
}

#Preview {
    SiteTextFieldView()
}
