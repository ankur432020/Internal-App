//
//  RequestsViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 05/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var requestsView: UIView!
    @IBOutlet weak var request_TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        requestsView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        
        let equipmentNib = UINib(nibName: "EquipmentMaintenanceCell", bundle: nil)
        request_TableView.register(equipmentNib, forCellReuseIdentifier: "EquipmentCell")
        let requestNib = UINib(nibName: "UserRequestsCell", bundle: nil)
        request_TableView.register(requestNib, forCellReuseIdentifier: "RequestsCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0
        {
            /* let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "userRequestsCell") )!
             cell.selectionStyle = .none
             let cellView : UIView = cell.viewWithTag(1)!
             let btn_Next: UIButton = cell.viewWithTag(8) as! UIButton
             
             let userProfileImage: UIImageView = cell.viewWithTag(3) as! UIImageView
             userProfileImage.layer.cornerRadius = userProfileImage.frame.size.width / 2
             userProfileImage.layer.masksToBounds = false
             userProfileImage.dropShadowWithBorder(borderWidth: 3, borderColor: UIColor.white, shadowColor: UIColor.gray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
             cellView.layer.cornerRadius = 8
             
             cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
             
             btn_Next.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
             btn_Next.layer.cornerRadius  = 8*/
            
            let cell:UserRequestsCell = (tableView.dequeueReusableCell(withIdentifier: "RequestsCell") as! UserRequestsCell?)!
            cell.selectionStyle = .none
            cell.cellView.layer.cornerRadius = 8
            cell.cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
           
            cell.next_btn.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            cell.next_btn.layer.cornerRadius  = 8
            
            
            return cell
        }
        else{
            let cell:EquipmentMaintenanceCell = (tableView.dequeueReusableCell(withIdentifier: "EquipmentCell") as! EquipmentMaintenanceCell?)!
            cell.selectionStyle = .none
            cell.cellView.layer.cornerRadius = 8
            cell.cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            cell.userProfileImageView.image = UIImage(named: "maintenance")
            // cell.userProfileImageView.layer.cornerRadius = cell.userProfileImageView.frame.size.width / 2
            //cell.userProfileImageView.layer.borderColor = UIColor.blue.cgColor
            // cell.userProfileImageView.layer.borderWidth = 2
            
            //
            //        cell.userProfileImageView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 2, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
            //       cell.userProfileImageView.layer.masksToBounds = false
            cell.btn_next.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
           
            cell.btn_next.layer.cornerRadius  = 8
            return cell
        }
        
        
        
        
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 120
        }
        else{
            return 90
        }
        
    }
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
}
