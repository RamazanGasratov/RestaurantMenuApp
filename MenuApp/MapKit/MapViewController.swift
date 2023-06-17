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
    var place = ModelMain()
    private let locationIdentifier = "locationIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupPlacemark()
        mapView.delegate = self
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
    
    private func setupPlacemark() {
        guard let location = place.location else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            
            if let error = error {
                print(error)
            }
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: locationIdentifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: locationIdentifier)
            annotationView?.canShowCallout = true
        }
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        return annotationView
    }
}
