//
//  GroupCustomCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-12.
//

import UIKit

class GroupCustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GroupCustomCollectionViewCell"
        
//        private let myIcon: UIImageView = {
//            let icon = UIImageView()
//    //        icon.image = testArray[indexPath.row]
//            icon.contentMode = .scaleAspectFill
//            icon.backgroundColor = .red
//    //        icon.clipsToBounds = true
//            icon.layer.cornerRadius = 10
//            return icon
//        }()
    
    private let myView: UIImageView = {
        let cardView = UIImageView()
        cardView.contentMode = .scaleAspectFill
        cardView.backgroundColor = .systemOrange
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 10, height: 10)
        cardView.layer.shadowRadius = 10
        return cardView
    }()

    private let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("JOIN", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    
    private let groupName: UILabel = {
        let name = UILabel()
        name.text = "Group 1"
//            name.backgroundColor = .green
        name.font = UIFont.boldSystemFont(ofSize: 25)
        name.textAlignment = .left
        return name
    }()
    
    private let groupMembers: UILabel = {
        let members = UILabel()
        members.text = ""
//            members.backgroundColor = .green
        members.font = UIFont.boldSystemFont(ofSize: 10)
        members.textAlignment = .left
        return members
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(myView)
//            myView.addSubview(myIcon)
        myView.addSubview(groupName)
        myView.addSubview(groupMembers)
        myView.addSubview(joinButton)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        groupName.frame = CGRect(x: 10, y: 25, width: 200, height: 50)
        groupMembers.frame = CGRect(x: 10, y: 45, width: 100, height: 50)
        joinButton.frame = CGRect(x: 290, y: 35, width: 60, height: 40)
//            myIcon.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        myView.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-20, height: contentView.frame.size.height)
    }
    
//        public func configure(image: UIImage, label: String, date: String){
//            myIcon.image = image
//            groupName.text = label
//            groupMembers.text = date
//        }
    
    public func configure(label: String, members: String){
        groupName.text = label
        groupMembers.text = members
    }
}
