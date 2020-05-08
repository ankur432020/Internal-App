//
//  TestViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 21/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var usernameView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameView.layer.borderWidth = 1.5
        usernameView.layer.borderColor = UIColor.black.cgColor
    }
    

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
