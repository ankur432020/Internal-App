//
//  EquipmentViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 20/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
class EquipmentViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var maintenance_View: UIView!
    @IBOutlet weak var equipmentList_TableView: UITableView!
    @IBOutlet weak var equipmentList_View: UIView!
    
    @IBOutlet weak var equipmentDetail_View: UIView!
    
    @IBOutlet weak var equipmentDetail_BG_View: UIView!
    @IBOutlet weak var maintenance_TableView: UITableView!
    
    @IBOutlet weak var equipmentMaintenanceRequest_View: UIView!
    
    @IBOutlet weak var equipmentDescription_View: UIView!
    
    @IBOutlet weak var textView_equipmentProblem: UITextView!
    
    @IBOutlet weak var btn_usage: UIButton!
    @IBOutlet weak var btn_FAQ: UIButton!
    @IBOutlet weak var btn_maintenanceMethods: UIButton!
    var equipmentDataArray = [[String:Any]]()
    var maintenanceDataArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         maintenance_View.layer.cornerRadius = 8
        equipmentList_View.layer.cornerRadius = 8
        maintenance_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        equipmentList_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        equipmentDetail_BG_View.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        equipmentDetail_BG_View.isHidden = true
        equipmentDetail_BG_View.layer.cornerRadius = 8
        
        equipmentDetail_View.layer.cornerRadius = 8
        
        
        equipmentMaintenanceRequest_View.layer.cornerRadius = 8
        equipmentDescription_View.layer.cornerRadius = 8
        
        equipmentDescription_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        equipmentMaintenanceRequest_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        textView_equipmentProblem.layer.borderColor = UIColor.lightGray.cgColor
        textView_equipmentProblem.layer.borderWidth = 1
        textView_equipmentProblem.text = ""
        textView_equipmentProblem.layer.cornerRadius = 10
         btn_FAQ.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        btn_maintenanceMethods.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        btn_usage.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
      // getMaintenanceList_Method()
        //submit_MaintenanceRequest(withProblem: "TEST")
       // getEquipmentList_Method()
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCloseEquipmentDetailView_Action(_ sender: Any) {
        self.view.endEditing(true)
        equipmentDetail_BG_View.isHidden = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case equipmentList_TableView:
            return 2
        case maintenance_TableView:
            return 2
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case equipmentList_TableView:
            switch section {
            case 0 :
                return 1
            case 1 :
                return maintenanceDataArray.count
            default :
                return 0
            }
        case maintenance_TableView:
            switch section {
            case 0 :
                return 1
            case 1 :
                return equipmentDataArray.count
            default :
                return 0
            }
        default:
            return 0
        }
        //return 20
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case equipmentList_TableView:
            switch indexPath.section {
            case 0 :
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "equipmentListHeaderCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "equipmentListCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                let cellView: UIView = cell.viewWithTag(7)!
                let next_Btn : UIButton = cell.viewWithTag(8) as! UIButton
                cellView.layer.cornerRadius = 8
                // cellView.layer.masksToBounds = true
                
                let equipmentID_Lbl: UILabel = cell.viewWithTag(1) as! UILabel
                let equipmentName_Lbl: UILabel = cell.viewWithTag(2) as! UILabel
                let description_Lbl : UILabel = cell.viewWithTag(3) as! UILabel
                let departmentName_Lbl: UILabel = cell.viewWithTag(4) as! UILabel
                let ownerName_Lbl: UILabel = cell.viewWithTag(5) as! UILabel
                let count_Lbl: UILabel = cell.viewWithTag(6) as! UILabel
                if maintenanceDataArray.count > 0 {
//                    if !(maintenanceDataArray[indexPath.row]["equipment_id"] != nil){
//                        equipmentID_Lbl.text = "00"
//                        equipmentName_Lbl.text = "00"
//                    }
//                    else{
                    if indexPath.row > 2
                    {
                     let equipmentArray = maintenanceDataArray[indexPath.row]["equipment_id"] as! NSArray
                    
                    equipmentID_Lbl.text = "0\(equipmentArray[0])"
                    equipmentName_Lbl.text = "\(equipmentArray[1])"
                        let departmentArray = maintenanceDataArray[indexPath.row]["category_id"] as! NSArray
                        departmentName_Lbl.text = "\(departmentArray[1])"
                        let ownerArray = maintenanceDataArray[indexPath.row]["user_id"] as! NSArray
                        ownerName_Lbl.text = "\(ownerArray[1])"
                    }
                    else{
                        equipmentID_Lbl.text = "00"
                                        equipmentName_Lbl.text = "00"
                         departmentName_Lbl.text = "00"
                        ownerName_Lbl.text = "DEMO"
                        
                    }
                    description_Lbl.text = "           \(maintenanceDataArray[indexPath.row]["display_name"] ?? "NA")"
                    
                   
                    
                    count_Lbl.text = "\(maintenanceDataArray[indexPath.row]["maintenance_count"] ?? "99")"
                }
                cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
                next_Btn.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
                next_Btn.layer.cornerRadius  = 8
                if #available(iOS 11.0, *) {
                    next_Btn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                } else {
                    // Fallback on earlier versions
                }
                return cell
            default:
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "equipmentListHeaderCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                return cell
            }
        case maintenance_TableView:
            
            switch indexPath.section {
            case 0 :
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "maintenanceHeaderCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "maintenanceCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                let cellView: UIView = cell.viewWithTag(1)!
                
                cellView.layer.cornerRadius = 8
                // cellView.layer.masksToBounds = true
                
                let equipmentID_Lbl: UILabel = cell.viewWithTag(11) as! UILabel
                let equipmentName_Lbl: UILabel = cell.viewWithTag(12) as! UILabel
                 let count_Lbl : UILabel = cell.viewWithTag(13) as! UILabel
                 let reqTime_Lbl: UILabel = cell.viewWithTag(14) as! UILabel
                 let reason_Lbl: UILabel = cell.viewWithTag(15) as! UILabel
                 let maintenanceTeam_Lbl: UILabel = cell.viewWithTag(16) as! UILabel
                if equipmentDataArray.count > 0 {

               // let equipmentArray = dataArray[indexPath.row]["equipment_id"] as! NSArray
                
                    equipmentID_Lbl.text = "\(equipmentDataArray[indexPath.row]["id"] ?? "0")"
                    equipmentName_Lbl.text = "\(equipmentDataArray[indexPath.row]["display_name"] ?? "NA")"
                    reason_Lbl.text = "DATA NOT COMING"
                //let maintenanceArray = dataArray[indexPath.row]["maintenance_team_id"] as! NSArray
                    maintenanceTeam_Lbl.text = "\(equipmentDataArray[indexPath.row]["equipment_assign_to"] ?? "NA")"
                    reqTime_Lbl.text = "\(equipmentDataArray[indexPath.row]["period"] ?? "09") Days"
                    count_Lbl.text = "\(equipmentDataArray[indexPath.row]["maintenance_count"] ?? "99") Days"
                }
                
                cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
                
                return cell
            default:
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "equipmentListHeaderCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                return cell
            }
        default:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "equipmentListHeaderCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            return cell
        }
       
       
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        switch tableView {
        case equipmentList_TableView:
            equipmentDetail_BG_View.isHidden = false
        default:
            print("You tapped cell number \(indexPath.row).")
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case equipmentList_TableView:
            switch indexPath.section {
            case 0 :
                return 44
            case 1 :
                return 60
            default :
                return 0
            }
        case maintenance_TableView:
            switch indexPath.section {
            case 0 :
                return 44
            case 1 :
                return 60
            default :
                return 0
            }
        default:
        return 0
        }
      
       
    }
    func getEquipmentList_Method() {
        //neeche wala
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        
        let json: [String:Any] = ["{":"}"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let baseURL = BASE_URL + k_API_GET_EQUIPMENT_DETAILS
        
        let url = URL(string: baseURL)!
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
                //print(responseJSONs)
                //
                if let content = responseJSONs["data"] as? NSArray {
                    //print(content)
                    if content.count > 0{
                        //                        if let data = content[0] as? [String:Any]
                        //                        {
                        //                            print(data)
                        //
                        //                        }
                        for i in 0..<content.count{
                            self.equipmentDataArray.append(content[i] as! [String : Any])
                        }
                        print(self.equipmentDataArray)
                        DispatchQueue.main.async {
                            self.maintenance_TableView.reloadData()
                            appDelegate.hideHUD()
                        }
                        
                    }
                    else{
                        
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                        }
                    }
                }
                //
            }
            
        }
        
        
        task.resume()
    }
    func getMaintenanceList_Method() {
        //upar wala
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
     
        let json: [String:Any] = ["{":"}"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let baseURL = BASE_URL + k_API_GET_MAINTENACE_DETAILS
        
        let url = URL(string: baseURL)!
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
                //
                if let content = responseJSONs["data"] as? NSArray {
                    //print(content)
                    if content.count > 0{
                        for i in 0..<content.count{
                            self.maintenanceDataArray.append(content[i] as! [String : Any])
                        }
                        print(self.maintenanceDataArray)
                        DispatchQueue.main.async {
                            self.equipmentList_TableView.reloadData()
                            appDelegate.hideHUD()
                        }

                    }
                    else{

                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                        }
                    }
                }
                //
            }
            
        }
        
        
        task.resume()
        
    }
    func submit_MaintenanceRequest(withProblem: String) {
        print(msg_PLEASE_WAIT)
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        //{"name": "Maintainance Rquest 1", "category_id": 1, "stage_id":1}
        
        let json: [String:Any] = ["name":withProblem,"category_id":"1","stage_id":"1"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let baseURL = BASE_URL + k_API_GET_MAINTENACE_DETAILS
        
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                //
            }
            
        }
        
        
        task.resume()
    }

}
