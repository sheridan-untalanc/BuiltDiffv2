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

    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init{
            username = try await FirebaseAccessLayer.GetUsername(userId: FirebaseAccessLayer.GetCurrentUserId())
            leaderboardTableView.dataSource = self
            leaderboardTableView.delegate = self
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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderboardTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardTableViewCell
        cell.textLabel?.text = username
        if indexPath.row == 0 {
            cell.configure(picture: UIImage(named: "goldMedal")!)
        }
        if indexPath.row == 1 {
            cell.configure(picture: UIImage(named: "silverMedal")!)
        }
        if indexPath.row == 2 {
            cell.configure(picture: UIImage(named: "bronzeMedal")!)
        }
        return cell
    }
}
