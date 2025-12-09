//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import SwiftUI

struct AccountSortBtnView: View {
    var option: AccountOption
            
    var body: some View {
        HStack {
            Text(option.text)
            Image(systemName: option.image)
        }
    }
}

//#Preview {
//    SiteSortBtnView(text: String(localized: "ascendingOrder"), image: "arrow.up")
//}
