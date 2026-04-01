//
//  FifthView.swift
//  FirstSwiftUI
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct FifthView: View {
    
    @State var myName = "Zeki Bıyıklı"
    
    var body: some View {
        VStack{
            Text(myName)
                .font(.largeTitle)
                .padding()
            TextField("placeholder",text: $myName)

        }
    }
}

#Preview {
    FifthView()
}
