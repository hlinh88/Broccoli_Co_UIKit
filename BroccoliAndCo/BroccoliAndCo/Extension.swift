//
//  Extension.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 19/2/2023.
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .black : .white
        }
    }
}

extension UILabel {
    
 
    
    enum ViewSide {
           case left, right, top, bottom
       }
       
       func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
           
           let border = CALayer()
           border.backgroundColor = color
           
           switch side {
           case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
           case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
           case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
           case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
           }
           layer.masksToBounds = true
           
           layer.addSublayer(border)
       }
}


