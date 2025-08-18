//
//  SiteFotterView.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import SwiftUI

struct SiteFooterView: View {
    @StateObject var viewModel = SiteFooterViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    IconBtnStyle(
                        image: "magnifyingglass.circle.fill"                        
                    )
                }
                
                Button {
                    viewModel.toggleIsShowingSiteAddSheet()
                } label: {
                    IconBtnStyle(
                        image: "plus.circle.fill"
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    SiteFooterView()
}
