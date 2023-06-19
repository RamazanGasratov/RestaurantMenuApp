//
//  UIViewController+Ext.swift
//  LAWSON
//
//  Created by macbook on 21.02.2023.
//

import UIKit
extension UIViewController {
    func updateBackButton(){
        if self.navigationController != nil {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        }
    }
}
