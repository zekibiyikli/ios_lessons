//
//  FavoriteModel.swift
//  FavoriteBook
//
//  Created by Zeki Mac on 1.04.2026.
//
import Foundation

struct FavoriteModel:Identifiable{
    var id=UUID()
    var title:String
    var elements: [FavoriteElements]
}
