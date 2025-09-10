//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI

struct AccountSortView: View {
    var body: some View {
        Menu {
            Section {
                ForEach(AccountOrderBy.allCases, id: \.self) { option in
                    AccountSortBtnView(
                        viewModel: AccountSortBtnViewModel(type: option)
                    )
                }
            }
            
            Section {
                ForEach(AccountOrder.allCases, id: \.self) { option in
                    AccountSortBtnView(
                        viewModel: AccountSortBtnViewModel(type: option)
                    )
                }
            }            
        } label: {
            IconBgCircleBtnStyle(image: "arrow.up.arrow.down")
        }
        .menuStyle(BorderlessButtonMenuStyle())
        .buttonStyle(EmpeyActionStyle())
    }
}

#Preview {
    AccountSortView()
}
