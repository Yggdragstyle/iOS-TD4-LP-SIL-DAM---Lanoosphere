//
//  DetailsPOIViewController.swift
//  TD5_iOS_Jouanny_Emilien
//
//  Created by Yggdragstyle on 05/01/2018.
//  Copyright © 2018 Yggdragstyle. All rights reserved.
//

import UIKit
import MapKit

class DetailsPOIViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    // PROPERTIES
    var poi: Poi!
    
    var img: UIImageView!
    
    // LOAD ...
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(poi.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        
        img.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)

    }
    
    
    // METHODS
    
    func prepare() {
        
//        image = poi.image
//        self.image.image = #imageLiteral(resourceName: "empty")
        
        img = poi.image

        self.view.addSubview(img)
        
        print("Preparation")
    }
    
    
    func matchesURLPhone(for number: String) -> URL? {
        
        let regex = "^\\+33 \\(0\\) (\\d|\\s)+$"
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = number as NSString
            let results = regex.matches(in: number, range: NSRange(location: 0, length: nsString.length))
            
            if let tel: String = (results.map { nsString.substring(with: $0.range)})[0] {
            
                return URL(string: "TEL://\(tel)")
            }
            
        }
        catch let error { print("invalid regex: \(error.localizedDescription)") }
        
        return nil
    }

    
    // ACTIONS
    @IBAction func CallPhone(_ sender: Any) {
        
        print(" You call the : \(poi.phone)")
        
        
        
        if let url = matchesURLPhone(for: poi.phone) {
//        if let url = URL(string: "TEL://\(poi.phone)") {
        
            print("mon numero :  \(url.path)")
            
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else { UIApplication.shared.open(URL(string: "TEL://0651424260")!, options: [:], completionHandler: nil) }
    }
    
    
    @IBAction func ShowMap(_ sender: Any) {
        
        print("You show the map")
    }
    
    @IBAction func SharePOI(_ sender: Any) {
        
        print("You share the map !")
        
        let activityVC = UIActivityViewController(activityItems: [img.image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
    
}
