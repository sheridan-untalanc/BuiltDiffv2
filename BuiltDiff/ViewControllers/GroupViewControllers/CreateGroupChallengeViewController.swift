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
    var onDoneBlock : ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

    }
    
    func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
        }
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            FirebaseAccessLayer.PushChallenge(groupId: group!.GroupId, challenge: Challenge(startDate: dateFormatter.string(from: Date.now), endDate: dateFormatter.string(from: deadlineDatePicker.date), exerciseType: typeOfExerciseLabel.text!, goal: goalLabel.text!, metric: metricSegmentedControl.titleForSegment(at: metricSegmentedControl.selectedSegmentIndex)! , points: points))
            performSegue(withIdentifier: "unwindToGroupDetails", sender: self)
        }
    }

}
