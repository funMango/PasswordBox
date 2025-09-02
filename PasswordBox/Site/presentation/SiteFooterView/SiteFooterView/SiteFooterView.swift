//
//  SiteFooterVIew2.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI

struct SiteFooterView: View {
    @State var searchText: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                
            } label: {
                IconBgCircleBtnStyle(image: "arrow.up.arrow.down")
            }
            
            SiteSearchBarView()
            
            SiteAddBtnView()
        }
        .padding()
    }
}

#Preview {
    SiteFooterView()
}
