//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var filteredImage: UIImage?
    var unFilteredImage: UIImage?
    var unFilteredRGBAImage: RGBAImage?
    var originalImage : UIImage?
    var filteredUsed : Bool = false
    
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        reInit()
    }
    
    
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        print("orginal new Photo -  saveD")
        reInit()
    }

    func reInit() {
        originalImage = imageView.image
        compareButton.selected = false
        compareButton.enabled = false
        filteredUsed = false
    }
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        
        originalImage = imageView.image
        
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    
    @IBAction func onFilterRed(sender: UIButton) {
        self.unFilteredImage = imageView.image
        self.unFilteredRGBAImage = RGBAImage(image: self.unFilteredImage!)
        
        for y in 0..<self.unFilteredRGBAImage!.height {
            for x in 0..<self.unFilteredRGBAImage!.width {
                let index = y * self.unFilteredRGBAImage!.width + x
                var pixel = self.unFilteredRGBAImage!.pixels[index]
                pixel.red = UInt8(max(min(255, Int(pixel.red) + 30), 0))
                self.unFilteredRGBAImage!.pixels[index] = pixel
            }
        }
        imageView.image = self.unFilteredRGBAImage!.toUIImage()
        filterApplied()
    }
    
    func filterApplied(){
        filteredImage = imageView.image
        filteredUsed = true
        if !filteredUsed {
            filteredUsed = true
            
        }
        
        compareButton.enabled = true
    }
    
    @IBAction func onFilterGreen(sender: AnyObject) {
        self.unFilteredImage = imageView.image
        self.unFilteredRGBAImage = RGBAImage(image: self.unFilteredImage!)
        
        for y in 0..<self.unFilteredRGBAImage!.height {
            for x in 0..<self.unFilteredRGBAImage!.width {
                let index = y * self.unFilteredRGBAImage!.width + x
                var pixel = self.unFilteredRGBAImage!.pixels[index]
                pixel.green = UInt8(max(min(255, Int(pixel.red) + 30), 0))
                self.unFilteredRGBAImage!.pixels[index] = pixel
            }
        }
        imageView.image = self.unFilteredRGBAImage!.toUIImage()
        filterApplied()

    }
    
    @IBAction func onFilterBlue(sender: UIButton) {
        self.unFilteredImage = imageView.image
        self.unFilteredRGBAImage = RGBAImage(image: self.unFilteredImage!)
        
        for y in 0..<self.unFilteredRGBAImage!.height {
            for x in 0..<self.unFilteredRGBAImage!.width {
                let index = y * self.unFilteredRGBAImage!.width + x
                var pixel = self.unFilteredRGBAImage!.pixels[index]
                pixel.blue = UInt8(max(min(255, Int(pixel.red) + 30), 0))
                self.unFilteredRGBAImage!.pixels[index] = pixel
            }
        }
        imageView.image = self.unFilteredRGBAImage!.toUIImage()
        
        filterApplied()

        
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if (sender.selected == true) {
            
            print("not - selected")
            filterButton.selected = false
            hideSecondaryMenu()
            imageView.image = filteredImage
            sender.selected = false
            
        } else {
            print("selected")
            filterButton.selected = false
            imageView.image = unFilteredImage
            sender.selected = true
            hideSecondaryMenu()
        }
        
        
    }
    
    @IBAction func onFilterYellow(sender: UIButton) {
        self.unFilteredImage = imageView.image
        self.unFilteredRGBAImage = RGBAImage(image: self.unFilteredImage!)
        
        for y in 0..<self.unFilteredRGBAImage!.height {
            for x in 0..<self.unFilteredRGBAImage!.width {
                let index = y * self.unFilteredRGBAImage!.width + x
                var pixel = self.unFilteredRGBAImage!.pixels[index]
                pixel.blue = UInt8(max(min(50, Int(pixel.red) + 50), 40))
                
                self.unFilteredRGBAImage!.pixels[index] = pixel
            }
        }
        imageView.image = self.unFilteredRGBAImage!.toUIImage()
        filterApplied()

    }
    
    @IBAction func onFilterPurple(sender: UIButton) {
        
    
        self.unFilteredImage = imageView.image
        self.unFilteredRGBAImage = RGBAImage(image: self.unFilteredImage!)
        
        for y in 0..<self.unFilteredRGBAImage!.height {
            for x in 0..<self.unFilteredRGBAImage!.width {
                let index = y * self.unFilteredRGBAImage!.width + x
                var pixel = self.unFilteredRGBAImage!.pixels[index]
                pixel.green = UInt8(max(min(100, Int(pixel.red) + 10), 20))
                
                self.unFilteredRGBAImage!.pixels[index] = pixel
            }
        }
        imageView.image = self.unFilteredRGBAImage!.toUIImage()
        filterApplied()

        
    }
    
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
}

