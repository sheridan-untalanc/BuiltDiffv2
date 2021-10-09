//
//  ExerciseViewController.swift
//  BuiltDiff
//
//  Created by Azmeer Hussain on 2021-10-02.
//

import UIKit

class ExerciseViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let testingLabel = UILabel(frame: CGRect(x: 20, y: 15, width: 252, height: 30))
        testingLabel.text = "Exercise"
        testingLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
//        testingLabel.font = UIFont(name: "System-Bold", size: 25)
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height - 100))
        view.addSubview(scrollView)
        let topButton = UIButton(frame: CGRect(x: 330, y: 25, width: 20, height: 20))
        topButton.backgroundColor = .blue
        scrollView.addSubview(topButton)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2200)
        
//        let imageName = "exercise2"
//        let testImage = UIImage(named: "exercise2")
//        let imageView = UIImageView(image: testImage!)
//        imageView.frame = CGRect(x: 20, y: 20, width: 300, height: 150)
//        scrollView.addSubview(imageView)
        
//        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 30))
//        label.font = UIFont.preferredFont(forTextStyle: .footnote)
//        label.textAlignment = .left
//        label.text = "Test Label"
//        scrollView.addSubview(label)
        
        scrollView.addSubview(testingLabel)
        
    }

}
