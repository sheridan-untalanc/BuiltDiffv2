//
//  SecondGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-12.
//

import UIKit

class JoinGroupViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var digitCodeLabel: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
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
    
//    var groupNameArray: [String] = [
//            "Sheridan Club",
//            "Milton Team",
//            "McMaster Squad",
//            "Band of Brothers",
//            "Raging Bull"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task.init{
            let values = groupBuilder!.GroupList.values
            var groupIdList: [String] = []
            for value in values{
                groupIdList.append(value)
            }
            groups = try await Group.LoadAll(groupIds: groupIdList)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = UICollectionViewFlowLayout()
            collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        if digitCodeLabel.text == "" {
            let alert = UIAlertController(title: "Error!", message: "Please enter a valid 6 digit code", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else{
            print("join button tapped")
        }
    }
    
}

extension JoinGroupViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupBuilder!.GroupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JoinGroupCollectionViewCell", for: indexPath) as! JoinGroupCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.configure(name: groups[indexPath.row].GroupName, description: groups[indexPath.row].GroupDescription)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("works")
    }
}

extension JoinGroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
