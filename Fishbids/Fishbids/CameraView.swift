//
//  CameraView.swift
//  Fishbids
//
//  Created by Neo on 4/24/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import UIKit

class CameraView: UIView {
    @IBAction func valueChanged(sender: AnyObject) {
        if (pageController.currentPage == 1) {
            imageOverlay.image = UIImage.init(imageLiteral: "reference1")
        } else if (pageController.currentPage == 2) {
            imageOverlay.image = UIImage.init(imageLiteral: "reference2")
        } else if (pageController.currentPage == 3) {
            imageOverlay.image = UIImage.init(imageLiteral: "reference3")
        } else {
            imageOverlay.image = UIImage.init(imageLiteral: "reference0")
        }
    }
    
    @IBOutlet weak var imageOverlay: UIImageView!
    
    @IBOutlet weak var pageController: UIPageControl!

}
