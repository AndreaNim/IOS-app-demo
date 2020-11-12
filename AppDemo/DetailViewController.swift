//
//  DetailViewController.swift
//  AppDemo
//
//  Created by Andrea Perera on 11/13/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var lblHotelTitle: UILabel!
    
    @IBOutlet weak var lblHotelDetails: UILabel!
    var hotelsDetails :Hotel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let x : Int = (hotelsDetails?.hotelID)!
        var id = String(x)
        detailImage.image = UIImage(named:id)
        lblHotelTitle.text="\((hotelsDetails?.title)!)"
        lblHotelDetails.text="\((hotelsDetails?.description)!)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
