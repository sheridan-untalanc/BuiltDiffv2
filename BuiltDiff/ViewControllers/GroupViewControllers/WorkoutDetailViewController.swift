//
//  WorkoutDetailViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-11-23.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var numOfTasksLabel: UILabel!
    
//    var groupDetailsViewController = GroupDetailsViewController()
    var workout : Workout?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.layer.cornerRadius = 20
        workoutNameLabel.text = workout?.Name
        numOfTasksLabel.text = "# of Tasks: \(workout?.WorkoutTasks.count ?? 0)"
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }

}


extension WorkoutDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Row Tapped")
    }
}

extension WorkoutDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (workout?.WorkoutTasks.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        if (workout?.WorkoutTasks.count)! >= 1 {
            let name = workout?.WorkoutTasks[indexPath.row].Name ?? ""
            let sets = workout?.WorkoutTasks[indexPath.row].Sets ?? 0
            let reps = workout?.WorkoutTasks[indexPath.row].Reps ?? 0
            cell.textLabel?.text = "\(name)  Sets: \(sets)  Reps: \(reps)"
        }
        return cell
    }
}
