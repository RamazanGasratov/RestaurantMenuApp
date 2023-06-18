//
//  MapViewController.swift
//  MenuApp
//
//  Created by macbook on 14.06.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
   func getAddress(_ address: String?)
}

final class MapViewController: UIViewController {
    
    var mapViewControllerDelegate: MapViewControllerDelegate? = nil
    var inUpShow = false
    var tag = 0
    private let mapView = MKMapView()
    private let buttonClose = UIButton()
    private let locationButton = UIButton()
    private let doneButton = UIButton()
    private let grearButton = UIButton()
    private let pickerLocation = UIImageView()
    private let currentAddressLable = UILabel(text: "", font: UIFont(name: "AppleSDGothicNeo-Regular", size: 25) ?? UIFont())
    var place = ModelMain()
    private let locationIdentifier = "locationIdentifier"
    private let locationManager = CLLocationManager()
    private let countLocation = 6000.00
    var location = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupPlacemark()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch tag {
        case 1: checkLocationServices()
        case 2: userLocation()
        default:
            break
        }
    }
    
    private func setupConstraints() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 35)
        let configurationPin = UIImage.SymbolConfiguration(pointSize: 25)
        pickerLocation.image = UIImage(systemName: "mappin", withConfiguration: configurationPin)
        pickerLocation.tintColor = .red
        
        currentAddressLable.textAlignment = .center
        currentAddressLable.numberOfLines = 0
        
        doneButton.setTitle("DONE", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        doneButton.isHidden = false
        
        grearButton.setImage(UIImage(systemName: "mappin.and.ellipse", withConfiguration: configuration), for: .normal)
        grearButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        grearButton.isHidden = false
        
        buttonClose.setImage(UIImage(named: "camcel"), for: .normal)
        buttonClose.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        locationButton.setImage(UIImage(systemName: "location.circle", withConfiguration: configuration), for: .normal)
        locationButton.tintColor = .black
        locationButton.addTarget(self, action: #selector(locatonUser), for: .touchUpInside)
        
        view.addSubViews(mapView, buttonClose, locationButton, pickerLocation, currentAddressLable, doneButton, grearButton)
   
        NSLayoutConstraint.activate([
            
            currentAddressLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            currentAddressLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentAddressLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            grearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            grearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            grearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
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
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 1),
            
            pickerLocation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerLocation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
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
        currentAddressLable.isHidden = inUpShow
        doneButton.isHidden = inUpShow
        grearButton.isHidden = false
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
    
    private func userLocation() {
        currentAddressLable.isHidden = inUpShow
        doneButton.isHidden = inUpShow
        grearButton.isHidden = true
        let region = MKCoordinateRegion(center: location, latitudinalMeters: countLocation,
                                            longitudinalMeters: countLocation)
            mapView.setRegion(region, animated: true)
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
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
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: countLocation,
                                            longitudinalMeters: countLocation)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func doneButtonPressed() {
        mapViewControllerDelegate?.getAddress(currentAddressLable.text)
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(center) { placemarks, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildNumber = placemark?.subThoroughfare
            DispatchQueue.main.async {
                if streetName != nil && buildNumber != nil {
                    self.currentAddressLable.text = "\(streetName!), \(buildNumber!)"
                } else if streetName != nil {
                    self.currentAddressLable.text = "\(streetName!)"
                } else {
                    self.currentAddressLable.text = ""
                }
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
}
