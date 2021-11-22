//
//  CreateWorkoutViewController.swift
//  BuiltDiff
//
//  Created by Christopher Reynolds on 2021-11-05.
//
import UIKit

class CreateWorkoutViewController: UIViewController {

    @IBOutlet var TitleText: UITextField!
    @IBOutlet var DescText: UITextField!
    @IBOutlet var SetText: UITextField!
    @IBOutlet var RepText: UITextField!
    @IBOutlet var WorkoutName: UITextField!
    var taskDisplay = [[]]
    var taskArray: [WorkoutTask] = []

    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func unwindToExerciseHome(_ sender: Any) {
        Workout(name: WorkoutName.text!, workoutTasks:  taskArray, saveToDatabase: true)
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }

    @IBAction func CreateTask(_ sender: Any) {
        taskArray.append(WorkoutTask(name: TitleText.text!, reps: Int(RepText.text!)!, sets: Int(SetText.text!)!, description: DescText.text!))
        taskDisplay.append([TitleText.text,DescText.text,SetText.text,RepText.text])
        TitleText.text = ""
        DescText.text = ""
        SetText.text = ""
        RepText.text = ""
        tableView.reloadData()
    }
}

extension CreateWorkoutViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Row Tapped")
    }
}

extension CreateWorkoutViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskDisplay.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        if taskDisplay.count > 1 {
            let name = taskDisplay[indexPath.row+1][0] as! String
            let sets = taskDisplay[indexPath.row+1][2] as! String
            let reps = taskDisplay[indexPath.row+1][3] as! String
            cell.textLabel?.text = "\(name)  Sets: \(sets)  Reps: \(reps)"
        }
        return cell
    }
}
