//
//  TabViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 04/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
 var currentLanguage = "en"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectedIndex = 2
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         if (UserDefaults.standard.object(forKey: "SELECTED_LANGUAGE") != nil) {
        currentLanguage = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as! String
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotfication(notification:)), name: Notification.Name("updateLanguage_Notification"), object: nil)
            updateTabBar_Title(withLanguage: currentLanguage)
        }
         else{
            //Nothing to do...
            updateTabBar_Title(withLanguage: currentLanguage)
            
        }
       
        
    }
    
    @objc func methodOfReceivedNotfication(notification: Notification){
        currentLanguage = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as! String
        updateTabBar_Title(withLanguage: currentLanguage)
        
    }
    func updateTabBar_Title(withLanguage: String) {
        tabBar.items![0].title = LanguageManager.sharedInstance.LocalizedLanguage(key: "Requests", languageCode: currentLanguage)
        tabBar.items![1].title = LanguageManager.sharedInstance.LocalizedLanguage(key: "Feeds", languageCode: currentLanguage)
        tabBar.items![2].title = LanguageManager.sharedInstance.LocalizedLanguage(key: "Home", languageCode: currentLanguage)
        tabBar.items![3].title = LanguageManager.sharedInstance.LocalizedLanguage(key: "Chat", languageCode: currentLanguage)
        tabBar.items![4].title = LanguageManager.sharedInstance.LocalizedLanguage(key: "More", languageCode: currentLanguage)
    }
}
