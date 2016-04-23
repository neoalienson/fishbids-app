//
//  ItemEditViewController.swift
//  Fishbids
//
//  Created by Neo on 4/24/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController {

    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldPrice: UITextField!
    @IBOutlet weak var txtFieldCaptureDate: UITextField!
    @IBOutlet weak var txtFieldCaptured: UITextField!
    
    @IBOutlet weak var txtFieldMarkets: UITextView!
    
    
    var product : MainViewController.Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
