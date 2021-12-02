//
//  CreateGroupChallengeViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-12-01.
//

import UIKit

class CreateGroupChallengeViewController: UIViewController {
    @IBOutlet weak var typeOfExerciseLabel: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var metricSegmentedControl: UISegmentedControl!
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var pointsLabel: UITextField!
    @IBOutlet weak var createChallengeButton: UIButton!
    
    var group : Group? = nil
    var challenge : Challenge? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
//        switch metricSegmentedControl.selectedSegmentIndex {
//            case 0:
//
//            case 1:
//
//            case 2:
//
//            default:
//                break;
//            }
    }
    
    @IBAction func createChallenge(_ sender: Any) {
        dateChanged(deadlineDatePicker)
        
        if typeOfExerciseLabel.text == "" || goalLabel.text == "" || pointsLabel.text == ""{
            let alert = UIAlertController(title: "Error", message: "One or more fields in empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let points : Int =  Int(pointsLabel.text!)!
            FirebaseAccessLayer.PushChallenge(groupId: group!.GroupId, challenge: Challenge(startDate: "Today", endDate: "Tomorrow", exerciseType: typeOfExerciseLabel.text!, goal: goalLabel.text!, metric: metricSegmentedControl.titleForSegment(at: metricSegmentedControl.selectedSegmentIndex)! , points: points))
            self.dismiss(animated: true, completion: nil)
        }
    }

}
