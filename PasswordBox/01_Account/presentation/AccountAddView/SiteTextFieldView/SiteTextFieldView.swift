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
        SearchTextFieldView(
            text: $viewModel.siteName,
            placeholder: "siteName",
            onChange: { focusState in
                if focusState {
                    viewModel.sendControlMessage()
                }
            }
        )
    }
}

#Preview {
    SiteTextFieldView()
}
