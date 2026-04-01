//
//  dummyData.swift
//  FavoriteBook
//
//  Created by Zeki Mac on 1.04.2026.
//
let item1 = FavoriteElements(name: "title 1", imageName: "image", description: "description 1")
let item2 = FavoriteElements(name: "title 2", imageName: "image", description: "description 2")
let item3 = FavoriteElements(name: "title 3", imageName: "image", description: "description 3")
let item4 = FavoriteElements(name: "title 4", imageName: "image", description: "description 4")
let item5 = FavoriteElements(name: "title 5", imageName: "image", description: "description 5")
let item6 = FavoriteElements(name: "title 6", imageName: "image", description: "description 6")

let base1 = FavoriteModel(title: "base 1", elements: [item1,item2,item3])
let base2 = FavoriteModel(title: "base 2", elements: [item4,item5,item6])

let myFavorites = [base1,base2]
