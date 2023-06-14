//
//  MapViewController.swift
//  MenuApp
//
//  Created by macbook on 14.06.2023.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let buttonClose = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        buttonClose.setImage(UIImage(named: "camcel"), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        view.addSubViews(mapView, buttonClose)
   
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            buttonClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonClose.heightAnchor.constraint(equalToConstant: 30),
            buttonClose.widthAnchor.constraint(equalTo: buttonClose.heightAnchor, multiplier: 1)
        ])
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
}


