

//
//  ContentOfRowController.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 12/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit

class ContentOfRowController: UIViewController {
    
    
    // INTERFACE
    @IBInspectable var img: UIImageView = UIImageView()
    
    
    // PROPERTIES
    var elmt: Elmt!
    
    
    
    // DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // * * *   FRAME
        let h = self.view.frame.height - 44
        let w = self.view.frame.width
        
        self.title = self.elmt.name
        self.view.backgroundColor = UIColor.black
        self.navigationController!.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Contact", style: .plain, target: self, action: #selector(Contact))
        
        
        // * * *   IMAGE
        if let image: UIImageView = self.elmt.image_haut {
            
            self.img = image
            
            img.frame = CGRect(x: 0, y: 44, width: w, height: h)
            
            self.view = img
        }
        // * * *   DESCR
        else {
            
            let wv: UIWebView = self.elmt.descr
            wv.frame = CGRect(x: 0, y: 44, width: w, height: h)
            
            self.view = self.elmt.descr
        }
    }

    func Contact() {
        

        let formController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormController") as! FormController
        
        formController.elmt = elmt
        
        self.navigationController!.pushViewController(formController, animated: true)

    }
}
