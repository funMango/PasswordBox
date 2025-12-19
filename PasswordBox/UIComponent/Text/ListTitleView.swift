//
//  ListTitleView.swift
//  PasswordBox
//
//  Created by 이민호 on 12/9/25.
//

import SwiftUI

struct ListTitleStyle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}

#Preview {
    ListTitleStyle(text: "전체")
}
