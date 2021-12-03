//
//  LeaderboardViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-25.
//

import UIKit

class LeaderboardViewController: UIViewController{
    
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    var username: String = ""
    var listOfUsers: [String: [String:Int]] = [:]
    var groupIdNumber = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init{
            leaderboardTableView.dataSource = self
            leaderboardTableView.delegate = self
            listOfUsers = try await FirebaseAccessLayer.GetUsersFromGroup(groupId: groupIdNumber)
            listOfUsers.sorted
        }
    }
}

extension LeaderboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

extension LeaderboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderboardTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardTableViewCell
        cell.textLabel?.text = username
        if indexPath.row == 0 {
            cell.configure(picture: UIImage(named: "goldMedal")!)
        }
        else if indexPath.row == 1 {
            cell.configure(picture: UIImage(named: "silverMedal")!)
        }
        else if indexPath.row == 2 {
            cell.configure(picture: UIImage(named: "bronzeMedal")!)
        }
        else{
            cell.configure(picture: <#T##UIImage#>, name: <#T##String#>, points: listOfUsers[indexPath.row].)
        }
        return cell
    }
}
