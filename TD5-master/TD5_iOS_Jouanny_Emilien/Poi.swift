//
//  Poi.swift
//  TD5_iOS_Jouanny_Emilien
//
//  Created by Yggdragstyle on 04/01/2018.
//  Copyright © 2018 Yggdragstyle. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash
import SDWebImage
import MapKit



//  ∞ · · ·  P O I  · · · ∞

class Poi {
    
    var node: XMLIndexer
    var name: String
    var coordinate: CLLocationCoordinate2D
    var latitude: Float
    var longitude: Float
    var phone: String
    var mail: String
    var description: String
    
    var annotation: MKAnnotation?
    
    
    // IMAGE
    lazy var image: UIImageView = { () -> UIImageView in
        //
        
        let iv: UIImageView = UIImageView()
        
        if let str = (self.node.element?.attribute(by: "image")?.text), let url = URL(string: str) {
            
            iv.sd_setImage(with: url)
        }
        else { iv.image = UIImage(named: "empty.png")! }
        
        return iv
    }()
    
    
    
    
    
    
    // CONSTRUCTOR                · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·
    public init(node n: XMLIndexer) {
        
        node = n
        
        
        // NAME
        if let n = (node.element?.attribute(by: "name")?.text) { name = n }
        else { name = "empty" }
        
        
        
        // LATITUDE
        if let i = (node.element?.attribute(by: "latitude")?.text) { latitude = Float(i)! }
        else { latitude = 0 }
        
        // LONGITUDE
        if let i = (node.element?.attribute(by: "longitude")?.text) { longitude = Float(i)! }
        else { longitude = 0 }
        
        // COORDINATE
        coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
        
        
        
        // MAIL
        if let m = (node.element?.attribute(by: "mail")?.text) { mail = m }
        else { mail = "no email" }
        
        // PHONE
        if let p = (node.element?.attribute(by: "phone")?.text) { phone = p }
        else { phone = "no phone" }
        
        // DESCR
        if let p = (node.element?.attribute(by: "description")?.text) { description = p }
        else { description = "[ · · · ]" }
    }
}




