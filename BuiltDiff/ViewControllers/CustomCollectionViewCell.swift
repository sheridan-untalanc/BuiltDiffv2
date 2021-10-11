//
//  CustomCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-09.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myIcon: UIImageView = {
        let icon = UIImageView()
//        icon.image = testArray[indexPath.row]
        icon.contentMode = .scaleAspectFill
        icon.backgroundColor = .red
//        icon.clipsToBounds = true
        icon.layer.cornerRadius = 10
        return icon
    }()
    
    private let myView: UIImageView = {
        let cardView = UIImageView()
        cardView.contentMode = .scaleAspectFill
        cardView.backgroundColor = .yellow
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
//        cardView.layer.shadowOpacity = 1
//        cardView.layer.shadowColor = UIColor.black.cgColor
//        cardView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        cardView.layer.shadowRadius = 10
        return cardView
    }()
    
    private let myType: UILabel = {
        let type = UILabel()
        type.text = "  Type"
        type.backgroundColor = .green
        type.font = UIFont.boldSystemFont(ofSize: 15)
        type.textAlignment = .left
        return type
    }()
    
    private let myDate: UILabel = {
        let date = UILabel()
        date.text = "  Type"
        date.backgroundColor = .green
        date.font = UIFont.boldSystemFont(ofSize: 15)
        date.textAlignment = .right
        return date
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(myView)
        myView.addSubview(myIcon)
        myView.addSubview(myType)
        myView.addSubview(myDate)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myType.frame = CGRect(x: 70, y: 10, width: 100, height: 50)
        myDate.frame = CGRect(x: 250, y: 10, width: 100, height: 50)
        myIcon.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        myView.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-20, height: contentView.frame.size.height)
    }
    
    public func configure(image: UIImage, label: String, date: String){
        myIcon.image = image
        myType.text = label
        myDate.text = date
    }
}
