//import UIKit
//
//class WorkoutListViewController: UIViewController {
//
//    @IBAction func unwindToExerciseHome(_ sender: Any) {
//        performSegue(withIdentifier: "unwindToExerciseHome", sender: self)
//    }
//
//    @IBOutlet var workoutCollectionView: UICollectionView!
//
//    var myWorkouts: [Workout] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Task.init{
//            myWorkouts = try await Workout.LoadAllUsersWorkouts()
//            workoutCollectionView.dataSource = self
//            workoutCollectionView.delegate = self
//            workoutCollectionView.collectionViewLayout = UICollectionViewLayout()
//            workoutCollectionView.reloadData()
//        }
//    }
//
//}
//
//extension WorkoutListViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return myWorkouts.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutSessionCollectionViewCell", for: indexPath) as! WorkoutSessionCollectionViewCell
//        cell.layer.cornerRadius = 10
//
//        cell.configure(name: myWorkouts[indexPath.row].Name, numberOfTasks: "Contains \(myWorkouts[indexPath.row].WorkoutTasks.count) Tasks")
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print ("Ape")
//    }
//
//}
//
//extension WorkoutListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 244, height: 95)
//    }
//}
