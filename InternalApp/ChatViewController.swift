//
//  ChatViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 05/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var chatList_tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "chatCell") as UITableViewCell?)!
        cell.selectionStyle = .none
        let cellView : UIView = cell.viewWithTag(1)!
        cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        let profile_ImageView : UIImageView = cell.viewWithTag(2) as! UIImageView
        profile_ImageView.layer.cornerRadius = profile_ImageView.frame.size.width / 2
        profile_ImageView.layer.masksToBounds = false
        profile_ImageView.dropShadowWithBorder(borderWidth: 3, borderColor: UIColor.white, shadowColor: UIColor.gray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
