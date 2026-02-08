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
    var itemTitle: (Item) -> String
    @ViewBuilder var cellView: (Item) -> Cell
    
    var body: some View {
        let normalizedText = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let hasExactMatch = !normalizedText.isEmpty && filteredItems.contains { item in
            itemTitle(item).trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalizedText
        }

        if !normalizedText.isEmpty && !hasExactMatch {
            Section {
                Button {
                    updateItem()
                } label: {
                    let fmt = NSLocalizedString("createSite", comment: "Create {site}")
                    Text(String(format: fmt, locale: .current, text))
                }
            }
        }

        SectionList(filteredItems: $filteredItems, text: text, setItem: setItem, cellView: cellView)
    }
}

struct SocialFilteredSectionView<Item: Hashable, Cell: View>: View {
    @Binding var filteredItems: [Item]
    var text: String
    var setItem: (Item) -> Void
    @ViewBuilder var cellView: (Item) -> Cell
    
    var body: some View {
        if filteredItems.isEmpty && !text.isEmpty {
            Section {
                EmptySearchResultView(query: text)
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }
        } else {
            SectionList(filteredItems: $filteredItems, text: text, setItem: setItem, cellView: cellView)
        }
    }
}

private struct SectionList<Item: Hashable, Cell: View>: View {
    @Binding var filteredItems: [Item]
    var text: String
    var setItem: (Item) -> Void
    @ViewBuilder var cellView: (Item) -> Cell
    
    var body: some View {
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
