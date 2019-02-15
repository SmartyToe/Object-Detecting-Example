//
//  ImgaeAnazlizer.swift
//  Object detecting
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 la-labs. All rights reserved.
//

import Foundation
import Vision
import UIKit

class ImageAnalyzer:NSObject {
    
    typealias imageDetectionComplition = (String)->()
    
    func getObject(using model: MLModel, image:UIImage,threshold: Float, complition:@escaping imageDetectionComplition)
    {
        
        guard let visionModel = try? VNCoreMLModel(for: model) else {
            fatalError("can't load Vision ML model")
        }
        let classificationRequest = VNCoreMLRequest(model: visionModel) { (request: VNRequest, error: Error?) in
           
            guard let observations = request.results else {
                return
            }
            
            // get main queue
            DispatchQueue.main.async {
                complition(self.helper(observations: observations, threshold: threshold))
            }
        
        }
        guard let cgImage = image.cgImage else {return}
        preformRequest(classificationRequest, cgImage: cgImage)
    }
    
    func preformRequest(_ request: VNCoreMLRequest, cgImage: CGImage)
    {
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do{
            try handler.perform([request])
            
        }catch let error as NSError {
            fatalError("Unexpected error ocurred: \(error.localizedDescription).")
        }
    }
    
    func helper(observations:[Any], threshold:Float ) -> String {
        
        // convert observations to probebility and labels
        let classifications = observations[0...4]
            .compactMap({ $0 as? VNClassificationObservation })
            .filter({ $0.confidence > threshold })
            .map({ "\($0.identifier) \($0.confidence.format(.twoDigit))%" })
        return classifications.joined(separator: "\n")
    }

}
