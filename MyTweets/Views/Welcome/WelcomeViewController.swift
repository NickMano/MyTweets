//
//  WelcomeViewController.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 08/06/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBAction func LoginButtonPressed(_ sender: Any) {
        coordinator?.login()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.setWelcomeNavSyle()
    }
}

