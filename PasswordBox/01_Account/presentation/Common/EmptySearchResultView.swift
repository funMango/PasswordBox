//
//  EmptySearchResultView.swift
//  PasswordBox
//
//  Created by 이민호 on 2/4/26.
//

import SwiftUI

struct EmptySearchResultView: View {
    
    let query: String
    
    var body: some View {
        ContentUnavailableView {
            Label(
                String(localized: "searchEmptyTitle"),
                systemImage: "magnifyingglass"
            )
        } description: {
            VStack(spacing: 6) {
                if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text(String(localized: "searchEmptyNoQuery"))
                } else {
                    Text(
                        String(
                            localized: "searchEmptyNoResult",
                            defaultValue: "No results found for \"\(query)\"."
                        )
                    )
                    Text(String(localized: "searchEmptySuggestion"))
                }
            }
            .padding(.top)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}


// MARK: - Preview
#Preview {
    EmptySearchResultView(query: "동백")
}
