//
//  CustomCollectionViewCell.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-09.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "exercise1")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
//        label.backgroundColor = .green
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
//        contentView.backgroundColor = .red
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        myImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
    }
    
    public func configure(label: String){
        myLabel.text = label
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
}
