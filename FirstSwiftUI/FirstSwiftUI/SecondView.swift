//
//  SecondView.swift
//  FirstSwiftUI
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        
        Image("image")
            .resizable()
            .aspectRatio(contentMode: .fit)
            //.frame(width: 300,height: 300)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20) // yaklaşık %80 görünüm verir

    }
}

#Preview {
    SecondView()
}
