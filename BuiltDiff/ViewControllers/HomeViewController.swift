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
    
//    lazy var openButton:UIButton = {
//        let button = UIImageView(frame: CGRect(x: 0, y: self.view.frame.height - 90, width: self.view.frame.width, height: 70))
//    }
//
//    func profileImageView() -> UIImageView {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "exercise1")
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.contentMode = .scaleAspectFill
//
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:self.profileImageClicked()))
//            imageView.isUserInteractionEnabled = true
//            return imageView
//    }
//
//    @objc func profileImageClicked(){
//        let vc = SecondViewController()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageExercise1.layer.cornerRadius = 10
        imageExercise2.layer.cornerRadius = 10
        imageExercise3.layer.cornerRadius = 10
        imageExercise4.layer.cornerRadius = 10
        imageExercise5.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
