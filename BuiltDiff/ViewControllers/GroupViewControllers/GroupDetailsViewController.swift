//
//  GroupDetailsViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-12.
//

import UIKit

class GroupDetailsViewController: UIViewController {
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var groupBackButton: UIButton!
    @IBOutlet weak var groupExerciseCollectionView: UICollectionView!
    
    var group: Group? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        groupTitle.text = group?.GroupName
        groupDescriptionLabel.text = group?.GroupDescription
        groupImage.layer.cornerRadius = 75
        groupImage.layer.masksToBounds = true
        groupBackButton.layer.cornerRadius = 20
        groupExerciseCollectionView.delegate = self
        groupExerciseCollectionView.dataSource = self
        groupExerciseCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        Task.init{
            FirebaseAccessLayer.GetGroupImage(ownerUid: group!.GroupOwner, completion: { image in
                DispatchQueue.main.async{
                    self.groupImage.image = image
                }
            })
        }
    }
    
    @IBAction func unwindToMyGroups(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMyGroups", sender: self)
        }

}

extension GroupDetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var testArray = [0,1,0,1,0]
        if testArray[indexPath.row] == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupDetailsCollectionViewCell", for: indexPath) as! GroupDetailsCollectionViewCell
            cell.layer.cornerRadius = 10
            return cell
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateExerciseCollectionViewCell", for: indexPath) as! CreateExerciseCollectionViewCell
            cell2.layer.cornerRadius = 10
            return cell2
        }
        
//        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("works")
    }
}

extension GroupDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
