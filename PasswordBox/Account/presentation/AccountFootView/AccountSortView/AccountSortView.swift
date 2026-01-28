//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI
import FixedMenu

struct AccountSortView: View {
    @StateObject var viewModel = AccountSortViewModel()
    
    var body: some View {
        Menu {
            menuContent
        } label: {
            IconBgCircleBtnStyle(image: "arrow.up.arrow.down")
                
        }
        .glassEffect()
        .menuStyle(BorderlessButtonMenuStyle())
        .buttonStyle(EmpeyActionStyle())
    }
    
    @ViewBuilder
    var menuContent: some View {
        Section {
            Picker("Sort by", selection: $viewModel.orderBy) {
                ForEach(AccountOrderBy.allCases, id: \.self) { option in
                    AccountSortBtnView(option: option)
                }
            }
        }

        Section {
            Picker("Order", selection: $viewModel.order) {
                ForEach(AccountOrder.allCases, id: \.self) { option in
                    AccountSortBtnView(option: option)
                }
            }
        }
    }
}

#Preview {
    AccountSortView()
}
