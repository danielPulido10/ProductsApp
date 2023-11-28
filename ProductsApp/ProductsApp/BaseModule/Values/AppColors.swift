//
//  AppColors.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation
import UIKit

enum AppColors: CaseIterable {
    case white, 
         purple,
         black
    
    var color: UIColor {
        switch self {
        case .white:
            return UIColor(red: 252, green: 252, blue: 252, alpha: 1)
        case .purple:
            return UIColor(red: 62/255, green: 7/255, blue: 98/255, alpha: 1)
        case .black:
            return UIColor(red: 28/255, green: 31/255, blue: 43/255, alpha: 1)
        }
    }
}

