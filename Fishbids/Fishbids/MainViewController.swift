//
//  ViewController.swift
//  Fishbids
//
//  Created by Neo on 4/23/16.
//  Copyright © 2016 fishbids. All rights reserved.
//

import Parse
import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageViewPhoto : UIImageView!
    @IBOutlet weak var buttonSell : UIButton!
    let imagePicker = UIImagePickerController()

    struct Product {
        var name: String
        var price: String
        var date: String
        var sold: Bool
    }
   
    var products = [Product]()
    
    override func viewDidLoad() {
        /*
        products.append(Product(name : "5x 50cm Grouper", price : "$130 HKD", date : "April 23, 2016", sold : false))
        products.append(Product(name : "5x 50cm 10kg Salmon", price : "$155 HKD", date : "April 23, 2016", sold : false))
        products.append(Product(name : "1x 5kg Lobster", price : "$155 HKD", date : "April 23, 2016", sold : false))
        products.append(Product(name : "12kg Shrimp", price : "$50 HKD", date : "April 22, 2016", sold : false))
        products.append(Product(name : "2 20cm Squid", price : "$60 HKD", date : "April 22, 2016", sold : false))
 
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
         */
        
        let query = PFQuery.init(className: "item")
        query.findObjectsInBackgroundWithBlock {
            (result: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for item in result! {
                    self.products.append(Product(name: item["name"] as! String, price: item["price"] as! String, date: item["price"] as! String, sold: false))
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.refresh()
                })
            } else {
                print(error)
            }
        }
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        //
        // If there is no network connection, we will hit the cache first
        
        super.viewDidLoad()
        
        // round corner buttons
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.frame.size.height / 2
        imageViewPhoto.clipsToBounds = true
        
        buttonSell.layer.cornerRadius = buttonSell.frame.size.height / 10
        buttonSell.clipsToBounds = true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell") as UITableViewCell?
        
        let idx = indexPath.item
        print(idx)
        
        let view = cell!.contentView.subviews[1] as UIView
        
        view.layer.cornerRadius = view.frame.size.height / 2
        
        let labelName = cell!.contentView.subviews[2] as? UILabel
        
        labelName!.text = products[idx].name
        
        let product = products[indexPath.item] as Product
        
        let labelPrice = cell!.contentView.subviews[0] as? UILabel
        labelPrice!.text = product.price
        
        let labelDate = cell!.contentView.subviews[3] as? UILabel
        labelDate!.text = product.date
        return cell!
    }
    
    @IBAction func buttonStart(sender: AnyObject) {
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func showProductView() {
        /*
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductAddViewController") as! ProductAddViewController
        
        viewController.image = imageTemp
        viewController.masterView = self
        
        presentViewController(viewController, animated: true, completion: nil)
 */
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        // load and resized image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let resizeRate:CGFloat = 5.0
        
        let newSize = CGSizeMake(image.size.width / resizeRate, image.size.height / resizeRate)
        
        /*
        image.resize(newSize, completionHandler: { [weak self](resizedImage, data) -> () in
            let image = resizedImage
            self?.imageTemp = image
            // move to another view after resize
            self?.showProductView()
            })
 */
    }
    
    func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh() {
        self.tableView.reloadData()
    }
}

