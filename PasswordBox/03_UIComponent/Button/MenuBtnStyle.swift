//
//  MenuBtnStyle.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import SwiftUI

struct MenuBtnStyle: View {
    var text: String
    var image: String
    
    var body: some View {
        HStack {
            Text(text)
            Image(systemName: image)
        }
    }
}

#Preview {
    MenuBtnStyle(
        text: "오름차순",
        image: "arrow.up"
    )
}
