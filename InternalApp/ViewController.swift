//
//  ViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 04/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textF_username: UITextField!
    
    @IBOutlet weak var textF_password: UITextField!
    
    @IBOutlet weak var view_userName: UIView!
    @IBOutlet weak var view_password: UIView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view_userName.layer.borderColor = UIColor.black.cgColor
        view_userName.layer.borderWidth = 1.5
        view_password.layer.borderColor = UIColor.black.cgColor
        view_password.layer.borderWidth = 1.5
        
       // getAccessToken_Method(withUsername: textF_username.text!, withPassword: textF_password.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func btnAction_Login(_ sender: Any) {
    
        
      if textF_username.text!.isEmpty {
            self.view.makeToast("Please enter Email/Username.")
        }
        else if textF_password.text!.isEmpty {
            self.view.makeToast("Please enter Password.")
        }
      else if textF_password.text!.count < 6{
        self.view.makeToast("Password should be equal & greater than 6 character.")
      }
        else{
            print("All Ok")
            getAccessToken_Method(withUsername: textF_username.text!, withPassword: textF_password.text!)
        }
       // goToHome()
        
    }
    
    @IBAction func btnAction_SignUp(_ sender: Any) {
       // let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
       // self.present(homeVC, animated: true, completion: nil)
    }
    func getAccessToken_Method(withUsername: String, withPassword: String) {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_GET_ACCESS_TOKEN
        let password = withPassword//41388482
       // let db = "apidev"
        let login = withUsername //"admin@eotor.net"//
        
        print(url)
        let manager = AFHTTPSessionManager()
       // manager.requestSerializer.setValue(login, forHTTPHeaderField: "login")
        // manager.requestSerializer.setValue(db, forHTTPHeaderField: "db")
        // manager.requestSerializer.setValue(password, forHTTPHeaderField: "password")
        let parametes = ["user": login, "pass": password]
        
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
           
            if let dic = responseObject as?  [String: Any]{
                print(dic)

                
                if let code = dic["code"] as? Int {
                    if code == 400
                    {
                        appDelegate.hideHUD()
                        self.view.makeToast("\(dic["msg"] ?? "Failed to Authorized.")")
                    }
                }

                let defValue = UserDefaults.standard
               
                if let token = dic["access_token"] {
                    print(token)
                     defValue.set(token, forKey: "access_token")
                    defValue.set("YES", forKey: "isLOGIN")
                    defValue.synchronize()
                    appDelegate.hideHUD()
                    
                    self.view.makeToast("Login Successfull!")
                    self.goToHome()
                }
               
               
                //defValue.set(dic["partner_id"], forKey: "user_ID")
                
            }
        }, failure: {
            (operation, error) in
        appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
    func goToHome()  {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        self.present(homeVC, animated: true, completion: nil)
    }
}

