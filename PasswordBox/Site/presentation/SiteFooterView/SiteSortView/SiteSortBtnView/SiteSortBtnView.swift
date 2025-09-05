//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import SwiftUI

struct SiteSortBtnView: View {
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
    SiteSortBtnView(text: String(localized: "ascendingOrder"), image: "arrow.up")
}
