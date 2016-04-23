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

    @IBOutlet weak var labelTicker: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageViewPhoto : UIImageView!
    @IBOutlet weak var buttonSell : UIButton!
    let imagePicker = UIImagePickerController()

    struct Product {
        var oid : String
        var name: String
        var price: String
        var date: String
        var sold: Bool
        var captured : String
        var markets: String
        var capture_date: String
    }
   
    var products = [Product]()
    
    let tickerMessage = "Grouper @Aberdeen 30/kg @Sai Kung 40/kg Salmon @Aberdeen 20ea @Sai Kung 15ea Grouper @Aberdeen 30/kg @Sai Kung 40/kg Salmon @Aberdeen 20ea @Sai Kung 15ea "
    var tickerMessageIdx = 0
    
    func updateTicker() {
        tickerMessageIdx += 1
        if (tickerMessageIdx >= tickerMessage.characters.count / 2) {
            tickerMessageIdx = 0
        }
        labelTicker.text = tickerMessage.substringFromIndex(tickerMessage.startIndex.advancedBy(tickerMessageIdx))
    }
    
    func setupTicker() {
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(updateTicker), userInfo: nil, repeats: true)
    }
    
    func fetchStock() {
        let query = PFQuery.init(className: "item")
        query.orderByDescending("date")
        query.findObjectsInBackgroundWithBlock {
            (result: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for item in result! {
                    self.products.append(Product(oid: item.objectId!, name: item["name"] as! String, price: item["price"] as! String, date: item["price"] as! String, sold: false, captured: item["captured"] as! String, markets: item["markets"] as! String, capture_date: item["capture_date"] as! String))
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.refresh()
                })
            } else {
                print(error)
            }
        }
    }
    
    func setupRoundCornerButtons() {
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.frame.size.height / 2
        imageViewPhoto.clipsToBounds = true
        
        buttonSell.layer.cornerRadius = buttonSell.frame.size.height / 10
        buttonSell.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        setupTicker()
        fetchStock()
        /*
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
         */
        
        
        super.viewDidLoad()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell") as UITableViewCell?
        
        let idx = indexPath.item
        
        
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
        
        let cameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        let cameraView : CameraView = cameraViewController.view as! CameraView
        cameraView.frame =  self.imagePicker.view.frame
        
        imagePicker.modalPresentationStyle = .FullScreen
        presentViewController(imagePicker, animated: true,
            completion: {
                self.imagePicker.cameraOverlayView = cameraView
            }
        )
    }
    
    func showItemView() {
        /*
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ItemViewController") as! ItemViewController
        
        viewController.image = imageTemp
        viewController.masterView = self
        
        presentViewController(viewController, animated: true, completion: nil)
 */
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("done")
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        // load and resized image
        
        /*
         let image = info[UIImagePickerControllerOriginalImage] as! UIImage
         
         let resizeRate:CGFloat = 5.0
         
         let newSize = CGSizeMake(image.size.width / resizeRate, image.size.height / resizeRate)
        image.resize(newSize, completionHandler: { [weak self](resizedImage, data) -> () in
            let image = resizedImage
            self?.imageTemp = image
            // move to another view after resize
            self?.showProductView()
            })
 */
    }
    
    func imagePickerControllerDidCancel(_picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion:  nil)
    }
    
    func refresh() {
        self.tableView.reloadData()
    }
}

