//
//  GroupsMainViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-03-27.
//

import UIKit


let names = [
    "Soccer Team",
    "Gym Group",
    "Running Club"
]
let images = [
    "SoccerTeam",
    "GymGroup",
    "RunningGroup"
]

class GroupsMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ("cellGroup"), for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        return cell
    }
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print ("You tapped me")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    

}
