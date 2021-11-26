//
//  LeaderboardViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-25.
//

import UIKit

class LeaderboardViewController: UIViewController{
    
    @IBOutlet weak var leaderboardTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTableView.dataSource = self
        leaderboardTableView.delegate = self
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
        let cell = leaderboardTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath)
        cell.textLabel?.text = FirebaseAccessLayer.GetCurrentUserId()
        return cell
    }
}
