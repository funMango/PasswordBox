//
//  ItemFilteredSectionView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/19/25.
//

import SwiftUI

struct AccountFilteredSectionView<Item: Hashable, Cell: View>: View {
    @Binding var filteredItems: [Item]
    var text: String
    var updateItem: () -> Void
    var setItem: (Item) -> Void
    @ViewBuilder var cellView: (Item) -> Cell
    
    var body: some View {
        if filteredItems.isEmpty && !text.isEmpty {
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
                ForEach(filteredItems, id: \.self) { item in
                    Button {
                        setItem(item)
                    } label: {
                        cellView(item)
                    }
                }
            }
        }
    }
}

extension AccountFilteredSectionView where Item == AccountInfoWrapper {
    init(
        filteredAccounts: Binding<[AccountInfoWrapper]>,
        text: String,
        updateItem: @escaping () -> Void,
        setItem: @escaping (AccountInfoWrapper) -> Void,
        cellView: @escaping (AccountInfoWrapper) -> Cell
    ) {
        self._filteredItems = filteredAccounts
        self.text = text
        self.updateItem = updateItem
        self.setItem = setItem
        self.cellView = cellView
    }
}
