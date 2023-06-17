//
//  MapViewController.swift
//  MenuApp
//
//  Created by macbook on 14.06.2023.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let buttonClose = UIButton()
    private let locationButton = UIButton()
    var place = ModelMain()
    private let locationIdentifier = "locationIdentifier"
    let locationManager = CLLocationManager()
    let countLocation = 6000.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupPlacemark()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServices()
    }
    
    private func setupConstraints() {
        
        buttonClose.setImage(UIImage(named: "camcel"), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 35)
        locationButton.setImage(UIImage(systemName: "location.circle", withConfiguration: configuration), for: .normal)
        locationButton.tintColor = .black
        locationButton.addTarget(self, action: #selector(locatonUser), for: .touchUpInside)
        
        view.addSubViews(mapView, buttonClose, locationButton)
   
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            buttonClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            buttonClose.heightAnchor.constraint(equalToConstant: 30),
            buttonClose.widthAnchor.constraint(equalTo: buttonClose.heightAnchor, multiplier: 1),
            
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            locationButton.heightAnchor.constraint(equalToConstant: 30),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 1)
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func checkLocationServices() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAutorization()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Your Location is not Availeble",
                               message: "To give permission Go to: Setting -> MyPlace ->Location")
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
                //
            break
        case .denied:
            //
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        @unknown default:
            print("New case is availabel")
        }
    }
    
    @objc private func closeVC() {
        dismiss(animated: true)
    }
    
    @objc private func locatonUser() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: countLocation,
                                            longitudinalMeters: countLocation)
            mapView.setRegion(region, animated: true)
        }
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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
}
