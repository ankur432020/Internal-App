//
//  ManufactureProductDetailsViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 08/05/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class ManufactureProductDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var productDetailView: UIView!
    
    @IBOutlet weak var productMenuTableView: UITableView!
    
    
    @IBOutlet weak var productListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productDetailView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case productMenuTableView:
            return 5
        case productListTableView:
            return 10
        default:
            return 0
        }
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case productMenuTableView:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "productMenuCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            
            
           /* let cellView: UIView = cell.viewWithTag(1)!
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
            }*/
            return cell
        case productListTableView:
            
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "productListCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            /*let productImageView : UIImageView = cell.viewWithTag(1) as! UIImageView
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
            
            decreaseValue_Btn.addTarget(self, action: #selector(decreasedValue), for: .touchUpInside)*/
            
            return cell
            
        default:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "productListCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            
            
            
            
            return cell
        }
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
       /* switch  tableView{
        case productMenuTableView:
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
        }*/
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case productMenuTableView:
            return 100
        case productListTableView:
            return 120
        default:
            return 0
        }
    }
    

}
