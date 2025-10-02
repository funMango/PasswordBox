//
//  ItemFilteredSectionView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/19/25.
//

import SwiftUI

struct AccountFilteredSectionView<Cell: View>: View {
    @Binding var filteredAccounts: [AccountInfoWrapper]
    var text: String
    var updateItem: () -> Void
    var setItem: (AccountInfoWrapper) -> Void
    @ViewBuilder var cellView: (AccountInfoWrapper) -> Cell
    
    var body: some View {
        if filteredAccounts.isEmpty && !text.isEmpty {
            Section {
                Button {
                    updateItem()
                } label: {
                    let fmt = NSLocalizedString("createSite", comment: "Create {site}")
                    Text(String(format: fmt, locale: .current, text))
                }
            }
        } else {
            Section {
                ForEach(filteredAccounts, id: \.id) { account in
                    Button {
                        setItem(account)
                    } label: {
                        cellView(account)
                    }
                }
            }
        }
    }
}
