//
//  ViewController.swift
//  Object detecting
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController{

    
    // Outlets to label, view and actions

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var suggest: UILabel!
    @IBAction func loadImage(_ sender: Any) { selectPhoto() }
    
    
    // properties
    let imagePicker = UIImagePickerController()
    let imageAnalyzer = ImageAnalyzer()
    let threshold:Float = 0.2
    
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func selectPhoto()
    {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
}

