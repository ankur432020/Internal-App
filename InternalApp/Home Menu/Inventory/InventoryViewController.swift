//
//  InventoryViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 07/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
import AFNetworking
class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var inventory_CollectionView: UICollectionView!
    @IBOutlet weak var inventory_TableView: UITableView!
    
   
    
    // DROPDOWS ---
    var dropDown_inventoryFilter_ByCategory = DropDown()
    var dropDown_inventoryFilter_ByProduct = DropDown()
    
    
    // AnchorViews ---
    @IBOutlet weak var inventoryFilterView_ByCategory: UIView!
    
    @IBOutlet weak var inventoryFilterView_ByProduct: UIView!
    
    @IBOutlet weak var btn_filterByProduct: UIButton!
    
    @IBOutlet weak var btn_filterByCategory: UIButton!
    var inventoryDataArray = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inventoryView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        setup_DropDowns_UI()
        
        getInventoryData_Method()
     
    }
    func setup_DropDowns_UI(){
        
        dropDown_inventoryFilter_ByCategory.dataSource = ["Categ 1", "Categ 2", "Categ 3", "Categ 4", "Categ 5"]
        dropDown_inventoryFilter_ByCategory.anchorView = inventoryFilterView_ByCategory
        dropDown_inventoryFilter_ByCategory.cornerRadius = 8
        dropDown_inventoryFilter_ByCategory.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_inventoryFilter_ByCategory.selectionBackgroundColor = UIColor.black
        dropDown_inventoryFilter_ByCategory.selectedTextColor = UIColor.yellow
        
        
        dropDown_inventoryFilter_ByProduct.dataSource = ["Meat Product", "Milk Product", "Beer Product", "Vegetables Product", "Fruits Product"]
        dropDown_inventoryFilter_ByProduct.anchorView = inventoryFilterView_ByProduct
        dropDown_inventoryFilter_ByProduct.cornerRadius = 8
        dropDown_inventoryFilter_ByProduct.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_inventoryFilter_ByProduct.selectionBackgroundColor = UIColor.black
        dropDown_inventoryFilter_ByProduct.selectedTextColor = UIColor.yellow
        
    }
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryDataArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "itemCell") as UITableViewCell?)!
        cell.selectionStyle = .none
        
        let itemName : UILabel = cell.viewWithTag(1) as! UILabel
        let slider : CustomSlider = cell.viewWithTag(2) as! CustomSlider
        let itemQtyValues: UILabel = cell.viewWithTag(3) as! UILabel
        let btn_AddtoPurchase : UIButton = cell.viewWithTag(4) as! UIButton
        slider.setThumbImage(UIImage(), for: .normal)
        let slash = "/"
        
        if inventoryDataArray.count > 0
        {
            let tempDict = inventoryDataArray["\(indexPath.row+1)"] as! [String: Any]
            
            itemName.text = tempDict["name"] as? String
            slider.maximumValue = tempDict["product_count"] as! Float
            slider.value = tempDict["out_of_stock_count"] as! Float
            itemQtyValues.text = "\(tempDict["out_of_stock_count"] ?? "0")\(slash)\(tempDict["product_count"] ?? 0)"
        }
       /* if indexPath.row == 0 {
            slider.value = 10
            
        }
        else if indexPath.row == 1 {
            slider.value = 80
        }
        else if indexPath.row == 2
        {
            slider.value = 20
        }
        else if indexPath.row == 3
        {
            slider.value = 55
        }
        else if indexPath.row == 4
        {
            slider.value = 15
        }
        else if indexPath.row == 9
        {//print(indexPath.row)
            slider.value = 30
        }
        else
        {
            slider.value = 60
        }*/
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inventoryCheckCell", for: indexPath as IndexPath)
        
        
        let cellView : UIView = cell.viewWithTag(1)!
        
        //cellView.backgroundColor = UIColor.red
        cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
    }
    
    
    @IBAction func btnAction_filterByCategory(_ sender: Any) {
        dropDown_inventoryFilter_ByCategory.show()
        dropDown_inventoryFilter_ByCategory.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_filterByCategory.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnAction_filterByProduct(_ sender: Any) {
    dropDown_inventoryFilter_ByProduct.show()
        dropDown_inventoryFilter_ByProduct.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
             self?.btn_filterByProduct.setTitle(item, for: .normal)
        }
    }
    
    
    func getInventoryData_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_INVENTORY_DATA
        let url = URL(string: "\(url1)")!
        
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                for i in 1..<responseJSONs.count+1{
                    self.inventoryDataArray["\(i)"] = responseJSONs["\(i)"]
                }
                
                DispatchQueue.main.async {
                    print("Inventory Data = \(self.inventoryDataArray)")
                    
                    self.inventory_TableView.reloadData()
                    appDelegate.hideHUD()
                }
                
                
            }
            else{
                DispatchQueue.main.async {
                    appDelegate.hideHUD()
                }
            }
        }
        
        task.resume()
    }
   
    
    
}
