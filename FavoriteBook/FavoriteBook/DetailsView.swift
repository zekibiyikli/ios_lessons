//
//  DetailsView.swift
//  FavoriteBook
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct DetailsView: View {
    
    var chosenFavoriteElement :FavoriteElements
    
    var body: some View {
        VStack{
            Image(chosenFavoriteElement.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300,height: 200)
                .padding()
            Text(chosenFavoriteElement.name)
                .font(.largeTitle)
                .padding()
            Text(chosenFavoriteElement.description)
                .font(.subheadline)
                .padding()
        }
    }
}

#Preview {
    DetailsView(chosenFavoriteElement: item1)
}
