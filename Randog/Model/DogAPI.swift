//
//  DogAPI.swift
//  Randog
//
//  Created by Ruslan Ismayilov on 6/2/21.
//

import Foundation
class DogAPI {
    enum Endpoint : String {
        case randomImageFromAllDogCollection = "https://dog.ceo/api/breeds/image/random"
   
        
        var url : URL {
            return URL(string: self.rawValue)!
        }
    }
    
}
