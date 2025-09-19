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
    
    
    init(sitename: String, username: String) {
        self.sitename = sitename
        self.username = username
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(sitename)
                    .fontWeight(.regular)
                
                Text(verbatim: username)
                    .foregroundStyle(Color.gray)
                    .font(.caption)
            }
            
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    AccountListCellView(
        sitename: "Apple", username: "bluemango@apple.com"
    )
}
