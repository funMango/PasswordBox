//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI

struct AccountSortView: View {
    @StateObject var viewModel = AccountSortViewModel()    
    
    var body: some View {
        Menu {
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
