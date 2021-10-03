//
//  HomeViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageExercise1: UIImageView!
    @IBOutlet weak var imageExercise2: UIImageView!
    @IBOutlet weak var imageExercise3: UIImageView!
    @IBOutlet weak var imageExercise4: UIImageView!
    @IBOutlet weak var imageExercise5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageExercise1.layer.cornerRadius = 10
        imageExercise2.layer.cornerRadius = 10
        imageExercise3.layer.cornerRadius = 10
        imageExercise4.layer.cornerRadius = 10
        imageExercise5.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        
        let exercise1Tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.exercise1Tapped(gesture:)))
        imageExercise1.addGestureRecognizer(exercise1Tap)
        imageExercise1.isUserInteractionEnabled = true
        
        let exercise2Tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.exercise2Tapped(gesture:)))
        imageExercise2.addGestureRecognizer(exercise2Tap)
        imageExercise2.isUserInteractionEnabled = true
        
        let exercise3Tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.exercise3Tapped(gesture:)))
        imageExercise3.addGestureRecognizer(exercise3Tap)
        imageExercise3.isUserInteractionEnabled = true
        
        let yogaTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.yogaTapped(gesture:)))
        imageExercise4.addGestureRecognizer(yogaTap)
        imageExercise4.isUserInteractionEnabled = true
        
        let dietTap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dietTapped(gesture:)))
        imageExercise5.addGestureRecognizer(dietTap)
        imageExercise5.isUserInteractionEnabled = true
        
        
    }
    
    @objc func yogaTapped(gesture: UIGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
            guard let url = URL(string: "https://www.yogabasics.com/practice/yoga-for-beginners") else { return }
            UIApplication.shared.openURL(url)
            }
        }
    
    @objc func dietTapped(gesture: UIGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
            guard let url = URL(string: "https://www.eatingwell.com/article/7882092/clean-eating-meal-plan-for-beginners/") else { return }
            UIApplication.shared.openURL(url)
            }
        }
    
    @objc func exercise1Tapped(gesture: UIGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let secondVC = storyboard.instantiateViewController(withIdentifier: "testmodal")
//
//            show(secondVC, sender: self)
            }
        }
    
    @objc func exercise2Tapped(gesture: UIGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
                
            }
        }
    
    @objc func exercise3Tapped(gesture: UIGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
                
            }
        }
    
//        lazy var openButton:UIButton = {
//            let button = UIImageView(frame: CGRect(x: 0, y: self.view.frame.height - 90, width: self.view.frame.width, height: 70))
//        }
//
//        func profileImageView() -> UIImageView {
//                let imageView = UIImageView()
//                imageView.image = UIImage(named: "exercise1")
//                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.contentMode = .scaleAspectFill
//
//            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:self.profileImageClicked()))
//                imageView.isUserInteractionEnabled = true
//                return imageView
//        }
//
//        @objc func profileImageClicked(){
//            let vc = SecondViewController()
//        }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
