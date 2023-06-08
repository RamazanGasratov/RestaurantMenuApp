//
//  CustomTextFeildView.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import UIKit

class CustomTextFeildView: UIView {
   
    private lazy var textField: UITextField = UITextField()
    private lazy var nameLabel: UILabel = UILabel(text: "", font: UIFont(name:"AppleSDGothicNeo-Thin" , size: 20) ?? UIFont())
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String, placeHolder: String) {
        self.init(frame: .infinite)
        
        textField.placeholder = placeHolder
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.cornerRadius = 6
        textField.clipsToBounds = true
        textField.returnKeyType = .done
        textField.delegate = self
        //TODO: - почему текст не слева как положено 
        textField.textAlignment = .center
        nameLabel.text = text
        
        let fullStackView = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 7, views: [nameLabel, textField])
        
        self.addSubViews(fullStackView)
        
        NSLayoutConstraint.activate([
            fullStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            fullStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            textField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - TextFieldDelegate
extension CustomTextFeildView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
