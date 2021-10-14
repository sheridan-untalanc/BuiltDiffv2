//
//  SecondGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-12.
//

import UIKit

class SecondGroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                layout.itemSize = CGSize(width: (view.frame.size.width),
                                         height: (view.frame.size.height/8))
                
                collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                guard let collectionView = collectionView else {
                    return
                }
                collectionView.register(GroupCustomCollectionViewCell.self, forCellWithReuseIdentifier: GroupCustomCollectionViewCell.identifier)
                collectionView.dataSource = self
                collectionView.delegate = self
                view.addSubview(collectionView)
                collectionView.frame = view.bounds
            }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCustomCollectionViewCell.identifier, for: indexPath) as! GroupCustomCollectionViewCell
                
        var groupNameArray: [String] = [
                "Deadlift Squad",
                "Running Club",
                "Swim Team",
                "Bike Crew",
                "Soccer FC"]
                
        var groupMembersArray: [String] = [
                "5 members",
                "1 member",
                "10 members",
                "2 members",
                "15 members"]
        
        cell.configure(label: groupNameArray[indexPath.row], members:groupMembersArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
