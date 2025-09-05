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
            Section("header one") {
                Button {
                    
                } label: {
                    MenuBtnStyle(
                        text: String(localized: "descendingOrder"),
                        image: "arrow.down"
                    )
                }
                
                Button {
                    
                } label: {
                    MenuBtnStyle(
                        text: String(localized: "ascendingOrder"),
                        image: "arrow.up"
                    )
                }
            }
            
            Section("header two") {
                Button {
                    
                } label: {
                    MenuBtnStyle(
                        text: String(localized: "descendingOrder"),
                        image: "arrow.down"
                    )
                }
                
                Button {
                    
                } label: {
                    MenuBtnStyle(
                        text: String(localized: "ascendingOrder"),
                        image: "arrow.up"
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
