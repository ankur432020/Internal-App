//
//  PurchaseViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 17/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
class PurchaseViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var purchaseDetailView: UIView!
    
    @IBOutlet weak var purchaseMenuItem_TableView: UITableView!
    @IBOutlet weak var logoView_InHeaderView: UIView!
    var menuItemImageArray = [UIImage]()
    var menuItemNameArray = [String]()
    var productValue = 0
    
    @IBOutlet weak var companyDetailView: UIView!
    
    @IBOutlet weak var productList_TableView: UITableView!
    var valuesWithRow = [Int]()
    var beerDataDict = [[String : String]]()
    var vegetableDataDict = [[String : String]]()
    var fruitDataDict = [[String : String]]()
    var meatDataDict = [[String : String]]()
    var milkDataDict = [[String : String]]()
    
    var productDataDict = [[String : String]]()
    var productImageArray = [[String : UIImage]]()
    
    
    @IBOutlet weak var companyListCollectionView: UICollectionView!
    var companyDataDict = [[String : String]]()
    var selectedIndexPath = 0
    var selectedIndexPathForProductMenu = 0
    
    @IBOutlet weak var companyAddress_lbl: UILabel!
    @IBOutlet weak var companyName_lbl: UILabel!
    var rectShapeCell = CAShapeLayer()
    var totalPrice = [Int]()
    var totalPriceValue = 0
    @IBOutlet weak var tax_lbl: UILabel!
    
    @IBOutlet weak var totalPrice_lbl: UILabel!
    
    @IBOutlet weak var tax_TotalPrice_lbl: UILabel!
    var supplierDataArray = [[String: Any]]()
    var productDataArray = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        purchaseDetailView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        //logoView_InHeaderView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        menuItemNameArray = ["Beer", "Vegetables", "Fruits", "Meat", "Milk"]
        menuItemImageArray = [UIImage(named: "beer"), UIImage(named: "vegetable"),UIImage(named: "fruit"),UIImage(named: "meatBlack"),UIImage(named: "milk")] as! [UIImage]
        valuesWithRow = [0,0,0,0,0,0,0,0,0,0]
        totalPrice = [0,0,0,0,0,0,0,0,0,0]
        
        for i in 0...9 {
            
            beerDataDict.append(["p_name": "Beer \(i+1)", "p_descp": "Beer Data \(i+1)","p_rate":"\(i+1)0"])
        }
        for i in 0...9 {
            
            vegetableDataDict.append(["p_name": "Vegetable \(i+2)", "p_descp": "Vegetable Data \(i+2)","p_rate":"\(i+2)0"])
        }
        for i in 0...9 {
            
            fruitDataDict.append(["p_name": "Fruit \(i+3)", "p_descp": "Fruit Data \(i+3)","p_rate":"\(i+3)0"])
        }
        for i in 0...9 {
            
            meatDataDict.append(["p_name": "Meat \(i+4)", "p_descp": "Meat Data \(i+4)","p_rate":"\(i+4)0"])
        }
        for i in 0...9 {
            
            milkDataDict.append(["p_name": "Milk \(i+5)", "p_descp": "Milk Data \(i+5)","p_rate":"\(i+5)0"])
        }
        productDataDict = beerDataDict
        for _ in 0...9 {
            
            productImageArray.append(["p_image": UIImage(named: "beerP")!])
        }
        companyDataDict.insert(["c_name": "World Central Kitchen", "c_address": "AMERICA, 22304","c_image": "foodMarket1"], at: 0)
        companyDataDict.insert(["c_name": "D.C. Central Kitchen", "c_address": "ITALY, 54001","c_image": "foodMarket2"], at: 1)
        companyDataDict.insert(["c_name": "Whole Foods Market", "c_address": "EGYPT, 90012","c_image": "foodMarket3"], at: 2)
       // companyName_lbl.text = "Company Name : \(companyDataDict[0]["c_name"] ?? "")"
        //companyAddress_lbl.text = "Company Address : \(companyDataDict[0]["c_address"] ?? "")"
        
        /* let rectShape = CAShapeLayer()
         rectShape.bounds = companyDetailView.frame
         rectShape.position = companyDetailView.center
         rectShape.path = UIBezierPath(roundedRect: companyDetailView.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 16, height: 16)).cgPath
         companyDetailView.layer.mask = rectShape
         companyDetailView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
         companyDetailView.backgroundColor = UIColor.red//UIColor.lightGray.withAlphaComponent(0.1)*/
        companyDetailView!.layer.cornerRadius = 20
        companyDetailView!.layer.masksToBounds = true
        companyDetailView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        companyDetailView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.1), shadowColor: UIColor.lightGray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        if #available(iOS 11.0, *) {
            companyDetailView!.layer.maskedCorners = [.layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        //productList_TableView.backgroundColor = UIColor.blue
        //        productList_TableView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize.zero, shadowOpacity: 0.5)
        purchaseMenuItem_TableView.reloadData()
        getSuppliersAndProductList_Method()
    }
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAction_Confirm(_ sender: Any) {
        let manufactureProductDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ManufactureProductDetailsViewController")  as! ManufactureProductDetailsViewController
        self.present(manufactureProductDetailVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case purchaseMenuItem_TableView:
            return menuItemNameArray.count
        case productList_TableView:
            return productDataArray.count
        default:
            return 0
        }
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case purchaseMenuItem_TableView:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "purchaseMenuCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            
            
            let cellView: UIView = cell.viewWithTag(1)!
            let menuItemImageView : UIImageView = cell.viewWithTag(2) as! UIImageView
            let menuitemName_lbl : UILabel = cell.viewWithTag(3) as! UILabel
            cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            menuitemName_lbl.text = menuItemNameArray[indexPath.row]
            
            menuItemImageView.image = menuItemImageArray[indexPath.row]
            menuitemName_lbl.adjustsFontSizeToFitWidth = true
            
            if indexPath.row == selectedIndexPathForProductMenu
            {
                cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
                rectShapeCell.bounds = cell.frame
                rectShapeCell.position = cell.center
                //rectShapeCell.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 16, height: 16)).cgPath
                // cell.layer.mask = rectShapeCell
                cell.layer.cornerRadius = 24
                cell.layer.masksToBounds = true
                
                if #available(iOS 11.0, *) {
                    cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                } else {
                    // Fallback on earlier versions
                }
                
            }
            else
            {
                cell.backgroundColor = UIColor.white
                cell.layer.cornerRadius = 0
            }
            return cell
        case productList_TableView:
            
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "productCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            let productImageView : UIImageView = cell.viewWithTag(1) as! UIImageView
            productImageView.layer.cornerRadius = 10
            let productName_lbl : UILabel = cell.viewWithTag(2) as! UILabel
            let productDescp_lbl : UILabel = cell.viewWithTag(3) as! UILabel
            let productRate_lbl : UILabel = cell.viewWithTag(4) as! UILabel
            let productValue_lbl : UILabel = cell.viewWithTag(6) as! UILabel
            let decreaseValue_Btn : UIButton = cell.viewWithTag(5) as! UIButton
            let increaseValue_Btn : UIButton = cell.viewWithTag(7) as! UIButton
            let cellView: UIView = cell.viewWithTag(11)!
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            cellView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.01)
            
           /* if productDataDict.count > 0 {
                productImageView.image = productImageArray[indexPath.row]["p_image"]
                productName_lbl.text = productDataDict[indexPath.row]["p_name"]
                productDescp_lbl.text = productDataDict[indexPath.row]["p_descp"]
                productDescp_lbl.adjustsFontSizeToFitWidth = true
                productName_lbl.adjustsFontSizeToFitWidth = true
                productRate_lbl.text = "$ \(productDataDict[indexPath.row]["p_rate"] ?? "") per kg"
            }*/
            productImageView.layer.borderColor = UIColor.darkGray.cgColor
            productImageView.layer.borderWidth = 1.5
            if productDataArray.count > 0
            {
                if let imageString = productDataArray[indexPath.item]["image_1920"] as? String
                {
                    DispatchQueue.main.async {
                        productImageView.image = appDelegate.convertBase64StringToImage(imageString: imageString)
                    }
                }
                else
                {
                    productImageView.image = UIImage(named: "imgPH")
                }
                productName_lbl.text = productDataArray[indexPath.row]["name"] as? String
                productName_lbl.adjustsFontSizeToFitWidth = true
                
            }
            //productValue_lbl.text = "0 Kg"
            
//            print(valuesWithRow)
//            if valuesWithRow.count > 0{
//                productValue_lbl.text = "\(valuesWithRow[indexPath.row]) Kg"
//            }
            
            increaseValue_Btn.addTarget(self, action: #selector(increasedValue), for: .touchUpInside)
            
            decreaseValue_Btn.addTarget(self, action: #selector(decreasedValue), for: .touchUpInside)
            
            return cell
            
        default:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "purchaseMenuCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            
            
            
            
            return cell
        }
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        switch  tableView{
        case purchaseMenuItem_TableView:
            if indexPath.row == 0
            {
                productDataDict = beerDataDict
                productImageArray = [[String : UIImage]]()
                for _ in 0...9 {
                    
                    productImageArray.append(["p_image": UIImage(named: "beerP")!])
                }
            }
            else if indexPath.row == 1
            {
                productDataDict = vegetableDataDict
                productImageArray = [[String : UIImage]]()
                for _ in 0...9 {
                    
                    productImageArray.append(["p_image": UIImage(named: "vegetablesP")!])
                }
            }
            else if indexPath.row == 2
            {
                productDataDict = fruitDataDict
                productImageArray = [[String : UIImage]]()
                for _ in 0...9 {
                    
                    productImageArray.append(["p_image": UIImage(named: "berries")!])
                }
            }
            else if indexPath.row == 3
            {
                productDataDict = meatDataDict
                productImageArray = [[String : UIImage]]()
                for _ in 0...9 {
                    
                    productImageArray.append(["p_image": UIImage(named: "fish")!])
                }
            }
            else if indexPath.row == 4
            {
                productDataDict = milkDataDict
                productImageArray = [[String : UIImage]]()
                for _ in 0...9 {
                    
                    productImageArray.append(["p_image": UIImage(named: "strawberry")!])
                }
            }
            valuesWithRow = [0,0,0,0,0,0,0,0,0,0]
            totalPrice = [0,0,0,0,0,0,0,0,0,0]
            selectedIndexPathForProductMenu = indexPath.row
            purchaseMenuItem_TableView.reloadData()
            productList_TableView.reloadData()
            productList_TableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        default:
            print("You tapped cell number \(indexPath.row).")
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case purchaseMenuItem_TableView:
            return 100
        case productList_TableView:
            return 120
        default:
            return 0
        }
    }
    
    
    @objc func increasedValue(sender : UIButton) {
        totalPriceValue = 0
        let buttonPosition = sender.convert(sender.bounds.origin, to: self.productList_TableView)
        if let indexPath = self.productList_TableView.indexPathForRow(at: buttonPosition){
            let rowIndex = indexPath.row
            productValue = valuesWithRow[rowIndex]
            valuesWithRow[rowIndex] = productValue + 1
            let indexPath_Reload = IndexPath(item: rowIndex, section: 0)
            productList_TableView.reloadRows(at: [indexPath_Reload], with: .none)
            calculateValue(withValue: valuesWithRow[rowIndex], withRow: rowIndex)
        }
        
    }
    @objc func decreasedValue(sender : UIButton) {
        totalPriceValue = 0
        let buttonPosition = sender.convert(sender.bounds.origin, to: self.productList_TableView)
        if let indexPath = self.productList_TableView.indexPathForRow(at: buttonPosition){
            let rowIndex = indexPath.row
            if valuesWithRow[rowIndex] > 0 {
                productValue = valuesWithRow[rowIndex]
                valuesWithRow[rowIndex] = productValue - 1
            }
            let indexPath_Reload = IndexPath(item: rowIndex, section: 0)
            productList_TableView.reloadRows(at: [indexPath_Reload], with: .none)
            calculateValue(withValue: valuesWithRow[rowIndex], withRow: rowIndex)
        }
        
        
    }
    func calculateValue(withValue: Int, withRow: Int) {
        print("VALUE == \(withValue)")
        print("PRICE ==\(productDataDict[withRow]["p_rate"] ?? "")")
        let priceRate = Int(productDataDict[withRow]["p_rate"]!)
        print("PR  == \(priceRate ?? 0)")
        totalPrice[withRow] = withValue * priceRate!
        print("Price array == \(totalPrice)")
        for i in 0..<totalPrice.count {
            print(totalPrice[i])
            totalPriceValue += totalPrice[i]
        }
        totalPrice_lbl.text = "$ \(totalPriceValue)"
        let taxValue = 30
        let totalValue = taxValue + totalPriceValue
        
        tax_TotalPrice_lbl.text = "$ \(totalValue)"
        print("TOTAL PRICE == \(totalPriceValue)")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supplierDataArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyListCell", for: indexPath as IndexPath)
        
        
        // let cellView : UIView = cell.viewWithTag(1)!
        
        //cellView.backgroundColor = UIColor.red
        // cellView.dropShadowWithBorder(borderWidth: 5, borderColor: .white, shadowColor: .clear, shadowRadius: 0, shadowOffset: CGSize.zero, shadowOpacity: 0)
        //  cellView.clipsToBounds = true
        // cell.backgroundColor = UIColor.red
        
        let companyLogoImageView : UIImageView = cell.viewWithTag(1) as! UIImageView
        companyLogoImageView.layer.cornerRadius = 16
        companyLogoImageView.backgroundColor = UIColor.white
        //companyLogoImageView.image = UIImage(named: companyDataDict[indexPath.item]["c_image"]!)
        companyLogoImageView.contentMode = .scaleAspectFit
        
        if indexPath.item == selectedIndexPath {
            cell.layer.cornerRadius = 16
            cell.dropShadowWithBorder(borderWidth: 0.2, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
        }
        else{
            cell.layer.cornerRadius = 0
            cell.dropShadowWithBorder(borderWidth: 0, borderColor: UIColor.clear.withAlphaComponent(0.0), shadowColor: UIColor.clear, shadowRadius: 0, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.0)
        }
        
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        selectedIndexPath  = indexPath.item
        companyListCollectionView.reloadData()
//        companyName_lbl.text = "Company Name : \(companyDataDict[indexPath.item]["c_name"] ?? "")"
//        companyAddress_lbl.text = "Company Address : \(companyDataDict[indexPath.item]["c_address"] ?? "")"
         companyName_lbl.text = "Company Name : \(supplierDataArray[indexPath.item]["display_name"] ?? "")"
        companyAddress_lbl.text = "Company Address : \(supplierDataArray[indexPath.item]["address"] ?? "")"
        let purchaseDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseDetailViewController")  as! PurchaseDetailViewController
        self.present(purchaseDetailVC, animated: true, completion: nil)
        getProductList(withIndex: indexPath.item)
        
    }
    
    func getProductList(withIndex: Int) {
        productDataArray = [[String:Any]]()
        if let tempArray = supplierDataArray[withIndex]["sale_products"] as? [[String: Any]]{
        print("PRODUCT COUNT == \(tempArray.count) ==== PRODUCT ARRAY ==== \(tempArray)")
        for i in 0..<tempArray.count {
            productDataArray.append(tempArray[i])
        }
        }
        productList_TableView.reloadData()
         print("PRODUCT COUNT == \(productDataArray.count)")
    }
    
    func getSuppliersAndProductList_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_SUPPLIERS_AND_PRODUCTS
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
            if let responseJSONs = responseJSON as? [[String: Any]] {
                print(responseJSONs)
                //
                for i in 0..<responseJSONs.count{
                    self.supplierDataArray.append(responseJSONs[i])
                }
                
                DispatchQueue.main.async {
                    print("ALL EMP LEAVE REQUEST = \(self.supplierDataArray)")
                    
                    self.companyListCollectionView.reloadData()
                    self.companyName_lbl.text = "Company Name : \(self.supplierDataArray[0]["display_name"] ?? "")"
                    self.companyAddress_lbl.text = "Company Address : \(self.supplierDataArray[0]["address"] ?? "")"
                    
                    self.getProductList(withIndex: 0)
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
