//
//  Beer.swift
//  PUNKBeers
//
//  Created by Rafael Bernardino on 16/07/17.
//  Copyright © 2017 Rafael Bernardino. All rights reserved.
//

import Foundation

class Beer {
    var id: Int?
    var name: String
    var tagline: String
    var description : String
    var image: String
    var abv: Double
    var ibu: Int
    
    init (name: String, tagline: String, description: String, image: String, abv:Double, ibu:Int){
        self.name = name
        self.tagline = tagline
        self.description = description
        self.image = image
        self.abv = abv
        self.ibu = ibu
    }    
}
