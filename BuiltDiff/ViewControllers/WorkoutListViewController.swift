import UIKit

class WorkoutListViewController: UIViewController {
    var Ape: Workout?
    
    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.init{
            Ape = try await Workout.LoadUserWorkout(workoutId: "JJTQ51ifA24OEH7mwYlG")
            print(Ape?.Name)
            print("Name = \(Ape?.WorkoutTasks[0].Name as! String)  Sets = \(Ape?.WorkoutTasks[0].Sets as! Int)")
        }
    }


}
