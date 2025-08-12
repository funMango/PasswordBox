//
//  Icon.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

enum IconSize {
    case medium
    
    func getSize() -> CGFloat {
        switch self {
        case .medium:
            return 38
        }
    }
}

struct Icon: View {
    var name: String
    var size: IconSize = .medium
    var color: Color = .gray
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .frame(width: size.getSize(), height: size.getSize())
            .foregroundStyle(color)
    }
}

#Preview {
    Icon(name: "lock.circle.fill")
}
