//
//  SiteListCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct AccountListCellView: View {
    var sitename: String
    var username: String

    var body: some View {
        AccountListCellContent(
            titleView: AnyView(
                Text(sitename)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
            ),
            subtitleView: AnyView(
                Text(verbatim: username)
                    .foregroundStyle(Color.gray)
                    .font(.caption)
            )
        )
    }
}

#Preview {
    AccountListCellView(
        sitename: "Apple", username: "bluemango@apple.com"
    )
}
