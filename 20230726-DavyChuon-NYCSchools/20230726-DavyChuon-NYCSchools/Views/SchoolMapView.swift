//
//  SchoolMapView.swift
//  20230726-DavyChuon-NYCSchools
//
//  Created by Davy Chuon on 7/27/23.
//

import UIKit
import MapKit
import CoreLocation

// Custom UIView to display map with location pinned
class SchoolMapView: UIView {

    // MARK: - UI Components
    let mapView = MKMapView()
    var coordinate = CLLocationCoordinate2D()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ coord: CLLocationCoordinate2D?) {
        self.init(frame: .zero)
        
        guard let coord = coord else { return }
        coordinate.latitude = coord.latitude
        coordinate.longitude = coord.longitude

        addPinToMap()
    }
    
    
    // MARK: - UI Setup
    private func configureView() {
        addSubview(mapView)
        translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
    }
    
    
    // MARK: - Methods
    
    // Adds pin annotation on map view based on location initialized
    private func addPinToMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
}
