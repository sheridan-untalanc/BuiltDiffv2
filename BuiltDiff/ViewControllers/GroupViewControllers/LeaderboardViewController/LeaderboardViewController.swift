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
    var listOfUsers: [(userId: String, points: Int)] = []
    var groupIdNumber: Group? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init{
            leaderboardTableView.dataSource = self
            leaderboardTableView.delegate = self
            listOfUsers = try await FirebaseAccessLayer.GetUsersFromGroup(groupId: groupIdNumber!.GroupId)
            for i in 0...listOfUsers.count-1{
                let userId = listOfUsers[i].userId
                listOfUsers[i].userId = try await FirebaseAccessLayer.GetUsername(userId: userId)
            }
            listOfUsers = listOfUsers.sorted(by: {$0.points > $1.points })
            leaderboardTableView.reloadData()
        }
    }
}

extension LeaderboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            cell.configure(picture: UIImage(named: "goldMedal")!, name: listOfUsers[indexPath.row].userId, points: listOfUsers[indexPath.row].points)
        }
        else if indexPath.row == 1 {
            cell.configure(picture: UIImage(named: "silverMedal")!, name: listOfUsers[indexPath.row].userId, points: listOfUsers[indexPath.row].points)
        }
        else if indexPath.row == 2 {
            cell.configure(picture: UIImage(named: "bronzeMedal")!, name: listOfUsers[indexPath.row].userId, points: listOfUsers[indexPath.row].points)
        }
        else{
            cell.configure(picture: UIImage(), name: listOfUsers[indexPath.row].userId, points: listOfUsers[indexPath.row].points )
        }
        return cell
    }
}
