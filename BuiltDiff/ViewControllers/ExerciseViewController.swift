//
//  ExerciseViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class ExerciseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width),
                                 height: (view.frame.size.height/3.5))
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.contentView.backgroundColor = .blue
        cell.configure(label: "Exercise \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
        
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height - 100))
//        view.addSubview(scrollView)
        
//        let topButton = UIButton(frame: CGRect(x: 335, y: 15, width: 30, height: 30))
//        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2200)
//        let icon = UIImage(named: "plusbuttonicon")!
//        topButton.setImage(icon, for: .normal)
//        topButton.imageView?.contentMode = .scaleAspectFit
//        scrollView.addSubview(topButton)
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 350, height: 150)
//        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//        myCollectionView?.backgroundColor = UIColor.green
//        myCollectionView?.dataSource = self
//        myCollectionView?.delegate = self
//        view.addSubview(myCollectionView ?? UICollectionView())
//        self.view = view
}

//extension ExerciseViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10 // How many cells to display
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let myImageView: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImageView(image: "")
//            return imageView
//        }
//
//        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
//        myCell.backgroundColor = UIColor.red
//        myCell.contentView.layer.cornerRadius = 25
//        myCell.contentView.layer.borderWidth = 1.0
//        myCell.contentView.layer.borderColor = UIColor.clear.cgColor
//        myCell.contentView.layer.masksToBounds = true
//        myCell.layer.shadowColor = UIColor.black.cgColor
//        myCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        myCell.layer.shadowRadius = 2.0
//        myCell.layer.shadowOpacity = 0.5
//        myCell.layer.masksToBounds = false
//        myCell.layer.shadowPath = UIBezierPath(roundedRect: myCell.bounds, cornerRadius: myCell.contentView.layer.cornerRadius).cgPath
//
//        return myCell
//    }
//}
//
//extension ExerciseViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       print("User tapped on item \(indexPath.row)")
//    }
//}
        
