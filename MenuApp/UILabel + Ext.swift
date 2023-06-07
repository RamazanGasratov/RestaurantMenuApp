//
//  UILabel + Ext.swift
//  Rialto
//
//  Created by macbook on 23.05.2023.
//

import Foundation
import UIKit

extension UILabel {

    convenience init(text: String?, font: UIFont, color: UIColor? = nil) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
    }
}
