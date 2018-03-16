//
//  CategoryCell.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit

class CategoryCell: UIView {
    
    
    // INTERFACE
    
    @IBInspectable var name: UILabel = UILabel()
    
    
    
    // PROPERTIES
    
    var category: Category!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        Design()
    }
    
    
    // DRAWING
    
    func Design() {
        
        // * * *   FRAME
        let h = self.frame.height
        let w = self.frame.width
        
        
        
        self.backgroundColor = UIColor.darkGray
        
        
        
        // * * *   NAME
        name.frame = CGRect(
            x: 15,
            y: 2,
            width: w - 30,
            height: h - 4)
        
        print("\n Name : \(category.name)\n")
        
        name.text = category.name
        name.font = name.font.withSize(16)
        name.font = name.font.bold()
        name.textColor = UIColor.white
        name.textAlignment = .center
        self.addSubview(name)
    }

}
