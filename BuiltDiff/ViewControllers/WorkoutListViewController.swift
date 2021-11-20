import UIKit

class WorkoutListViewController: UIViewController {

    @IBAction func unwindToExerciseHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
