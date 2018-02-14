//
//  AnnotationView.swift
//  TD5_iOS_Jouanny_Emilien
//
//  Created by Yggdragstyle on 04/01/2018.
//  Copyright © 2018 Yggdragstyle. All rights reserved.
//

import UIKit
import MapKit

class AnnotationView: NSObject, MKAnnotation {

    
    var id: Int
    var title: String?
    var address: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(id: Int, title: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
    }
    
    var subtitle: String? {
        return address ?? "..."
    }

}
 
