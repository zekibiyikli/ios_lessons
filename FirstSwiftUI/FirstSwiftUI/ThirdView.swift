//
//  ThirdView.swift
//  FirstSwiftUI
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct ThirdView: View {
    let myArray = ["1","2","3","4","5"]
    var body: some View {
        List (myArray,id:\.self){ element in
            HStack{
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text(element)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ThirdView()
}
