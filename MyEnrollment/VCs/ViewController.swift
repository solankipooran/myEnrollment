//
//  ViewController.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var selectedSegmentLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var userSegemntSelectView: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var controllerContainerView: UIView!
    
    var userViewController: UsersViewController?
    var enrollUserViewControlller: EnrollUserViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Demo Application"
        myScrollView.delegate = self
        setUserViewController()
        setEnrollUserViewController()
    }
    
    @IBAction func segmentController(_ sender: Any) {
        var leadingConstant: CGFloat = 0
        switch segmentController.selectedSegmentIndex  {
        case 0:
            myScrollView.contentOffset.x = 0
            leadingConstant = 0
        case 1:
            myScrollView.contentOffset.x = myScrollView.frame.size.width
            let viewWidth = UIScreen.main.bounds.size.width
            leadingConstant = viewWidth / 2
        default:
            print("Error at Segment")
        }
        selectedSegmentLeadingConstraint.constant = leadingConstant
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setUserViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let userVC = storyBoard.instantiateViewController(withIdentifier: "UsersViewController")
        addChild(userVC)
        controllerContainerView.addSubview(userVC.view)
        userVC.view.translatesAutoresizingMaskIntoConstraints = false
        userVC.view.leadingAnchor.constraint(equalTo: controllerContainerView.leadingAnchor).isActive = true
        userVC.view.topAnchor.constraint(equalTo: controllerContainerView.topAnchor).isActive = true
        userVC.view.bottomAnchor.constraint(equalTo: controllerContainerView.bottomAnchor).isActive = true
        userVC.didMove(toParent: self)
        userViewController = userVC as? UsersViewController
    }
    
    func setEnrollUserViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let enrollVC = storyBoard.instantiateViewController(withIdentifier: "EnrollUserViewController")
        guard let userVc = userViewController else {
            return
        }
        addChild(enrollVC)
        controllerContainerView.addSubview(enrollVC.view)
        enrollVC.view.translatesAutoresizingMaskIntoConstraints = false
        enrollVC.view.leadingAnchor.constraint(equalTo:userVc.view.trailingAnchor).isActive = true
        enrollVC.view.widthAnchor.constraint(equalTo: userVc.view.widthAnchor).isActive = true
        enrollVC.view.trailingAnchor.constraint(equalTo: controllerContainerView.trailingAnchor).isActive = true
        enrollVC.view.topAnchor.constraint(equalTo: controllerContainerView.topAnchor).isActive = true
        enrollVC.view.bottomAnchor.constraint(equalTo: controllerContainerView.bottomAnchor).isActive = true
        enrollVC.didMove(toParent: self)
        enrollUserViewControlller = enrollVC as? EnrollUserViewController
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var leadConstant: CGFloat = 0
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        segmentController.selectedSegmentIndex = Int(pageNumber)
        
        let viewWidth = UIScreen.main.bounds.size.width
        Int(pageNumber) == 0 ? (leadConstant = 0) : (leadConstant = viewWidth / 2)
        selectedSegmentLeadingConstraint.constant = leadConstant
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

