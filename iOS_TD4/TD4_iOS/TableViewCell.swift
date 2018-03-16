//
//  TableViewCell.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var h: CGFloat = 0, w: CGFloat = 0
    
    
    func Design() {
        
        // * * *   FRAME
        h = self.frame.height
        w = self.frame.width
        
        
        child() // Overridable function
    }
    
    func child() {}
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
