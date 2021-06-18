//
//  ViewController.swift
//  Randog
//
//  Created by Ruslan Ismayilov on 6/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickeView: UIPickerView!
    var breeds : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickeView.delegate = self
        pickeView.dataSource = self
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
        
    }
    
    func handleBreedsListResponse(breeds : [String], error : Error?){
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickeView.reloadAllComponents()
        }
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
extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents( in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        breeds.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
}
