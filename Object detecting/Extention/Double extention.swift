//
//  Double extention.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation

extension Float {
    func format(_ format:digitFormat) -> String {
        switch format {
        case .rounded:
            return  String(format: "%d", Int(self))
        case .twoDigit:
            return  String(format: "%0.2f", (self * 100))

        }
    }
}


enum digitFormat{
    // trimed
    case rounded
    
    // one decimal
    case twoDigit
}
