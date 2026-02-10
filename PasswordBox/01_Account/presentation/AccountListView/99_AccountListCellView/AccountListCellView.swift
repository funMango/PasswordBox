//
//  SiteListCellView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct AccountListCellView: View {
    var title: String
    var subTitle: String
    var showsLinkIcon: Bool = false
    var showsChevron: Bool = true

    var body: some View {
        AccountListCellContent(
            titleView: AnyView(
                Text(title)
                    .foregroundStyle(.primary)
                    .fontWeight(.regular)
            ),
            subtitleView: AnyView(
                HStack(spacing: 4) {
                    if showsLinkIcon {
                        Image(systemName: "link")
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                    }
                    Text(verbatim: subTitle)
                        .foregroundStyle(Color.gray)
                        .font(.caption)
                }
            ),
            showsChevron: showsChevron
        )
    }
}

#Preview {
    AccountListCellView(
        title: "Apple", subTitle: "bluemango@apple.com"
    )
}
