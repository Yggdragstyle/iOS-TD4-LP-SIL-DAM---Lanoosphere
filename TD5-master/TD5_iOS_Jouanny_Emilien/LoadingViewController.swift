//
//  LoadingViewController.swift
//  TD5_iOS_Jouanny_Emilien
//
//  Created by Yggdragstyle on 04/01/2018.
//  Copyright © 2018 Yggdragstyle. All rights reserved.
//

import UIKit
import SWXMLHash

class LoadingViewController: UIViewController {
    
    
    // OUTLETS
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    
    // PROPERTIES
    
    var datas: [Poi] = [Poi]()
    
    
    // LOAD..
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2);
        indicatorView.transform = transform;
        
        
        DispatchQueue.global(qos: .background).async {
            
            sleep(2)
            
            let myURLString = "http://sfcr.lanoosphere.com/poi.xml"
            
            if let url = URL(string: myURLString) {
                
//                if let data = try? Data(contentsOf: url) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, rep, err) -> Void in
                
                    let xml = SWXMLHash.parse(data!)
                    
                    for node in xml["Data"]["POI"].all {
                        
                        self.datas.append( Poi(node: node) )
                    }
                    
                    
                    DispatchQueue.main.async() {
                        
                        let map = self.storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                        
                        map.datas = self.datas
                        
                        let nav = UINavigationController(rootViewController: map)
                        
                        self.present( nav, animated: true )
                    }
                    
//                }
                }).resume()
            }
        }
    }
}

