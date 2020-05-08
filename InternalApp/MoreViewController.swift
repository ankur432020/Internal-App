//
//  MoreViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 05/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var moreOptionsArray = [String]()
    var moreOptionsImageArray = [UIImage]()
    
    @IBOutlet weak var optionTableView: UITableView!
    var currentLanguage = "en"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        moreOptionsArray = ["Career", "Quick View", "Settings"]
        moreOptionsImageArray = [UIImage(named: "career"), UIImage(named: "quickView"),UIImage(named: "settings")] as! [UIImage]
        optionTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if (UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") != nil) {
            currentLanguage = UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") as! String
            NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotfication(notification:)), name: Notification.Name("updateLanguage_Notification"), object: nil)
            DispatchQueue.main.async() {
                self.optionTableView.reloadData()
            }
        }
        else
        {
            //Nothing to do...
        }
        
    }
    
    @objc func methodOfReceivedNotfication(notification: Notification){
        currentLanguage = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as! String
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "moreCell") as UITableViewCell?)!
        cell.selectionStyle = .none
        cell.textLabel?.text = LanguageManager.sharedInstance.LocalizedLanguage(key: moreOptionsArray[indexPath.row], languageCode: currentLanguage)//moreOptionsArray[indexPath.row]
        cell.imageView?.image = self.imageWithImage(image: moreOptionsImageArray[indexPath.row], scaledToSize: CGSize(width: 29, height: 29))
        
//        let sl : CustomSlider = cell.viewWithTag(7) as! CustomSlider
//        sl.maximumValue = 100
//        sl.minimumValue = 0
//        sl.minimumTrackTintColor = .red
//        sl.maximumTrackTintColor = .lightGray
//        sl.setThumbImage(UIImage(), for: .normal)
//        if indexPath.row == 0 {
//            sl.value = 10
//
//        }
//        else if indexPath.row == 1 {
//            sl.value = 30
//        }
//        else
//        {
//            sl.value = 45
//        }
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")  as! SettingsViewController
            vc.titleString = moreOptionsArray[indexPath.row]
            vc.titileImage = moreOptionsImageArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
}
