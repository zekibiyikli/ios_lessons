//
//  ContentView.swift
//  FavoriteBook
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(myFavorites){ favorite in
                    Section(header: Text(favorite.title)){
                        ForEach(favorite.elements){ element in
                            NavigationLink(destination: DetailsView(chosenFavoriteElement: element)){
                                Text(element.name)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Favorite Book"))
        }
    }
}

#Preview {
    ContentView()
}
