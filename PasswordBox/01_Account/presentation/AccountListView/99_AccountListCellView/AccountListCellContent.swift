//
//  AccountListCellContent.swift
//  PasswordBox
//
//  Created by 이민호 on 1/25/26.
//

import SwiftUI

struct AccountListCellContent: View {
    let titleView: AnyView
    let subtitleView: AnyView

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                titleView
                subtitleView
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .frame(height: 40)
    }
}

//#Preview {
//    AccountListCellContent()
//}
