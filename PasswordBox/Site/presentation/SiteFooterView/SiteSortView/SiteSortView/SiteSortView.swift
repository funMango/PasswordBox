//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI

struct SiteSortView: View {
    var body: some View {
        Menu {
            Section {
                ForEach(SiteOrderBy.allCases, id: \.self) { option in
                    SiteSortBtnView(
                        viewModel: SiteSortBtnViewModel(type: option)
                    )
                }
            }
            
            Section {
                ForEach(SiteOrder.allCases, id: \.self) { option in
                    SiteSortBtnView(
                        viewModel: SiteSortBtnViewModel(type: option)
                    )
                }
            }            
        } label: {
            IconBgCircleBtnStyle(image: "arrow.up.arrow.down")
        }
        .menuStyle(BorderlessButtonMenuStyle())
        .buttonStyle(EmpeyActionStyle())
    }
}

#Preview {
    SiteSortView()
}
