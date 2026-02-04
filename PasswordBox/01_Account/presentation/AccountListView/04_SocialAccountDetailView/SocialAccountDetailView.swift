//
//  SocialAccountDetailView.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import SwiftUI

struct SocialAccountDetailView: View {
    @StateObject var viewModel: SocialAccountDetailViewModel
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onDisappear {
            viewModel.didSet()
        }        
    }
}

#Preview {
    let previewSocialAccount = SocialAccount(
        sitename: "example.com",
        socialSitename: "example.com"
    )
    
    let viewModel = SocialAccountDetailViewModel(socialAccount: previewSocialAccount)
    SocialAccountDetailView(viewModel: viewModel)
}
