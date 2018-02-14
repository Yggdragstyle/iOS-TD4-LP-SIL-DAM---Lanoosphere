//
//  MapViewController.swift
//  TD5_iOS_Jouanny_Emilien
//
//  Created by Yggdragstyle on 04/01/2018.
//  Copyright © 2018 Yggdragstyle. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    // OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    
    
    // PROPERTIES               · · · · · · · · · · · · · · · · · · · ·
    
    var nav: UINavigationController!
    
    var datas: [Poi]!
    let initialLocation = CLLocationCoordinate2DMake(43.551534, 7.016659)
    let regionRadius: CLLocationDistance = 5500
    let locationManager = CLLocationManager()
    
    // ON LOAD ...              · · · · · · · · · · · · · · · · · · · ·
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav = self.navigationController!
        let bar = nav.navigationBar
        bar.barStyle = UIBarStyle.black;
        bar.barTintColor = UIColor.init(red: 0.1, green: 0.4, blue: 0.5, alpha: 1)
        bar.topItem?.title = "HOME"


        centerMapOnLocation(location: initialLocation)
        
        self.loadPOI()
        
        
        // Ask for user permission to access location infos
        locationManager.requestWhenInUseAuthorization()
        
        // Show the user current location
        mapView.showsUserLocation = true
        
        mapView.delegate = self
    }
    
    
    
    // METHODS                  · · · · · · · · · · · · · · · · · · · ·
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
    }
    
    // DELEGATE MAPVIEW
    @objc(mapView:viewForAnnotation:) func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  
        let reuseIdentifier = "poi"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! AnnotationView
        
        
        let img = #imageLiteral(resourceName: "pin")
        annotationView!.image = img
        
        annotationView!.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        
        let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(#imageLiteral(resourceName: "info"), for: .normal)
            btn.tag = customPointAnnotation.id
            btn.addTarget(self, action: #selector(MapViewController.getInfo(_:)), for: .touchUpInside)
        
        annotationView!.rightCalloutAccessoryView = btn
        
        return annotationView
    }
    
    
    // BTN LISTENER -> present a custom page
    func getInfo(_ sender: UIButton) {
        
        let poi: Poi = self.datas[sender.tag]
        
        print("\n")
        print(poi.name)
        
        let detailsPOI = self.storyboard!.instantiateViewController(withIdentifier: "detailsPOI") as! DetailsPOIViewController
        detailsPOI.poi = poi
        detailsPOI.prepare()
        
        self.nav.pushViewController(detailsPOI, animated: true)
    }
    
    
    // Load the POI
    func loadPOI() {
        
        print(datas)
     
        var index = 0
        
        // for each POI
        for poi: Poi in datas {
            
            // Add annotation
            let pin = AnnotationView(id: index, title: poi.name, coordinate: poi.coordinate)
            self.mapView.addAnnotation(pin)
            
            poi.annotation = pin
            
            
            // Get address
            let location = CLLocation(latitude: poi.coordinate.latitude, longitude: poi.coordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placeMarker, error) in
                
                if  error == nil,
                    let place = placeMarker?[0],
                    let sub  = place.subThoroughfare,
                    let road = place.thoroughfare,
                    let cp   = place.postalCode,
                    let city = place.locality {
                    
                    print("\(poi.name)\n \(sub) \(road) \(cp) \(city)\n\n")
                    
                    pin.address = "\(sub) \(road) \(cp) \(city)"
                }
            })
            
            index += 1
        }
    }
    

}
