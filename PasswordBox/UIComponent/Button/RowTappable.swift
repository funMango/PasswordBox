import SwiftUI

public extension View {
    /// Expands the view to full row width and makes whitespace tappable
    func fullRowTappable(alignment: Alignment = .leading) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
            .contentShape(Rectangle())
    }
}

public extension Button {
    /// Applies plain style and ensures the button's hit area covers its content shape
    func rowButtonStyle() -> some View {
        self
            .buttonStyle(.plain)
            .contentShape(Rectangle())
    }
}
