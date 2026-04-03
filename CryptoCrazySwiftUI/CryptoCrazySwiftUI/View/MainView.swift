//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Zeki Mac on 2.04.2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cryptoListViewModel:CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView{
            List(cryptoListViewModel.cryptoList,id:\.id){crypto in
                VStack {
                    Text(crypto.currency ?? "")
                        .font(.title3)
                        .foregroundColor(.blue)
                    Text(crypto.price ?? "")
                        .foregroundColor(.black)
                }
            }.toolbar(content : {
                Button {
                    Task.init{
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/refs/heads/master/crypto.json")!)
                    }
                } label: {
                    Text ("Refresh")
                }
            }).navigationTitle(Text("Crypto Crazy"))
        }.task {
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/refs/heads/master/crypto.json")!)
        }
        
        /*
        .task {
            await cryptoListViewModel.downloadCryptosAsync(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/refs/heads/master/crypto.json")!)
        }*/
        
        /*.onAppear{
            cryptoListViewModel.downloadCryptos(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/refs/heads/master/crypto.json")!)
        }*/
    }
}

#Preview {
    ContentView()
}
