//
//  CustomPickerView.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 26/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var dataArray : [String] = []
    var pickedValue : String!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       // textF_Category.text =  arrayOfCountries[row]
        if dataArray.count > 0
        {
        pickedValue = dataArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label:UILabel
        
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
        
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        label.text = dataArray[row]
        
        return label
    }
}
