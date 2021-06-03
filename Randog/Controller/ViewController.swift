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
    }


}

