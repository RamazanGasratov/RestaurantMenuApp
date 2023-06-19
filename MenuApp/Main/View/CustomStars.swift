//
//  CustomStars.swift
//  MenuApp
//
//  Created by macbook on 14.06.2023.
//

import UIKit

final class CustomStars: UIStackView {
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    private var starSize: CGSize = CGSize(width: 20, height: 8) {
        didSet {
            setupButton()
        }
    }
    
    private var starCount = 5 {
        didSet {
            setupButton()
        }
    }
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        self.spacing = 5
        self.distribution = .fillEqually    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setup Button
    private func setupButton() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button image
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            //Set the button image
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            //MARK: - Setup the button action
            
            
            addArrangedSubview(button)
            
            // Add the new button on the rating button array
            ratingButtons.append(button)
        }
        updateButtonSelectionState()
    }
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
