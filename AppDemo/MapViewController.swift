//
//  MapViewController.swift
//  AppDemo
//
//  Created by Andrea Perera on 11/13/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var hotelsMapDetails :Hotel?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        var keyLat:String = hotelsMapDetails!.latitude
        var keyLon:String = hotelsMapDetails!.longitude
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
        
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(keyLat.toFloat()),longitude: CLLocationDegrees(keyLon.toFloat()))
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = hotelsMapDetails!.title
        annotation.subtitle = hotelsMapDetails!.address
        mapView.addAnnotation(annotation)
    }
    //function for tap
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "latitude:" + String(format: "%.02f",annotation.coordinate.latitude) + "& longitude:" + String(format: "%.02f",annotation.coordinate.longitude)
        mapView.addAnnotation(annotation)
        
    }
    var selectedAnnotation: MKPointAnnotation?
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let latValStr : String = String(format: "%.02f",Float((view.annotation?.coordinate.latitude)!))
        let lonvalStr : String = String(format: "%.02f",Float((view.annotation?.coordinate.longitude)!))
        
        print("latitude: \(latValStr) & longitude: \(lonvalStr)")
    }
    
}
// Extend String with Two functions for converting Float and Double to string
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    func toFloat() -> Float {
        return (self as NSString).floatValue
    }
}
