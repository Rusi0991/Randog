//
//  BreedsListResponse.swift
//  Randog
//
//  Created by Ruslan Ismayilov on 6/17/21.
//

import Foundation


struct BreedsListResponse : Codable {
    let status : String
    let message : [String: [String]]
}
