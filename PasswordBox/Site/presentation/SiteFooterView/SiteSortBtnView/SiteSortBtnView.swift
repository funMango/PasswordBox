//
//  SiteSortBtnView.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI

struct SiteSortBtnView: View {
    var body: some View {
        Menu {
            Button {
                
            } label: {
                Text("옵션1")
            }
            
            Button {
                
            } label: {
                Text("옵션2")
            }
        } label: {
            IconBgCircleBtnStyle(image: "arrow.up.arrow.down")
        }
        .buttonStyle(EmpeyActionStyle())
    }
}

#Preview {
    SiteSortBtnView()
}
