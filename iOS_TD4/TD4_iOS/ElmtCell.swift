//
//  ElmtCell.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit

class ElmtCell: TableViewCell {
    
    
    // INTERFACE
    
    @IBInspectable var name: UILabel = UILabel()
    
    @IBInspectable var barTransparent: UIView = UIView()
    
    @IBInspectable var borderBottom: UIView = UIView()
    
    @IBInspectable var cursor: UILabel = UILabel()
    
    @IBInspectable var img: UIImageView = UIImageView()
    

    var elmt: Elmt!
    
    
    override func child() {
        
        let lg_section: CGFloat = w * 0.8
        let h_bar: CGFloat = 30
        
        
        self.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 20, alpha: 1)
        self.backgroundColor = UIColor.lightGray
        
        
        
        
        // * * *   IMAGE
        self.img = self.elmt.image_large
        
        img.frame = CGRect(x: 0, y: 0, width: lg_section, height: h)
        img.alpha = 0
        
//        self.img.contentMode = UIViewContentMode.scaleAspectFit
        
        UIView.transition( with: self.img, duration: 2.0, options: .curveEaseOut, animations: {() -> Void in
            
            self.img.alpha = 1
        })
        
        self.addSubview(img)
        
        
        
        
        
        // * * *   BAR Transparent
        barTransparent.frame = CGRect(x: 0, y: h - h_bar, width: lg_section, height: h_bar)
        barTransparent.backgroundColor = UIColor(hue: 0, saturation: 100, brightness: 0, alpha: 0.4)
        self.addSubview(barTransparent)
        
        
        // * * *   BORDER BOTTOM
        borderBottom.frame = CGRect(x: 0, y: h - 2, width: w, height: 2)
        borderBottom.backgroundColor = UIColor(hue: 0, saturation: 100, brightness: 0, alpha: 1)
        self.addSubview(borderBottom)
        
        
        
        // * * *   NAME
        name.frame = CGRect(
            x: 5,
            y: h - h_bar,
            width: lg_section - 5,
            height: h_bar)
        
        name.text = elmt.name
        name.font = name.font.withSize(14)
        name.font = name.font.bold()
        name.textColor = UIColor.white
        name.textAlignment = .left
        self.addSubview(name)
        
        
        // * * *   CURSOR
        cursor.frame = CGRect(
            x: lg_section,
            y: 0,
            width: w - lg_section,
            height: h)
        
        cursor.text = ">"
        cursor.font = cursor.font.withSize(42)
        cursor.font = cursor.font.bold()
        cursor.textColor = UIColor.white
        cursor.textAlignment = .center
        self.addSubview(cursor)
    }

}
