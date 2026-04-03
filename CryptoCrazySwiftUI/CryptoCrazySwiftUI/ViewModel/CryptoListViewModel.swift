//
//  CryptoListViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Zeki Mac on 2.04.2026.
//
import Foundation
import Combine

@MainActor // => direkt main threadde çalışmasını istiyorsak kullanırsak "DispatchQueue.main.async" buna gerek yok
class CryptoListViewModel: ObservableObject {
    @Published var cryptoList=[MainViewModel]()
    let webService=WebService()
        
    func downloadCryptosContinuation(url:URL) async {
        do{
            let cryptos = try await webService.downloadCurrenciesContinuation(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(MainViewModel.init)
            }
        }catch {
            print("Error")
        }
    }
    
    func downloadCryptosAsync(url:URL) async {
        do{
            let cryptos = try await webService.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(MainViewModel.init)
            }
        }catch {
            print("Error")
        }
    }
    
    func downloadCryptos(url:URL){
        webService.downloadCurrencies(url: url){ result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let cryptos):
                if let cryptos=cryptos{
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(MainViewModel.init)
                    }
                }
            }
        }
    }
}
