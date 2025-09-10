//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import SwiftUI

struct AccountSortBtnView<T: AccountOption>: View {
    @ObservedObject var viewModel: AccountSortBtnViewModel<T>
            
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Text(viewModel.type.text)
                Image(systemName: viewModel.type.image)
            }
        }
    }
}

//#Preview {
//    SiteSortBtnView(text: String(localized: "ascendingOrder"), image: "arrow.up")
//}
