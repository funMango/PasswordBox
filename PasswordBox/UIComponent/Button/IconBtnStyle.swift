//
//  ImageButtonLarge.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI

struct IconBtnStyle: View {
    var image: String
    var color: Color = .blue
    var width: CGFloat = 50
    var height: CGFloat = 50
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(color)
    }
}

#Preview {
    IconBtnStyle(image: "plus.circle")
}
