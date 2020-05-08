//
//  FeedsViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 05/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var feedsView: UIView!
    @IBOutlet weak var feeds_TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        feedsView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        let equipmentNib = UINib(nibName: "EquipmentMaintenanceCell", bundle: nil)
        feeds_TableView.register(equipmentNib, forCellReuseIdentifier: "EquipmentCell")
        
        let userFeedNib = UINib(nibName: "UserFeedsCell", bundle: nil)
        feeds_TableView.register(userFeedNib, forCellReuseIdentifier: "UserFeedsCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if indexPath.row % 2 == 0 {
            let cell:UserFeedsCell = (tableView.dequeueReusableCell(withIdentifier: "UserFeedsCell") as! UserFeedsCell?)!
            cell.selectionStyle = .none
            cell.cellView.layer.cornerRadius = 8
            cell.cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            cell.next_btn.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            cell.next_btn.layer.cornerRadius  = 8
            cell.userProfileImageView.layer.cornerRadius = cell.userProfileImageView.frame.size.width / 2
            cell.userProfileImageView.layer.masksToBounds = false
            cell.userProfileImageView.dropShadowWithBorder(borderWidth: 3, borderColor: UIColor.white, shadowColor: UIColor.gray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            cell.userStatus_lbl.text = "Roshan Daniel's Leaves expires tomorrow."
            return cell
        }
        else
        {
            let cell:EquipmentMaintenanceCell = (tableView.dequeueReusableCell(withIdentifier: "EquipmentCell") as! EquipmentMaintenanceCell?)!
            cell.selectionStyle = .none
            cell.cellView.layer.cornerRadius = 8
            cell.cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            cell.btn_next.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            cell.btn_next.layer.cornerRadius  = 8
            cell.btn_next.setImage(UIImage(named: "approved"), for: .normal)
            cell.btn_next.imageEdgeInsets = UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
            cell.userProfileImageView.image = UIImage(named: "maintenance")
            return cell
        }
        
        
        
        
        
        
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row  % 2 == 0 {
            return 80
        }
        else{
            return 90
        }
        
        
    }

   

}
