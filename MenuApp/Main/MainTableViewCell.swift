//
//  MainTableViewCell.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//


import UIKit

class MainTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    // MARK: Constraints
    private func setupConstraints(){
       

        NSLayoutConstraint.activate([
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
