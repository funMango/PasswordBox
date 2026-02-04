//
//  ImageButtonLarge.swift
//  PasswordBox
//
//  Created by 이민호 on 8/10/25.
//

import SwiftUI

struct IconBtnStyle: View {
    var image: String
    var color: Color = .primary
    var width: CGFloat = 25
    var height: CGFloat = 25
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .foregroundStyle(color)
    }
}

#Preview {
    IconBtnStyle(image: "line.3.horizontal")
}
