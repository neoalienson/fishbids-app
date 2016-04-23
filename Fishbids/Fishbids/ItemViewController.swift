//
//  ItemViewController.swift
//  Fishbids
//
//  Created by Neo on 4/24/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    var product : MainViewController.Product!
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
