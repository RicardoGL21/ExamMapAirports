//
//  MapViewController.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import Foundation
import UIKit
import Combine
import MapKit

class MapViewController:UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
        
    var delegate:TabBarController?
    var cancellable: AnyCancellable!
    
    override func viewDidLoad() {
        
        //Zoom to user location
        let viewRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(CLLocationDegrees(delegate?.userLatitude ?? 0.0), CLLocationDegrees(delegate?.userLongitude ?? 0.0)), latitudinalMeters: 4000, longitudinalMeters: 4000)
        mapView.setRegion(viewRegion, animated: true)
        
        //Here we observe changes in the variable responseAirports
        cancellable = delegate?.viewModel.$responseAirports.sink(receiveValue: {
            results in
            if let dataLocations = results {
                for location in dataLocations {
                    self.makeAnnotation(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0, name: location.name ?? "Airport")
                }
            }
        })
        
    }
    
    func makeAnnotation(latitude:Double,longitude:Double,name:String){
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
            self.mapView.addAnnotation(annotation)
    }
    
}

extension MapViewController:MKMapViewDelegate,CLLocationManagerDelegate{
    
}
