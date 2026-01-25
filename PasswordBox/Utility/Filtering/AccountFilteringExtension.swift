//
//  AccountFilteringExtension.swift
//  PasswordBox
//
//  Created by 이민호 on 11/27/25.
//

import Foundation

// 문자열 전처리: 대소문자/호환문자/악센트 제거 등
fileprivate extension String {
    func normalizedForFuzzyMatch() -> String {
        // 1) 소문자화
        let lower = self.lowercased()
        // 2) 유니코드 폴딩으로 악센트/호환 문자 제거
        //    .diacriticInsensitive: 악센트 제거
        //    .caseInsensitive: 대소문 무시(이미 소문자화 했지만 안전망)
        //    .widthInsensitive 등 옵션 필요시 추가 가능
        return lower.folding(options: [.diacriticInsensitive, .caseInsensitive, .widthInsensitive], locale: .current)
    }
}

// subsequence(부분 부분 일치) 매칭: query의 각 문자가 text 안에서 순서대로 등장하면 true
func fuzzyUnorderedContains(text: String, query: String) -> Bool {
    let t = text.normalizedForFuzzyMatch()
    var q = query.normalizedForFuzzyMatch()
    q.removeAll(where: { $0.isWhitespace })
    if q.isEmpty { return true }

    var freq: [Character: Int] = [:]
    for ch in t { freq[ch, default: 0] += 1 }

    for ch in q {
        guard let count = freq[ch], count > 0 else { return false }
        freq[ch] = count - 1
    }
    return true
}

