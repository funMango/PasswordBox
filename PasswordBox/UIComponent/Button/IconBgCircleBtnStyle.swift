//
//  IconBackgroundBtnStyle.swift
//  PasswordBox
//
//  Created by 이민호 on 9/1/25.
//

import SwiftUI

struct IconBgCircleBtnStyle: View {
    var length: CGFloat = 40
    var image: String
    
    var body: some View {
        ZStack {                        
            Circle()
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                .frame(width: length, height: length)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            
            Image(systemName: image)
        }
    }
}

#Preview {
    IconBgCircleBtnStyle(image: "plus")
}
