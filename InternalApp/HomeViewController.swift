//
//  HomeViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 04/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var textF_Search: UITextField!
    @IBOutlet weak var imageView_userProfile: UIImageView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var category_CollectioView: UICollectionView!
    
    var categoryNamesArray = [String]()
    var categoryImagesArray = [UIImage]()
    var badgeValuesArray = [String]()
    var bgView = UIView()
    var currentLanguage = "en"
    
    private var myArray: NSArray = ["First"]
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        headerView!.layer.cornerRadius = 16
        headerView!.layer.masksToBounds = true
        
        if #available(iOS 11.0, *) {
            headerView!.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        textF_Search.layer.cornerRadius = 20
        textF_Search.setLeftPaddingPoints(20)
        textF_Search.returnKeyType = .search
        textF_Search.clearButtonMode = .whileEditing
        textF_Search.delegate = self
        
        imageView_userProfile.layer.cornerRadius = imageView_userProfile.frame.size.width / 2
        imageView_userProfile.layer.borderColor = UIColor.white.cgColor
        imageView_userProfile.layer.borderWidth = 4
        
        categoryView.dropShadowWithBorder(borderWidth: 1, borderColor:  UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        categoryNamesArray = ["Sales", "Member", "Inventory", "Purchase", "Human Resource", "Finance", "Manufacture", "Store Management Equipment", "Equipment"]
        badgeValuesArray = ["2","0","0","0","0","5","0","1","0"]
        categoryImagesArray = [UIImage(named: "cashbox.png"),
                               UIImage(named: "avatar.png"),
                               UIImage(named: "warehouse.png"),
                               UIImage(named: "cart.png"),
                               UIImage(named: "hr.png"),
                               UIImage(named: "money.png"),
                               UIImage(named: "conveyor.png"),
                               UIImage(named: "shop.png"),
                               UIImage(named: "repair.png")] as! [UIImage]
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: displayHeight - 300, width: displayWidth, height: 200))
        let leftAssistantNib = UINib(nibName: "LeftAssistantCell", bundle: nil)
        myTableView.register(leftAssistantNib, forCellReuseIdentifier: "LeftAssistant")
        
        let rightAssistantNib = UINib(nibName: "RightAssistantCell", bundle: nil)
        myTableView.register(rightAssistantNib, forCellReuseIdentifier: "RightAssistant")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        myTableView.backgroundColor = UIColor.clear
        
        let userID = "\(UserDefaults.standard.object(forKey: "user_ID") ?? "No ID")"
        getUserDetails_Method(withUserID: userID)
        // getModules_Method()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            appDelegate.hideHUD()
        }
        if (UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") != nil) {
            currentLanguage = UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") as! String
            NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotfication(notification:)), name: Notification.Name("updateLanguage_Notification"), object: nil)
            DispatchQueue.main.async() {
                self.category_CollectioView.reloadData()
            }
        }
        else
        {
            //Nothing to do...
        }
        
    }
    // MARK: - Dismiss Keyboard Method
    // MARK: -
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func methodOfReceivedNotfication(notification: Notification){
        currentLanguage = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as! String
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftAssistant", for: indexPath as IndexPath) as! LeftAssistantCell
            // cell.textLabel!.text = "\(myArray[indexPath.row])"
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightAssistant", for: indexPath as IndexPath) as! RightAssistantCell
            // cell.textLabel!.text = "\(myArray[indexPath.row])"
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftAssistant", for: indexPath as IndexPath) as! LeftAssistantCell
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath as IndexPath)
        
        let btn_categoryItem : UIButton = cell.viewWithTag(1) as! UIButton
        let lbl_categoryName : UILabel = cell.viewWithTag(2) as! UILabel
        let lbl_badge : UILabel = cell.viewWithTag(3) as! UILabel
        //let btnView : UIView = cell.viewWithTag(4)!
        let lblView : UIView = cell.viewWithTag(5)!
        
        //btnView.frame.size.width = 90.0
        //print("WIDTh -- \(btnView.frame.size.width)")
        //        DispatchQueue.once(token: "com.app.test") {
        //            print( "Do This Once!" )
        //
        //             btnView.dropShadow(cRadius: btnView.frame.size.width / 2, bgColor: .white)
        //
        //        }
        
        // btnView.layer.cornerRadius = btnView.frame.size.width / 2
        //btnView.backgroundColor = .white
        //btnView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        btn_categoryItem.layer.cornerRadius = 45
        btn_categoryItem.layer.masksToBounds = false
        btn_categoryItem.backgroundColor = .white
        btn_categoryItem.dropShadowWithBorder(borderWidth: 2, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 2.0, shadowOffset: CGSize(width: -1.5, height: 2.0), shadowOpacity: 0.5)
        btn_categoryItem.layer.shadowPath = UIBezierPath(roundedRect: btn_categoryItem.frame, cornerRadius: btn_categoryItem.layer.cornerRadius).cgPath
        
        
        
        lbl_badge.backgroundColor = .red
        lbl_badge.clipsToBounds = true
        lbl_badge.layer.cornerRadius = lbl_badge.frame.size.width / 2
        lblView.layer.cornerRadius = lblView.frame.size.width / 2
        lbl_badge.textColor = UIColor.white
        btn_categoryItem.setImage(categoryImagesArray[indexPath.item], for: .normal)
        
        if badgeValuesArray[indexPath.item] == "0" {
            lbl_badge.isHidden = true
            lblView.isHidden = true
        }
        else{
            lbl_badge.text = badgeValuesArray[indexPath.item]
            lbl_badge.isHidden = false
            lblView.isHidden = false
            
            //lblView.dropShadow(cRadius: lblView.frame.size.width / 2, bgColor: .white)
            
            // lblView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.lightGray, shadowRadius: 2.0, shadowOffset: CGSize(width: -1.0, height: 1.0), shadowOpacity: 0.5)
        }
        lbl_categoryName.text = LanguageManager.sharedInstance.LocalizedLanguage(key: categoryNamesArray[indexPath.item], languageCode: currentLanguage)//categoryNamesArray[indexPath.item]
        lbl_categoryName.adjustsFontSizeToFitWidth = true
        //btn_categoryItem.tag = indexPath.item
        //selectedIndexPathItem = indexPath.item
        btn_categoryItem.addTarget(self,
                                   action: #selector(self.openMenu),
                                   for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // var view_Width = 0.0
        var cellWidth = 0.0
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            
            cellWidth = Double(collectionView.bounds.width / 3.0)
        case .pad:
            
            cellWidth = Double(collectionView.bounds.width / 6.0)
        case .unspecified:
            cellWidth = Double(collectionView.bounds.width / 3.0)
        case .tv:
            cellWidth = Double(collectionView.bounds.width / 3.0)
        case .carPlay:
            cellWidth = Double(collectionView.bounds.width / 3.0)
        @unknown default:
            cellWidth = Double(collectionView.bounds.width / 3.0)
        }
        // let cellWidth = collectionView.bounds.width/3.0
        let cellHeight = cellWidth * 1.4
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func btnAction_openMicrophoneView(_ sender: Any) {
        /*  let window = UIApplication.shared.keyWindow!
         bgView = UIView(frame: window.bounds)
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         bgView.addGestureRecognizer(tap)
         window.addSubview(bgView);
         bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
         let v2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
         v2.backgroundColor = UIColor.white
         //bgView.addSubview(v2)
         bgView.addSubview(myTableView)
         
         let bottomView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width, height: 100))
         bottomView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
         let microphoneBtn = UIButton(frame: CGRect(x: (bottomView.frame.size.width / 2) - 30, y: 10, width: 60, height: 60))
         //let waveGif = UIImage.gifImageWithName("soundWave")
         // microphoneBtn.setImage(waveGif, for: .normal)
         microphoneBtn.setImage(UIImage(named: "radio"), for: .normal)
         // microphoneBtn.backgroundColor = UIColor.red
         microphoneBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
         microphoneBtn.addTarget(self, action: #selector(openSpeaker), for: .touchUpInside)
         bottomView.addSubview(microphoneBtn)
         bgView.addSubview(bottomView)*/
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        bgView.removeFromSuperview()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("SEARCH TExT === >> \(textField.text)")
        textField.resignFirstResponder()
        return true
        
    }
    @objc func openSpeaker()  {
        myArray = ["a","b"]
        myTableView.reloadData()
    }
    @objc func openMenu(sender : UIButton){
        // print(sender.tag) // PREVIOUS
        
        let buttonPosition = sender.convert(sender.bounds.origin, to: self.category_CollectioView)
        if let indexPath = self.category_CollectioView.indexPathForItem(at: buttonPosition)
        {
            if indexPath.item == 0 {
                let salesVC = self.storyboard?.instantiateViewController(withIdentifier: "SalesViewController")  as! SalesViewController
                self.present(salesVC, animated: true, completion: nil)
            }
            else if indexPath.item == 1 {
                let memberVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberViewController")  as! MemberViewController
                self.present(memberVC, animated: true, completion: nil)
            }
            else if indexPath.item == 2 {
                let inventoryVC = self.storyboard?.instantiateViewController(withIdentifier: "InventoryViewController")  as! InventoryViewController
                self.present(inventoryVC, animated: true, completion: nil)
            }
            else if indexPath.item == 3 {
                let purchaseVC = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseViewController")  as! PurchaseViewController
                self.present(purchaseVC, animated: true, completion: nil)
            }
            else if indexPath.item == 4 {
                let hrVC = self.storyboard?.instantiateViewController(withIdentifier: "HRViewController")  as! HRViewController
                self.present(hrVC, animated: true, completion: nil)
            }
            else if indexPath.item == 5 {
                let financeVC = self.storyboard?.instantiateViewController(withIdentifier: "FinanceViewController")  as! FinanceViewController
                self.present(financeVC, animated: true, completion: nil)
            }
            else if indexPath.item == 6 {
                let manufactureVC = self.storyboard?.instantiateViewController(withIdentifier: "ManufactureViewController")  as! ManufactureViewController
                self.present(manufactureVC, animated: true, completion: nil)
            }
            else if indexPath.item == 7 {
                let storeManagementVC = self.storyboard?.instantiateViewController(withIdentifier: "StoreManagementViewController")  as! StoreManagementViewController
                self.present(storeManagementVC, animated: true, completion: nil)
            }
            else if indexPath.item == 8 {
                let equipmentVC = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentViewController")  as! EquipmentViewController
                self.present(equipmentVC, animated: true, completion: nil)
            }
        }
        
        
        
        
    }
    func getUserDetails_Method(withUserID: String) {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_USER_DETAILS
        let url = URL(string: "\(url1)")!
        
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        print(url)
        
       // let json: [String:Any] = ["fields":"['image_medium', 'id', 'phone', 'email', 'name']"]//["{":"}"]
        
       // let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       // request.httpBody = jsonData
        
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                DispatchQueue.main.async {
                    appDelegate.hideHUD()
                }
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSONs = responseJSON as? [String: Any] {
                print(responseJSONs)
                //
                let defValue = UserDefaults.standard
                defValue.set(responseJSONs["email"], forKey: "user_EMAIL")
                defValue.set("\(responseJSONs["picture"] ?? "e")", forKey: "user_IMAGE")
                defValue.set(responseJSONs["phone_number"], forKey: "user_PHONE")
                defValue.set(responseJSONs["name"], forKey: "user_NAME")
                defValue.set(responseJSONs["uid"], forKey: "user_ID")
                defValue.set(responseJSONs["zoneinfo"], forKey: "zone_INFO")
                defValue.set(responseJSONs["locale"], forKey: "LOCALE")
                defValue.synchronize()
                self.setUp_UserDetails()
                
               /* if let content = responseJSONs["data"] as? NSArray {
                    //print(content)
                    if content.count > 0{
                        if let data = content[0] as? [String:Any]
                        {
                            print(data)
                            
                            let defValue = UserDefaults.standard
                            defValue.set(data["email"], forKey: "user_EMAIL")
                            defValue.set("\(data["image_medium"] ?? "e")", forKey: "user_IMAGE")
                            defValue.set(data["phone"], forKey: "user_PHONE")
                            defValue.set(data["name"], forKey: "user_NAME")
                            defValue.synchronize()
                            self.setUp_UserDetails()
                        }
                    }
                    else{
                        UserDefaults.standard.removeObject(forKey: "user_EMAIL")
                        UserDefaults.standard.removeObject(forKey: "user_IMAGE")
                        UserDefaults.standard.removeObject(forKey: "user_NAME")
                         UserDefaults.standard.removeObject(forKey: "user_PHONE")
                          UserDefaults.standard.synchronize()
                        
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                        }
                    }
                }*/
            }
            else{
                
                UserDefaults.standard.removeObject(forKey: "user_EMAIL")
                UserDefaults.standard.removeObject(forKey: "user_IMAGE")
                UserDefaults.standard.removeObject(forKey: "user_NAME")
                UserDefaults.standard.removeObject(forKey: "user_PHONE")
                UserDefaults.standard.removeObject(forKey: "user_ID")
                UserDefaults.standard.removeObject(forKey: "zone_INFO")
                UserDefaults.standard.removeObject(forKey: "LOCALE")
                UserDefaults.standard.set("NO", forKey: "isLOGIN")
                UserDefaults.standard.synchronize()
                let alert = UIAlertController(title: "Alert ! Session Expired", message: "Your Session is Expired.\nPlease login.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Login",
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                                                DispatchQueue.main.async {
                                                    appDelegate.hideHUD()
                                                }
                                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                                
                }))
                self.present(alert, animated: true, completion: nil)
                print("ALERT")
                DispatchQueue.main.async {
                    appDelegate.hideHUD()
                }
            }
        }
       
        task.resume()
    }
    func setUp_UserDetails() {
        let imageString = "\(UserDefaults.standard.object(forKey: "user_IMAGE") ?? "No Image")"
        DispatchQueue.main.async {
            self.imageView_userProfile.image = appDelegate.convertBase64StringToImage(imageString: imageString)
            appDelegate.hideHUD()
        }
       
    }
    func getModules_Method() {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        // let url = BASE_URL + k_API_GET_MODULES
        
        
        //  print(url)
        /* let AT = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
         
         print("AT ==> \(AT)")
         let json = [String]()
         
         let manager = AFHTTPSessionManager()
         manager.requestSerializer.setValue(AT, forHTTPHeaderField: "access-token")
         manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
         manager.get(url, parameters: json, progress: nil, success: {
         (operation, responseObject) in
         print(responseObject!)
         if let dic = responseObject as?  [String: Any]{
         print(dic)
         
         appDelegate.hideHUD()
         
         
         }
         }, failure: {
         (operation, error) in
         appDelegate.hideHUD()
         self.view.makeToast("Failed: Unauthorized")
         print("Error: " + error.localizedDescription)
         })
         //access_token_e26faff633b14dbad81ef47e50add93239bbed3f*/
        let json: [String:Any] = ["limit":"1"]//["{":"}"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "https://apidev.eotor.net/api/ir.module.module")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let AT = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(AT)")
        // insert json data to the request
        request.httpBody = jsonData
        
        request.setValue(AT, forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSONs = responseJSON as? [String: Any] {
                print(responseJSONs)
            }
            
        }
        
        
        task.resume()
        
    }
}
extension String {
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block:()->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
