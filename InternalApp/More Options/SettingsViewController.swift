//
//  SettingsViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 05/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
import MBProgressHUD
import AFNetworking
class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
    
    @IBOutlet weak var imageView_title: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    var titleString : String!
    var titileImage : UIImage!
    
    var cusmtomPicker: CustomPickerView!
    @IBOutlet weak var setting_TableView: UITableView!
    
     var loadingNotification = MBProgressHUD()
    @IBOutlet weak var settingView: UIView!
    let spacing : CGFloat = 10
    
    var settingOptionsArray = [String]()
    var settingOptionImagesArray = [UIImage]()
 
    
    let picker_language = UIPickerView()
    let toolbar = UIToolbar()
    var arrayOfLanguage = ["English","中文","ئۇيغۇر"]
    @IBOutlet weak var profile_ImageView: UIImageView!
    
    var language_DropDown = DropDown()
    var currentLanguage = "en"
    var wizardID = ""
    
    @IBOutlet weak var lbl_userEmail: UILabel!
    @IBOutlet weak var lbl_username: UILabel!
    var selectedLanguage = "en_US"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lbl_title.text = titleString
        imageView_title.image = titileImage
        
        settingView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        
        
        profile_ImageView.layer.cornerRadius = profile_ImageView.frame.size.width / 2
        
       // profile_ImageView.layer.masksToBounds = false
        
       
        profile_ImageView.dropShadowWithBorder(borderWidth: 6, borderColor: UIColor.white, shadowColor: UIColor.gray, shadowRadius: 8, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        settingOptionsArray = ["Change Language", "Change Password", "Feedback", "Help", "Log Out"]
        settingOptionImagesArray = [UIImage(named: "subject"), UIImage(named: "changePassword"), UIImage(named: "info"),UIImage(named: "feedback"), UIImage(named: "logout")] as! [UIImage]
        
       
        
        setUP_PickerView_UI()
        createToolbar()
        
        language_DropDown.dataSource = arrayOfLanguage
        // language_DropDown.anchorView = settingView
        language_DropDown.cornerRadius = 8
        language_DropDown.textFont = UIFont.systemFont(ofSize: 17)
        language_DropDown.selectionBackgroundColor = UIColor.black
        language_DropDown.selectedTextColor = UIColor.yellow
         let imageString = "\(UserDefaults.standard.object(forKey: "user_IMAGE") ?? "No Image")"
        DispatchQueue.main.async {
           self.profile_ImageView.image = appDelegate.convertBase64StringToImage(imageString: imageString)
            self.lbl_username.text = "\(UserDefaults.standard.object(forKey: "user_NAME") ?? "User name")"
            self.lbl_userEmail.text = "\(UserDefaults.standard.object(forKey: "user_EMAIL") ?? "User Email")"
            
        }
        
        
    }
    
    func setUP_PickerView_UI() {
        cusmtomPicker = CustomPickerView()
        picker_language.delegate = cusmtomPicker
        picker_language.dataSource = cusmtomPicker
        picker_language.delegate?.pickerView?(cusmtomPicker, didSelectRow: 0, inComponent: 0)
        picker_language.backgroundColor = UIColor.yellow
        cusmtomPicker.dataArray = arrayOfLanguage
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    }
    
    func createToolbar()
    {
        
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.yellow
        toolbar.barStyle = .black
        toolbar.backgroundColor = UIColor.black
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ManufactureViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        
    }
    
    @objc func closePickerView()
    {
        view.endEditing(true)
        print(cusmtomPicker.pickedValue!)
        if cusmtomPicker.pickedValue == "中文" {
            currentLanguage = "zh-Hans"
        }
        else if cusmtomPicker.pickedValue == "ئۇيغۇر" {
            currentLanguage = "ug"
        }
        else{
            currentLanguage = "en"
        }
       
        updateLanguage(withCode: currentLanguage)
        
    }
   
    func updateLanguage(withCode: String)  {
        lbl_title.text = LanguageManager.sharedInstance.LocalizedLanguage(key: titleString, languageCode: withCode)
        setting_TableView.reloadData()
        DispatchQueue.main.async() {
            print("SELECTED_LANGUAGE =  > \(self.currentLanguage)")
            //appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
            UserDefaults.standard.set(self.currentLanguage, forKey: "SELECTED_LANGUAGE")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name("updateLanguage_Notification"), object: nil)
           // self.loadingNotification.hide(animated: true, afterDelay: 3)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
         self.navigationController?.navigationBar.isHidden = true
         if (UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") != nil) {
        currentLanguage = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as! String
        lbl_title.text = LanguageManager.sharedInstance.LocalizedLanguage(key: titleString, languageCode: currentLanguage)
        DispatchQueue.main.async() {
            self.setting_TableView.reloadData()
        }
        }
         else{
            //Nothing to do ...
        }
    }
    
    @IBAction func btnBack_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "settingCell") as UITableViewCell?)!
        cell.selectionStyle = .none
        
        let btnView : UIView = cell.viewWithTag(1)!
        let btn_settingOption : UIButton = cell.viewWithTag(2) as! UIButton
        let textF_Language : UITextField = cell.viewWithTag(4) as! UITextField
        
        let btnImageView : UIImageView = cell.viewWithTag(3) as! UIImageView
        btnView.layer.cornerRadius = 8
        
        btnView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
//        if pickedLanguageCode == "ug" {
//            btn_settingOption.contentHorizontalAlignment = .right
//            btn_settingOption.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
//
//        }
//        else{
//            btn_settingOption.contentHorizontalAlignment = .center
//        }
        textF_Language.isHidden = true
        
        if indexPath.row == 0 {
           let sort_code = "\u{25BC}"
            btn_settingOption.setTitle("\(LanguageManager.sharedInstance.LocalizedLanguage(key: settingOptionsArray[indexPath.row], languageCode: currentLanguage))   \(sort_code)", for: .normal)
//            textF_Language.delegate = self
//            textF_Language.inputView = picker_language
//            textF_Language.tintColor = UIColor.clear
//            textF_Language.inputAccessoryView = toolbar
//            textF_Language.text = "\(sort_code)"
//            textF_Language.textAlignment = .right
//
//            textF_Language.setRightPaddingPoints(20)
//            textF_Language.isHidden = false
            
        }
        else if indexPath.row == 1{
        language_DropDown.anchorView = btn_settingOption
            btn_settingOption.setTitle(LanguageManager.sharedInstance.LocalizedLanguage(key: settingOptionsArray[indexPath.row], languageCode: currentLanguage), for: .normal)
        }
        else{
            btn_settingOption.setTitle(LanguageManager.sharedInstance.LocalizedLanguage(key: settingOptionsArray[indexPath.row], languageCode: currentLanguage), for: .normal)
//             textF_Language.isHidden = true
        }
        btnImageView.image = settingOptionImagesArray[indexPath.row].withRenderingMode(.alwaysTemplate)
        
        if indexPath.row == 4 {
            btn_settingOption.setTitleColor(UIColor.red, for: .normal)
            btnImageView.tintColor = UIColor.red
            
        }
        else{
            btn_settingOption.setTitleColor(UIColor.black, for: .normal)
            btnImageView.tintColor = UIColor.black
        }
        
        
        btn_settingOption.addTarget(self, action: #selector(settingOptions_Action), for: .touchUpInside)
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    @objc func settingOptions_Action(sender : UIButton) {
        
//        let alertTitle = NSLocalizedString("Logout", comment: "")
//        let alertMessage = NSLocalizedString("Do you want to Log Out ?", comment: "")
//        let cancelButtonText = NSLocalizedString("No", comment: "")
//        let yesButtonText = NSLocalizedString("Yes", comment: "")
       
        print("SELCTED LANG = \(currentLanguage)")
        let alertTitle = LanguageManager.sharedInstance.LocalizedLanguage(key: "Log Out", languageCode: currentLanguage)
        let alertMessage = LanguageManager.sharedInstance.LocalizedLanguage(key: "Do you want to Log Out ?", languageCode: currentLanguage)
        let cancelButtonText = LanguageManager.sharedInstance.LocalizedLanguage(key: "No", languageCode: currentLanguage)
        let yesButtonText = LanguageManager.sharedInstance.LocalizedLanguage(key: "Yes", languageCode: currentLanguage)
        
        let alertTitleOfChangePassword = LanguageManager.sharedInstance.LocalizedLanguage(key: "Change Password", languageCode: currentLanguage)
       
        


        let buttonPosition = sender.convert(sender.bounds.origin, to: self.setting_TableView)
        if let indexPath = self.setting_TableView.indexPathForRow(at: buttonPosition){
            if indexPath.row == 0
            {
                language_DropDown.show()
                language_DropDown.selectionAction = {
                    [weak self] (index, item) in
                    print(index, item)
                    // self?.btn_merchandisingFilter.setTitle(item, for: .normal)
                    if item == "中文" {
                        self!.currentLanguage = "zh-Hans"
                        self!.selectedLanguage = "zh_CN"
                    }
                    else if item == "ئۇيغۇر" {
                        self!.currentLanguage = "ug"
                        self!.selectedLanguage = "ug_CN"
                    }
                    else{
                        self!.currentLanguage = "en"
                        self!.selectedLanguage = "en_US"
                    }
                    self!.updateLanguage(withCode: self!.currentLanguage)
                   // zh_CN, en_US, ug_CN
                  // self?.changeLanguage(withLanguage: self!.selectedLanguage)
            
                }
            }
            else if indexPath.row == 1 {
                let alert = UIAlertController(title: alertTitleOfChangePassword, message: "Enter New Password.", preferredStyle: .alert)
                
                
//                alert.addTextField { (textField) in
//                    textField.placeholder = "Enter New Password"
//                }
                
            
            
         
            //For first TF
            alert.addTextField { (textField) in
                textField.placeholder = "Enter New Password"
                textField.isSecureTextEntry = true
            }
            //For second TF
            alert.addTextField { (textField) in
                textField.placeholder = "Confirm Password"
                textField.isSecureTextEntry = true
               
            }
                
                alert.addAction(UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.default, handler: { _ in
                    //No Action
                }))
                
                alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
//                    let textField = alert?.textFields![0]
//                    print("Text field: \(textField!.text ?? "")")
//                    if (textField?.text!.isEmpty)!{
//                        self.view.makeToast("Please enter new password.")
//                    }
                    let password_TextF = alert?.textFields![0]
                    let re_Password_TextF = alert?.textFields![1]
                    print("OLD PASSWORD : \(password_TextF!.text!)")
                    print("Re PASSWORD : \(re_Password_TextF!.text!)")
                    
                    if (password_TextF?.text!.isEmpty)! {
                        self.view.makeToast("Please enter new password.")
                    }
                    else if password_TextF!.text!.count < 6{
                         self.view.makeToast("Password should be equal & greater than 6 character.")
                    }
                    else if (re_Password_TextF?.text!.isEmpty)! {
                       self.view.makeToast("Please re-enter new password.")
                    }
                    else if re_Password_TextF!.text!.count < 6{
                         self.view.makeToast("Password should be equal & greater than 6 character.")
                    }
                    else if re_Password_TextF!.text! != password_TextF!.text!{
                        self.view.makeToast("Confirm Password doesn't matches with New Password.")
                    }
                    else{
                        self.changePassword(withPassword: password_TextF!.text!, withRe_Password: re_Password_TextF!.text!)
                        print("ALL OK")
                    }
                }))
                
               
                self.present(alert, animated: true, completion: nil)
            }
            else if indexPath.row == 4 {
                let alert = UIAlertController(title: alertTitle, message: alertMessage,         preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: cancelButtonText, style: UIAlertAction.Style.default, handler: { _ in
                    //No Action
                }))
                alert.addAction(UIAlertAction(title: yesButtonText,
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                                                //Log out action
                                                
                                                //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                                self.logOut_Method()
                                               
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    func goToLOGIN()  {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(loginVC, animated: true, completion: nil)
    }
   /* func changePassword(withNewpassword: String) {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_POST_CHANGE_PASSWORD
        //        let password = "123456"//withPassword
        //        let db = "apidev"
        //        let login = "admin@eotor.net"//withUsername
        
        print(url)
        let AT = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(AT)")
        let user_id = "\(UserDefaults.standard.object(forKey: "user_ID") ?? "No ID")"
        print("USER ID == > \(user_id)")
        let json: [String: Any] = ["__api__user_ids": "[(0, 0,  {'user_id': \(user_id),'new_passwd':'\(withNewpassword)'})]"]
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(AT, forHTTPHeaderField: "access-token")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "requestSerializer")
        
        manager.post(url, parameters: json, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            if let dic = responseObject as?  [String: Any]{
            
                if let content = dic["data"] as? NSArray {
                    //print(content)
                    if let data = content[0] as? [String:Any]
                    {
                        print(data)
                        self.wizardID = "\(data["id"] ?? "")"//data["id"]! as! String
                        self.Update_ChangedPassword(withWizardID: self.wizardID)
                    }
                }
                appDelegate.hideHUD()
                
                
            }
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        
        
    }
    func Update_ChangedPassword(withWizardID: String)  {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        print(withWizardID)
        print(wizardID)

       /* let url = BASE_URL + k_API_PATCH_CHANGE_PASSWORD + withWizardID
        
        print(url)
        let AT = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(AT)")
        
        let json: [String: Any] = ["_method": "change_password_button"]
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(AT, forHTTPHeaderField: "access-token")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "requestSerializer")
       
        manager.patch(url, parameters: json, success: {
            (operation, responseObject) in
            print(responseObject!)
            if let dic = responseObject as?  [String: Any]{
                print(dic)
//                if let content = dic["data"] as? NSArray {
//                    //print(content)
//                    if let data = content[0] as? [String:Any]
//                    {
//                        print(data)
//
//
//                    }
//                }
                appDelegate.hideHUD()
                
                
            }
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })*/
        let url = BASE_URL + k_API_PATCH_CHANGE_PASSWORD + withWizardID
        let AT = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(AT)")
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(AT, forHTTPHeaderField: "access-token")
        
        do{
            
            //let json: [String: Any] = ["status": "test"]
            let json: [String: Any] = ["_method": "change_password_button"]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
           // appDelegate.hideHUD()
            print("ERROR")
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
           // appDelegate.hideHUD()
            
            let responseString = NSString(data: data!, encoding:   String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
            DispatchQueue.main.async {
               self.loadingNotification.hide(animated: true)
            }
            
            //completion(true)
            return
        }
       // appDelegate.hideHUD()
        task.resume()
    }*/
    func changePassword(withPassword:String, withRe_Password: String) {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_POST_CHANGE_PASSWORD
        let password = withPassword
        
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        print(url)
        let manager = AFHTTPSessionManager()
       
        let parametes = ["password": password]
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            
            if let dic = responseObject as?  [String: Any]{
                print(dic)
                
                
                if let code = dic["code"] as? String {
                    if code == "200"
                    {
                        let msg = dic["msg"] as? String
                        if msg == "Success"
                        {
                            appDelegate.hideHUD()
                            self.view.makeToast("Your password is successfully changed.")
                        }
                    }
                    else{
                       
                        appDelegate.hideHUD()
                        self.view.makeToast("\(dic["err"] ?? "Failed to Authorized.")")
                    }
                }
                

            }
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
    func changeLanguage(withLanguage:String) {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_POST_CHANGE_LANGUAGE
        let lang = withLanguage
        
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        print(url)
        let manager = AFHTTPSessionManager()
        
        let parametes = ["lang": lang]
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
       // manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as? Set<String>
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            
            if let dic = responseObject as?  [String: Any]{
                print(dic)
                
                
                if let code = dic["code"] as? String {
                    if code == "200"
                    {
                        let msg = dic["msg"] as? String
                        if msg == "Success"
                        {
                            appDelegate.hideHUD()
                            self.view.makeToast("Your Language is successfully changed.")
                        }
                    }
                    else{
                        
                        appDelegate.hideHUD()
                        self.view.makeToast("\(dic["err"] ?? "Failed to Authorized.")")
                    }
                }
                
                
            }
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
    func logOut_Method() {
        print("LOGOUT")
        let url = BASE_URL + k_API_POST_REVOKE_TOKEN
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
    
        
        print(url)
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        
        
        let manager = AFHTTPSessionManager()
      
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
        // manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
      
        manager.post(url, parameters: nil, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            
            if let dic = responseObject as?  [String: Any]{
                print(dic)
                
                
                if let code = dic["code"] as? Int {
                    if code == 200
                    {
                        let msg = dic["msg"] as? String
                        if msg == "Revoked"
                        {
                            appDelegate.hideHUD()
                            UserDefaults.standard.set("NO", forKey: "isLOGIN")
                            UserDefaults.standard.synchronize()
                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                            self.view.makeToast("Logout Successfully")
                        }
                    }
                    else{
                        
                        appDelegate.hideHUD()
                        self.view.makeToast("Failed to Authorized. Please try Again.")
                    }
                }
                
                
            }
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
