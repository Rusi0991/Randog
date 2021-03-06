//
//  DogAPI.swift
//  Randog
//
//  Created by Ruslan Ismayilov on 6/2/21.
//

import Foundation
import UIKit
class DogAPI {
    enum Endpoint {
        case randomImageFromAllDogCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url : URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed) :
            return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds :
                return "https://dog.ceo/api/breeds/list/all"
            
            }
        }
    }
    class func requestBreedsList(completionHandler : @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsRespose = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsRespose.message.keys.map({$0})
            
//            breeds.sorted(){$0 < $1}
            
            completionHandler(breeds.sorted(), nil)
        }
        task.resume()
    }
    
    
    class func requestRandomImage(breed : String, completionHandler :@escaping (DogImage?, Error?) ->Void ){
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, responce, error) in
            guard let data = data else{
                completionHandler(nil, error)
                return
            }

            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
        }
                    
            
            task.resume()
    }
        
       class func requestImageFile(url : URL ,  completionHandler : @escaping (UIImage? , Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                completionHandler(nil,error)
                return
                
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
    }
        task.resume()
}
}

