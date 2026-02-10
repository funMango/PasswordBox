//
//  AccountListHighlightCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 1/25/26.
//

import SwiftUI

struct AccountListHighlightCellView: View {
    var sitename: String
    var username: String
    var query: String
    var showsLinkIcon: Bool = false
    var showsChevron: Bool = true

    var body: some View {
        AccountListCellContent(
            titleView: AnyView(
                Text(highlightedText(
                    sitename,
                    query: query,
                    matchColor: .primary,
                    nonMatchColor: .secondary
                ))
            ),
            subtitleView: AnyView(
                HStack(spacing: 4) {
                    if showsLinkIcon {
                        Image(systemName: "link")
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                    }
                    Text(highlightedText(
                        username,
                        query: query,
                        matchColor: .primary,
                        nonMatchColor: .secondary
                    ))
                    .font(.caption)
                }
            ),
            showsChevron: showsChevron
        )
    }
}

extension AccountListHighlightCellView {
    func highlightedText(_ source: String, query: String, matchColor: Color, nonMatchColor: Color) -> AttributedString {
        var attr = AttributedString(source)
        attr.foregroundColor = nonMatchColor

        // Preprocess query: remove all whitespace characters
        let preprocessedQuery = query.filter { !$0.isWhitespace }
        let foldedSource = source.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        let foldedQuery = preprocessedQuery.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)

        guard !foldedQuery.isEmpty else { return attr }

        // 1) 모든 문자 포함 조건 확인
        guard containsAllChars(source: source, query: preprocessedQuery) else {
            // 포함하지 않으면 강조 없음(전부 nonMatchColor)
            return attr
        }

        // 2) 포함하는 경우에만 문자별로 모두 강조
        for qChar in foldedQuery {
            var start = foldedSource.startIndex
            while start < foldedSource.endIndex,
                  let range = foldedSource.range(of: String(qChar), range: start..<foldedSource.endIndex) {
                if let attrRange = Range(range, in: attr) {
                    attr[attrRange].foregroundColor = matchColor
                }
                start = range.upperBound
            }
        }
        return attr
    }
    
    func containsAllChars(source: String, query: String) -> Bool {
        // Preprocess query: remove all whitespace characters
        let preprocessedQuery = query.filter { !$0.isWhitespace }
        let foldedSource = source.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        let foldedQuery = preprocessedQuery.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
        guard !foldedQuery.isEmpty else { return true }

        // source 문자 카운트
        var sourceCount: [Character: Int] = [:]
        for ch in foldedSource { sourceCount[ch, default: 0] += 1 }

        // query 문자 카운트
        var queryCount: [Character: Int] = [:]
        for ch in foldedQuery { queryCount[ch, default: 0] += 1 }

        // query의 각 문자가 source에 충분히 있는지 확인
        for (ch, needed) in queryCount {
            if sourceCount[ch, default: 0] < needed { return false }
        }
        return true
    }
}

#Preview {
    AccountListHighlightCellView(sitename: "abcdefg", username: "acev", query: "af")
}
