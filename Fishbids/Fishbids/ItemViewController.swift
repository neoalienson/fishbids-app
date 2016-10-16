//
//  ItemViewController.swift
//  Fishbids
//
//  Created by Neo on 4/24/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var captured: UILabel!
    @IBOutlet weak var capture_date: UILabel!
    @IBOutlet weak var markets: UITextView!
    
    var product : MainViewController.Product!
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let p = product!
        name.text = p.name
        price.text = p.price
        captured.text = p.captured
        capture_date.text = "Captured on " + p.capture_date
        markets.text = p.markets
    }


}
