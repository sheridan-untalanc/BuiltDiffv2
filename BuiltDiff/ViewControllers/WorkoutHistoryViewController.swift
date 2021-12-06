//
//  WorkoutHistoryViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-12-01.
//

import UIKit

class WorkoutHistoryViewController: UIViewController {

    @IBOutlet weak var workoutTableView: UITableView!
    var myWorkouts: [(workoutId: String, workoutName: String, dateCompleted: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            myWorkouts = try await FirebaseAccessLayer.GetAllUserCompletedWorkouts()
            workoutTableView.dataSource = self
            workoutTableView.delegate = self
        }

    }
    @IBAction func backToAExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }

}


extension WorkoutHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutHistoryTableViewCell") as! WorkoutHistoryTableViewCell
        cell.configure(name: "test", date: "test", image: UIImage(named: "bikingIcon")!)
        return cell
    }
    
}
