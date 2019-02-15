//
//  ImgaePicker Delegate.swift
//  Object detecting
//
//  Created by Amir lahav on 15/02/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import UIKit

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        // set image
        imageView.image = image
        suggest.text = "detecting..."
        
        
        // detect image
        detectObject(in: image)
        
        // dismiss picker
        imagePicker.dismiss(animated:true,completion:nil)
        
    }
    
    // detect object with Inceptionv3
    func detectObject(in image:UIImage)
    {
        let inceptionv3model = Inceptionv3()
        
        // do task on background
        DispatchQueue.global(qos: .default).async {[weak self ] in
            
            guard let strongSelf:ViewController = self else { return }
            
            strongSelf.imageAnalyzer.getObject(using: inceptionv3model.model, image: image, threshold: strongSelf.threshold, complition: { (string) in
                strongSelf.suggest.text = string
            })
        }
    }
}
