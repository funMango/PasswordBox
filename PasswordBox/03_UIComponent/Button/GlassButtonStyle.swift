//
//  GlassButtonStyle.swift
//  PasswordBox
//
//  Created by Codex on 2/10/26.
//

import SwiftUI

struct GlassButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive())
            .buttonBorderShape(.circle)
    }
}

extension View {
    func glassButtonStyle() -> some View {
        modifier(GlassButtonStyleModifier())
    }
}

extension Label {
    func glassIconLabel(size: CGFloat = 50, scale: Image.Scale = .large) -> some View {
        self
            .frame(width: size, height: size)
            .labelStyle(.iconOnly)
            .imageScale(scale)
    }
}
