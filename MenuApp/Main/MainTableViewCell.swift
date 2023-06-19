//
//  MainTableViewCell.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//


import UIKit

final class MainTableViewCell: UITableViewCell {
    
    let imageViewRest = UIImageView()
    lazy var nameRestLabel = UILabel(text: "", font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18) ?? UIFont())
    lazy var localLabel = UILabel(text: "Локация", font: UIFont(name:"AppleSDGothicNeo-Regular" , size: 16) ?? UIFont())
    lazy var typeLabel = UILabel(text: "Тип", font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14) ?? UIFont())
    lazy var customStars = CustomStars()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewRest.layer.cornerRadius = imageViewRest.frame.size.height / 2
        imageViewRest.clipsToBounds = true
    }
    
    // MARK: Constraints
    private func setupConstraints(){
        
        //MARK: - setup View
        nameRestLabel.numberOfLines = 0
        localLabel.numberOfLines = 0
        
        let rightView = UIView()
        
        let stackViewLabel = UIStackView(axis: .vertical, distribution: .equalSpacing, spacing: 1, views: [nameRestLabel, localLabel, typeLabel])
        
        let leftStackView = UIStackView(axis: .horizontal, distribution: .fill, spacing: 5, views: [imageViewRest, stackViewLabel])
        
        let fullStackView = UIStackView(axis: .horizontal, distribution: .fillProportionally, spacing: 5, views: [leftStackView, rightView])
        
        contentView.addSubViews(fullStackView)
        rightView.addSubViews(customStars)
        
        NSLayoutConstraint.activate([
            
            fullStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            fullStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            fullStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            fullStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            customStars.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 28),
            customStars.leadingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: 5),
            customStars.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -5),
            customStars.bottomAnchor.constraint(equalTo: rightView.bottomAnchor, constant: -28),
            
            imageViewRest.heightAnchor.constraint(equalToConstant: 65),
            imageViewRest.widthAnchor.constraint(equalTo: imageViewRest.heightAnchor, multiplier: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


