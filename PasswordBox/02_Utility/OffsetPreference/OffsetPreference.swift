//
//  OffsetPreference.swift
//  PasswordBox
//
//  Created by 이민호 on 12/9/25.
//

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func trackY(_ onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onChange)
    }
}
