//
//  MainTableViewCell.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//


import UIKit

class MainTableViewCell: UITableViewCell {
    
     let imageViewRest = UIImageView()
     lazy var nameRestLabel = UILabel(text: "", font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18) ?? UIFont())
     lazy var localLabel = UILabel(text: "Локация", font: UIFont(name:"AppleSDGothicNeo-Regular" , size: 16) ?? UIFont())
     lazy var typeLabel = UILabel(text: "Тип", font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14) ?? UIFont())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    // MARK: Constraints
    private func setupConstraints(){
       
        let stackViewLabel = UIStackView(axis: .vertical, distribution: .fill, spacing: 4, views: [nameRestLabel, localLabel, typeLabel])
        
        let leftStackView = UIStackView(axis: .horizontal, distribution: .fill, spacing: 5, views: [imageViewRest, stackViewLabel])
        
        contentView.addSubViews(leftStackView)

        NSLayoutConstraint.activate([
        
            leftStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            leftStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            leftStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            //TODO: - разобраться с размерами изображения почему округляется при скролле?
            imageViewRest.heightAnchor.constraint(equalToConstant: 65),
            imageViewRest.widthAnchor.constraint(equalTo: imageViewRest.heightAnchor, multiplier: 1)
        ])
    }
    
    private func setupView() {
        
    }
    
//    public setConfiguration() {
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


