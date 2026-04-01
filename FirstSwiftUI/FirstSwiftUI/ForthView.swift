//
//  ForthView.swift
//  FirstSwiftUI
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct ForthView: View {
    
    @State var myName = "Zeki Bıyıklı"
    
    var body: some View {
        VStack{
            Text(myName)
                .font(.largeTitle)
                .padding()
            Button("Button1", action: {
                self.myName = "Button 1 Clicked"
            })
            Button(action: {
                self.myName = "Button 2 Clicked"
            }){
                Text("Button2")
            }

        }
    }
}

#Preview {
    ForthView()
}
