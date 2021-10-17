//
//  GroupViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class GroupViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var groupImage1: UIView!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if profile!.GroupList.count != 0{
//            groupImage1.isHidden = true
////            inviteButton.isHidden = true
//            inviteButton.backgroundColor = .systemOrange
//            inviteButton.setTitleColor(.white, for: .normal)
//            firstLabel.isHidden = true
//            secondLabel.isHidden = true
//            backgroundImage.isHidden = true
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            
        }
        else{
//            tableView.isHidden = true
        }
    }
    
    @IBAction func didTapButton(){
        let alertController = UIAlertController(title: "", message: "What would you like to do?", preferredStyle: .actionSheet)
            
            let createButton = UIAlertAction(title: "Create Group", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "createGroupSegue", sender: self)
                
            })
            
            let  joinButton = UIAlertAction(title: "Join a Group", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "joinGroupSegue", sender: self)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
    
            alertController.addAction(createButton)
            alertController.addAction(joinButton)
            alertController.addAction(cancelButton)
            
            self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}

extension GroupViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("user tapped")
    }
}

extension GroupViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile!.GroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        for groupId in profile!.GroupList{
            cell.textLabel?.text = groupId.value
        }
        return cell
    }
}
