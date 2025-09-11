//
//  example.swift
//  PasswordBox
//
//  Created by 이민호 on 9/11/25.
//

import SwiftUI

struct example: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $text)
            List {
                ForEach(1...100, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .scrollDismissesKeyboard(.immediately)
        }
        
    }
}

#Preview {
    example()
}
