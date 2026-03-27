//
//  Simpsons.swift
//  SimpsonsBook
//
//  Created by Mono on 27.03.2026.
//

import Foundation
import UIKit

class Simpsons{
    var name:String?
    var image:UIImage?
    var detail:String?
    
    init(name: String? = nil, image: UIImage? = nil, detail: String? = nil) {
        self.name = name
        self.image = image
        self.detail = detail
    }
    
    init(){}
}
