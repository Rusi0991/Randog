//
//  ViewController.swift
//  Randog
//
//  Created by Ruslan Ismayilov on 6/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.requestRandomImage(completionHandler:handleRandomImageResponse(imageData:error:))
       
        
    }
    
    func handleRandomImageResponse(imageData : DogImage? , error : Error?){
        
        guard let imageUrl = URL(string: imageData?.message ?? "") else {
            return
        }
        
        DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileResponce(image:error:))
    }

    func handleImageFileResponce(image : UIImage?, error :Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

