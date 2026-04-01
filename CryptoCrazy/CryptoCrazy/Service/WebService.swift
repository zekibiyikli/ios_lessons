//
//  WebService.swift
//  CryptoCrazy
//
//  Created by Zeki Mac on 1.04.2026.
//

import Foundation

class WebService{
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> ()){
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if error != nil{
                completion(.failure(.serverError))
            }else if let data = data{
                let cryptoList = try? JSONDecoder().decode([Crypto].self,from: data)
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }else{
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }

}
