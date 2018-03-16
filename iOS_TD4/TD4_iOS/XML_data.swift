//
//  XML_data.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash
import SDWebImage




        //  ∞ · · ·  C A T E G O R Y  · · · ∞

class Category {
    
    var node: XMLIndexer
    var listElmts: [Elmt] = [Elmt]()
    var id: Int
    var sort: Int
    var name: String
    
    public init(node n: XMLIndexer) {
        
        node = n
        
        
        // NAME
        if let n = (node.element?.attribute(by: "name")?.text) { name = n }
        else { name = "empty" }
        
        // ID
        if let i = (node.element?.attribute(by: "id")?.text) { id = Int(i)! }
        else { id = 0 }
        
        // SORT
        if let s = (node.element?.attribute(by: "sort")?.text) { sort = Int(s)! }
        else { sort = 0 }
        
        // list Child ELEMENTS
        for children in n["element"].all {
            
            listElmts.append( Elmt(node: children) )
        }
    }
}




        //  ∞ · · ·  E L E M E N T S  · · · ∞

class Elmt {
    
    var node: XMLIndexer
    var name: String
    var id: Int
    var mail: String
    var phone: String
    
    
    // IMAGE A L'ITALIENNE
    lazy var image_large: UIImageView = { () -> UIImageView in
//        
//        if let str = (self.node.element?.attribute(by: "image")?.text), let url = URL(string: str), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
//            
//            return img
//        }
//        else { return UIImage(named: "empty.png")! }
        
        let iv: UIImageView = UIImageView()
        
        if let str = (self.node.element?.attribute(by: "image")?.text), let url = URL(string: str) {
        
            iv.sd_setImage(with: url)
        }
        else { iv.image = UIImage(named: "empty.png")! }
        
        return iv
    }()
    
    // IMAGE A LA FRANCAISE
    lazy var image_haut: UIImageView? = {
        
//        if let str = (self.node.element?.attribute(by: "image_large")?.text), let url = URL(string: str), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
//            
//            return img
//        }
//        else { return nil }
        
        
        let iv: UIImageView = UIImageView()
        
        if let str = (self.node.element?.attribute(by: "image")?.text), let url = URL(string: str) {
            
            iv.sd_setImage(with: url)
            
            return iv
        }
        
        return nil
    }()
    
    // DESCR  (web view)
    lazy var descr: UIWebView = {
      
        let wv: UIWebView = UIWebView()
        var str: String
        
        if let s = (self.node.element?.attribute(by: "descr")?.text) { str = "<html><head><style>body { background: #333; padding: 5%; }</style></head><body>" + s + "</body></html>" }
        else { str = "<html><body><h1>No description</h1></body></html>"  }
        
        wv.loadHTMLString(str, baseURL: nil)
        
        return wv
    }()
    
    
    // *** CONSTRUCTOR
    init(node n: XMLIndexer) {
        
        node = n
        
        // NAME
        if let n = (node.element?.attribute(by: "name")?.text) { name = n }
        else { name = "empty" }
        
        // ID
        if let i = (node.element?.attribute(by: "id")?.text) { id = Int(i)! }
        else { id = 0 }
        
        // MAIL
        if let m = (node.element?.attribute(by: "email")?.text) { mail = m }
        else { mail = "null@domaine.ext" }
        
        // PHONE
        if let p = (node.element?.attribute(by: "phone")?.text) { phone = p }
        else { phone = "no phone" }
    }
}
