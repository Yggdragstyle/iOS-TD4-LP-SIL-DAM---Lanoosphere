//
//  FairmontTableController.swift
//  TD4_iOS
//
//  Created by Yggdragstyle on 05/12/2017.
//  Copyright © 2017 Yggdragstyle. All rights reserved.
//

import UIKit
import SWXMLHash

class FairmontTableController: UITableViewController {
    
    
    
    // PROPERTIES
    
    var datas: [Category]!
    
    var nav: UINavigationController!
    
    var headerHeight: CGFloat = 180;
    
    
    
    // LOAD ...
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav = self.navigationController!
        let bar = nav.navigationBar
        bar.barStyle = UIBarStyle.black;
        bar.barTintColor = UIColor.init(red: 0, green: 0.1, blue: 0.1, alpha: 1)
        bar.topItem?.title = "HOME"
    }
    
    
  

//   * * *   O V E R R I D E
    
    // COUNTERS
    override func numberOfSections(in tableView: UITableView) -> Int { return datas.count }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return datas[section].listElmts.count }
    
    
    // HEIGHTS
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return headerHeight }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 40 }
    
    
    // HEADER
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        print(section)
//        print(datas[section].name)
        
        let header = CategoryCell()
            header.category = datas[section]
        
        return header
    }
    
    
    // ROW
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ElmtCell {
        
        let cell: ElmtCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ElmtCell
            cell.elmt = datas[indexPath.section].listElmts[indexPath.row]
            cell.Design()
        
        return cell
    }
    
    
    // EVENTS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ContentOfRow: ContentOfRowController = ContentOfRowController()
        ContentOfRow.elmt = datas[indexPath.section].listElmts[indexPath.row]
        
//        self.present(ContentOfRow, animated: true) //, completion: closure
        self.navigationController!.pushViewController(ContentOfRow, animated: true)
    }
    
// - - - - - - - - -
    
    
}



