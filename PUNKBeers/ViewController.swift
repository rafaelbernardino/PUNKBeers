//
//  ViewController.swift
//  PUNKBeers
//
//  Created by Rafael Bernardino on 16/07/17.
//  Copyright © 2017 Rafael Bernardino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTagline: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAbc: UILabel!
    @IBOutlet weak var lblIbu: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if beer != nil {
            lblName.text = beer.name
            lblTagline.text = beer.tagline
            lblDescription.text = beer.description
            lblAbc.text = "\(beer.abv)"
            lblIbu.text = "\(beer.ibu)"
            title = beer.name
            
            Rest.downloadImage(url: beer.image) {(image: UIImage?) in
                DispatchQueue.main.async {
                    self.ivImage.image = image
                }
            }
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

