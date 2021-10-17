//
//  SecondGroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-12.
//

import UIKit

class SecondGroupViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var digitCodeLabel: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    var groupNameArray: [String] = [
            "Sheridan Club",
            "Milton Team",
            "McMaster Squad",
            "Band of Brothers",
            "Raging Bull"]
    
    var groupMemberArray: [String] = ["5","10","25","3","6"]
    
    var groupDateArray: [String] = [
            "01/10/2021",
            "02/10/2021",
            "03/10/2021",
            "04/10/2021",
            "05/10/2021"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
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

extension SecondGroupViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JoinGroupCollectionViewCell", for: indexPath) as! JoinGroupCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.configure(name: groupNameArray[indexPath.row], members: "\(groupMemberArray[indexPath.row]) members", date: groupDateArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("works")
    }
}

extension SecondGroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 110)
    }
}
