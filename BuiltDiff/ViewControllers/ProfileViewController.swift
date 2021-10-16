//
//  ProfileMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var changePicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let checkerInstance = AchievementChecker()
        
        print(checkerInstance.MarathonRunner())
        changePicture.layer.cornerRadius = 50.0;
        changePicture.layer.masksToBounds = true;

        // Do any additional setup after loading the view.
//        changePicture.layer.masksToBounds = true
//        changePicture.layer.cornerRadius = changePicture.frame.height / 2
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    @IBAction func didTapImage(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            changePicture.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementsCollectionViewCell", for: indexPath) as! AchievementsCollectionViewCell
        
        let completedStar = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        let emptyStar = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            
        completedStar?.withTintColor(.systemOrange)
        
        
        
        cell.configure(trophy: UIImage(named: "achievements-icon")!, star1: completedStar!, star2: completedStar!, star3: emptyStar!, title: "Marathon Runner")
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 190)
    }
}
