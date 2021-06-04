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
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, responce, error) in
            guard let data = data else{
                return
            }
            print(data)
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let url = json["message"] as! String
                print(url)
                
            }catch{
                print("error")
            }
        }
        task.resume()
    }


}

