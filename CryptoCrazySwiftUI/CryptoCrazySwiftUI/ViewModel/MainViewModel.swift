//
//  MainViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Zeki Mac on 2.04.2026.
//

import Foundation

struct MainViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID?{
        crypto.id
    }
    
    var currency : String?{
        crypto.currency
    }

    var price : String?{
        crypto.price
    }

}
