//
//  LocationVC.swift
//  7erfety App
//
//  Created by AHMED on 7/10/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation

class LocationVC: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var mapView: MKMapView!
  
  var manager: CLLocationManager?
  
  var regionRadius: CLLocationDistance = 1000
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    manager = CLLocationManager()
    manager?.delegate = self
    manager?.desiredAccuracy = kCLLocationAccuracyBest
    
    checkLocationAuthStatus()
    
    centerMapOnUserLocation()
    
    mapView.delegate = self
    }
  
  func checkLocationAuthStatus(){
    if CLLocationManager.authorizationStatus() == .authorizedAlways{
      manager?.startUpdatingLocation()
    }else{
      manager?.requestAlwaysAuthorization()
    }
  }
  
  func centerMapOnUserLocation() {
    let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }

  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func centerMapBtnWasPressed(_ sender: Any) {
    centerMapOnUserLocation()
  }
}

extension LocationVC: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways{
      mapView.showsUserLocation = true
      mapView.userTrackingMode = .follow
    }
  }
}
