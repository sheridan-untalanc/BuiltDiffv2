//
//  FourthGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-16.
//

import UIKit

class ListGroupsViewController: UIViewController {
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var groupBackButton: UIButton!
    
    var groups: [Group] = []
    
    var groupMemberArray: [String] = ["5","10","25","3","6","5","10","25","3","6"]
    
    var groupDateArray: [String] = [
            "01/10/2021",
            "02/10/2021",
            "03/10/2021",
            "04/10/2021",
            "05/10/2021",
            "01/10/2021",
            "02/10/2021",
            "03/10/2021",
            "04/10/2021",
            "05/10/2021"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task.init{
            let groupIdList = groupBuilder!.GroupList
            groups = try await Group.LoadAll(groupIds: groupIdList)
            groupsCollectionView.dataSource = self
            groupsCollectionView.delegate = self
            groupsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            groupsCollectionView.reloadData()
            groupBackButton.layer.cornerRadius = 20
//            FirebaseAccessLayer.GetGroupImage(ownerUid: group!.GroupOwner, completion: { image in
//                DispatchQueue.main.async{
//                    self.groupImage.image = image
//                }
//            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func unwindToGroupHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGroupHome", sender: self)
        }
    
    @IBAction func unwindToMyGroups( _ seg: UIStoryboardSegue){
            
        }
}

extension ListGroupsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupBuilder!.GroupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListGroupsCollectionViewCell", for: indexPath) as! ListGroupsCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "groupDetails") as? GroupDetailsViewController
        vc?.group = groups[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
//        performSegue(withIdentifier: "groupDetailSegue", sender: self)
    }
}

extension ListGroupsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
