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

//class CustomCollectionViewCell: UICollectionViewCell {
//
//    static let identifier = "CustomCollectionViewCell"
//
//    private let myIcon: UIImageView = {
//        let icon = UIImageView()
////        icon.image = testArray[indexPath.row]
//        icon.contentMode = .scaleAspectFill
//        icon.backgroundColor = .white
////        icon.clipsToBounds = true
//        icon.layer.cornerRadius = 20
//        return icon
//    }()
//
//    private let myView: UIImageView = {
//        let cardView = UIImageView()
//        cardView.contentMode = .scaleAspectFill
//        cardView.backgroundColor = .systemGray6
//        cardView.clipsToBounds = true
//        cardView.layer.cornerRadius = 20
//        return cardView
//    }()
//
//    private let myType: UILabel = {
//        let type = UILabel()
//        type.textColor = .systemBlue
//        type.font = UIFont.boldSystemFont(ofSize: 26)
//        type.textAlignment = .left
//        return type
//    }()
//
//    private let myDate: UILabel = {
//        let date = UILabel()
//        date.font = UIFont.boldSystemFont(ofSize: 15)
//        date.textAlignment = .right
//        return date
//    }()
//
//    private let myDuration: UILabel = {
//        let duration = UILabel()
//        duration.font = UIFont.boldSystemFont(ofSize: 15)
//        duration.textAlignment = .left
//        return duration
//    }()
//
//    private let myCalories: UILabel = {
//        let calories = UILabel()
//        calories.font = UIFont.boldSystemFont(ofSize: 15)
//        calories.textAlignment = .left
//        return calories
//    }()
//
//    private let caloriesLbl: UILabel = {
//        let caloriesLbl = UILabel()
//        caloriesLbl.text = "Calories"
//        caloriesLbl.textColor = .systemGray
//        caloriesLbl.font = UIFont.boldSystemFont(ofSize: 15)
//        caloriesLbl.textAlignment = .left
//        return caloriesLbl
//    }()
//
//    private let durationLbl: UILabel = {
//        let durationLbl = UILabel()
//        durationLbl.text = "Duration"
//        durationLbl.textColor = .systemGray
//        durationLbl.font = UIFont.boldSystemFont(ofSize: 15)
//        durationLbl.textAlignment = .left
//        return durationLbl
//    }()
//
//    override init(frame: CGRect){
//        super.init(frame: frame)
//        contentView.addSubview(myView)
//        myView.addSubview(myIcon)
//        myView.addSubview(myType)
//        myView.addSubview(myDate)
//        myView.addSubview(myDuration)
//        myView.addSubview(myCalories)
//        myView.addSubview(caloriesLbl)
//        myView.addSubview(durationLbl)
//        contentView.clipsToBounds = true
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        myType.frame = CGRect(x: 120, y: 10, width: 200, height: 50)
//        myDate.frame = CGRect(x: 250, y: 10, width: 100, height: 50)
//        myIcon.frame = CGRect(x: 10, y: 25, width: 100, height: 100)
//        myView.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-20, height: 150)
//        myCalories.frame = CGRect(x: 200, y: 60, width: 200, height: 20)
//        myDuration.frame = CGRect(x: 200, y: 90, width: 200, height: 20)
//        caloriesLbl.frame = CGRect(x: 120, y: 60, width: 80, height: 20)
//        durationLbl.frame = CGRect(x: 120, y: 90, width: 80, height: 20)
//
//
//
//    }
//
//    public func configure(image: UIImage, label: String, date: String, duration: String, calories: String){
//        myIcon.image = image
//        myType.text = label
//        myDate.text = date
//        myDuration.text = duration
//        myCalories.text = calories
//    }
//}
