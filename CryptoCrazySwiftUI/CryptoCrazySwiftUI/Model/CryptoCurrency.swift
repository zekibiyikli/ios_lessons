//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUI
//
//  Created by Zeki Mac on 2.04.2026.
//
import Foundation

struct CryptoCurrency:Identifiable,Codable{
    var id = UUID()
    let currency:String
    let price:String
    
    private enum CodingKeys : String,CodingKey{ //backendden gelen keyler farklıysa
        case currency = "currency"
        case price = "price"
    }
}
