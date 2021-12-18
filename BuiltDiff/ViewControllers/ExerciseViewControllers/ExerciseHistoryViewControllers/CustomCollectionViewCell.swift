//
//  CustomCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-09.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var myIcon: UIImageView!
    @IBOutlet var myCalories: UILabel!
    @IBOutlet var myDuration: UILabel!
    @IBOutlet var myType: UILabel!
    @IBOutlet var myDate: UILabel!
    
    func configure(image: UIImage, label: String, date: String, duration: String, calories: String){
            myIcon.image = image
            myType.text = label
            myDate.text = date
            myDuration.text = duration
            myCalories.text = calories
        }
    
}
