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
    var taskArray = [[]]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }

    @IBAction func CreateTask(_ sender: Any) {
        taskArray.append([TitleText.text,DescText.text,SetText.text,RepText.text])
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
        return taskArray.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        if taskArray.count > 1 {
            var name = taskArray[indexPath.row+1][0]
            var sets = taskArray[indexPath.row+1][2]
            var reps = taskArray[indexPath.row+1][3]
            cell.textLabel?.text = "\(name)  Sets:\(sets) Reps:\(reps)"
        }
        return cell
    }
}
