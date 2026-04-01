//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Zeki Mac on 1.04.2026.
//
import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading:PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result{
            case .success(let currencies):
                self.cryptos.onNext(currencies)
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
            }
        }
    }

    
}



