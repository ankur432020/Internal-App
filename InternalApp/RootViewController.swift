//
//  RootViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 10/04/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        print("LOGIN STATUS ===  \(UserDefaults.standard.string(forKey: "isLOGIN") ?? "")")
        if UserDefaults.standard.string(forKey: "isLOGIN") == "YES" {
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
            //dashboardVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: true, completion: nil)
        }
        else
        {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            //            DispatchQueue.main.async {
            //                // loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
        
    }
    

}
