//
//  ExerciseViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit
import HealthKitUI
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()
var count = 0
var workouts = [[String]]()

class ExerciseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = "Anything Else"
        count = 0
        
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width),
                                 height: (150))
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private var collectionView: UICollectionView?
    var counts: Int = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        collectionView.backgroundColor = .systemBackground
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                                ascending: true)
        
        let query = HKSampleQuery(
          sampleType: .workoutType(),
          predicate: nil,
          limit: 10,
          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            DispatchQueue.main.async {
              guard
                let samples = samples as? [HKWorkout],
                error == nil
                else {
                  return
              }
                let calories = Double((samples[count].totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie())))

                var exerciseType = ""
                var imageType = ""
                switch samples[count].workoutActivityType.rawValue{
                case 46:
                    exerciseType = "Swimming"
                    imageType = "swimmingIcon"
                case 13:
                    exerciseType = "Cycling"
                    imageType = "bikingIcon"
                case 52:
                    exerciseType = "Walking"
                    imageType = "walkingIcon"
                default:
                    exerciseType = "Generic Workout"
                    imageType = "runningIcon"
                }

                func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
                    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
                }
                let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(samples[count].duration))
                    
                let date = samples[count].startDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/YY"
                let formattedDate = dateFormatter.string(from: date)
                    
                let workout = [exerciseType, "\(h)h \(m)m \(s)s", "\(String(calories.rounded(.awayFromZero))) Cal", formattedDate, imageType]
                workouts.append(workout)
                cell.configure(image: UIImage(named: workouts[count][4])!,label: workouts[count][0], date: workouts[count][3],duration: workouts[count][1], calories: workouts[count][2])
                count = count + 1
                
                
            }
              
          }
        HKHealthStore().execute(query)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}



//self.performSegue(withIdentifier: "inspectWorkout", sender: self)
//import UIKit
//import HealthKitUI
//import HealthKit
//
//let healthKitStore:HKHealthStore = HKHealthStore()
//var count = 0
//var workouts = [[String]]()
//
//class ExerciseViewController: UIViewController{
//    
//    @IBOutlet var collectionView: UICollectionView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        collectionView.dataSource = self
//        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//    }
//    var counts: Int = 0
//}
//
//extension ExerciseViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5;
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        collectionView.backgroundColor = .systemBackground
//        
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
//                                                ascending: true)
//        
//        let query = HKSampleQuery(
//          sampleType: .workoutType(),
//          predicate: nil,
//          limit: 10,
//          sortDescriptors: [sortDescriptor]) { (query, samples, error) in
//            DispatchQueue.main.async {
//              guard
//                let samples = samples as? [HKWorkout],
//                error == nil
//                else {
//                  return
//              }
//                let calories = Double((samples[count].totalEnergyBurned!.doubleValue(for: HKUnit.largeCalorie())))
//
//                var exerciseType = ""
//                var imageType = ""
//                switch samples[count].workoutActivityType.rawValue{
//                case 46:
//                    exerciseType = "Swimming"
//                    imageType = "swimmingIcon"
//                case 13:
//                    exerciseType = "Cycling"
//                    imageType = "bikingIcon"
//                case 52:
//                    exerciseType = "Walking"
//                    imageType = "walkingIcon"
//                default:
//                    exerciseType = "Generic Workout"
//                    imageType = "runningIcon"
//                }
//
//                func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
//                    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
//                }
//                let (h,m,s) = secondsToHoursMinutesSeconds(seconds: Int(samples[count].duration))
//                    
//                let date = samples[count].startDate
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "dd/MM/YY"
//                let formattedDate = dateFormatter.string(from: date)
//                    
//                let workout = [exerciseType, "\(h)h \(m)m \(s)s", "\(String(calories.rounded(.awayFromZero))) Cal", formattedDate, imageType]
//                workouts.append(workout)
//                cell.configure(image: UIImage(named: workouts[count][4])!,label: workouts[count][0], date: workouts[count][3],duration: workouts[count][1], calories: workouts[count][2])
//                count = count + 1
//                
//                
//            }
//              
//          }
//        HKHealthStore().execute(query)
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("User tapped on item \(indexPath.row)")
//    }
//}
