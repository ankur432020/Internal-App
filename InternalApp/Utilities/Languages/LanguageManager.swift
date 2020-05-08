//
//  LanguageManager.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 26/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import Foundation
class LanguageManager
{
    
    static let sharedInstance =  LanguageManager()
    
    //Make a function for Localization. Language Code is the one which we will be deciding on button click.
    func LocalizedLanguage(key:String,languageCode:String)->String{
        
        //Make sure you have Localizable bundles for specific languages.
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        
        //Check if the path is nil, make it as "" (empty path)
        path = (path != nil ? path:"")
        
        let languageBundle:Bundle!
        
        if(FileManager.default.fileExists(atPath: path!)){
            languageBundle = Bundle(path: path!)
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        }else{
            // If path not found, make English as default
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
            languageBundle = Bundle(path: path!)
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        }
    }
}
