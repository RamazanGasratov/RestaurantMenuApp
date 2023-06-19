//
//  StackView+Ext.swift
//  LAWSON
//
//  Created by macbook on 28.02.2023.
//

import UIKit

extension UIStackView {
    
    convenience init( axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, spacing: CGFloat, views: [UIView]){
        self.init(arrangedSubviews: views)
        
        self.backgroundColor = .clear
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
}
