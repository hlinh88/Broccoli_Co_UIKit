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
