//
//  LoadingViewController.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit
import SWXMLHash

class LoadingViewController: UIViewController {
    
    
    // OUTLETS
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    
    // PROPERTIES
    
    var datas: [Category] = [Category]()
    
    let lang: String = Locale.preferredLanguages[0]
    
        
    // LOAD..
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hue: 16, saturation: 50, brightness: 100, alpha: 1)
        
        DispatchQueue.global(qos: .background).async {
         
            sleep(2)
            
            let myURLString = "http://fairmont.lanoosphere.com/mobile/getdata?lang=\(self.lang)"
            
            if let url = URL(string: myURLString) {
                
                URLSession.shared.dataTask(with: url, completionHandler: { (data, rep, err) -> Void in
                    
                    let xml = SWXMLHash.parse(data!)
                    
                    for node in xml["data"]["categories"]["category"].all {
                        
                        self.datas.append( Category(node: node) )
                    }
                    
                    
                    DispatchQueue.main.async() {
                        
                        let list = self.storyboard!.instantiateViewController(withIdentifier: "FairmontTable") as! FairmontTableController
                        
                        list.datas = self.datas
                        
                        let nav = UINavigationController(rootViewController: list)
                        
                        self.present( nav, animated: true )
                    }

                }).resume()
            }
        }
    }
}
