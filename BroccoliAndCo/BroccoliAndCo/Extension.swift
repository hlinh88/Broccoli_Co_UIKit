//
//  Extension.swift
//  BroccoliAndCo
//
//  Created by Hoang Linh Nguyen on 19/2/2023.
//

import Foundation
import UIKit

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


