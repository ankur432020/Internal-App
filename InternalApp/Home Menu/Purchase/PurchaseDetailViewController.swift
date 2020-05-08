//
//  PurchaseDetailViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 19/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
class PurchaseDetailViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var purchaseAnalysis_View: UIView!
    
    @IBOutlet weak var purchaseMonitoring_View: UIView!
    
    @IBOutlet weak var purchaseMonitoring_DetailView: UIView!
    @IBOutlet weak var purchaseAnalysis_CollectionView: UICollectionView!
    @IBOutlet weak var purchaseReceipt_View: UIView!
    @IBOutlet weak var replenishmentRequest_View: UIView!
    
    @IBOutlet weak var purchareMonitoring_TotalSummaryView: UIView!
    
    @IBOutlet weak var purchaseMonitoring_CollectionView: UICollectionView!
    
    @IBOutlet weak var purchaseMonitoringDetail_CollectioView: UICollectionView!
    @IBOutlet weak var textF_modeOfPayment: UITextField!
    @IBOutlet weak var textView_itemSupplierAddress: UITextView!
    @IBOutlet weak var textF_itemSupplier: UITextField!
    @IBOutlet weak var textF_itemBatch: UITextField!
    @IBOutlet weak var textF_itemUnit: UITextField!
    @IBOutlet weak var textF_itemRequirement: UITextField!
    @IBOutlet weak var textF_itemCategory: UITextField!
    @IBOutlet weak var textF_itemType: UITextField!
    @IBOutlet weak var textF_itemName: UITextField!
    @IBOutlet weak var textF_itemCode: UITextField!
    
    @IBOutlet weak var purchareReceipt_CollectionView: UICollectionView!
    // DROPDOWS ---
    var dropDown_purchaseMonitoring = DropDown()
    var dropDown_purchaseReceipt = DropDown()
    
    
    // AnchorViews ---
    @IBOutlet weak var purchaseMonitoringFilterView: UIView!
    @IBOutlet weak var purchaseReceiptFilterView: UIView!
   
    //
    
    
    // CALENDAR
    fileprivate weak var calendar: FSCalendar!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    var btn_SelectDates = UIButton()
    var btn_OverLay = UIView()
    var checkIn_Date = ""
    var checkOut_Date = ""
    //
    
    @IBOutlet weak var btn_purchaseMonitoringDate: UIButton!
    var bgView = UIView()
    
    @IBOutlet weak var btn_purchaseMonitoringFilter: UIButton!
    
    @IBOutlet weak var btn_purchaseReceiptFilter: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        purchaseAnalysis_View.layer.cornerRadius = 8
         purchaseMonitoring_View.layer.cornerRadius = 8
         replenishmentRequest_View.layer.cornerRadius = 8
         purchaseReceipt_View.layer.cornerRadius = 8
        purchaseMonitoring_DetailView.layer.cornerRadius = 8
        purchaseAnalysis_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        purchaseMonitoring_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        purchaseMonitoring_DetailView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        replenishmentRequest_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        purchaseReceipt_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        purchareMonitoring_TotalSummaryView!.layer.cornerRadius = 10
        purchareMonitoring_TotalSummaryView!.layer.masksToBounds = true
       
        if #available(iOS 11.0, *) {
            purchareMonitoring_TotalSummaryView!.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        textF_itemCode.layer.borderWidth = 1
        textF_itemCode.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemCode.layer.cornerRadius = 10
        
        textF_itemName.layer.borderWidth = 1
        textF_itemName.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemName.layer.cornerRadius = 10
        
        textF_itemType.layer.borderWidth = 1
        textF_itemType.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemType.layer.cornerRadius = 10
        
        textF_itemCategory.layer.borderWidth = 1
        textF_itemCategory.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemCategory.layer.cornerRadius = 10
        
        textF_itemRequirement.layer.borderWidth = 1
        textF_itemRequirement.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemRequirement.layer.cornerRadius = 10
        
        textF_itemUnit.layer.borderWidth = 1
        textF_itemUnit.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemUnit.layer.cornerRadius = 10
        
        textF_itemBatch.layer.borderWidth = 1
        textF_itemBatch.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemBatch.layer.cornerRadius = 10
        
        textF_itemSupplier.layer.borderWidth = 1
        textF_itemSupplier.layer.borderColor = UIColor.lightGray.cgColor
        textF_itemSupplier.layer.cornerRadius = 16
        
        textF_modeOfPayment.layer.borderWidth = 1
        textF_modeOfPayment.layer.borderColor = UIColor.lightGray.cgColor
        textF_modeOfPayment.layer.cornerRadius = 10
        
        textView_itemSupplierAddress.layer.borderWidth = 1
        textView_itemSupplierAddress.layer.borderColor = UIColor.lightGray.cgColor
        textView_itemSupplierAddress.layer.cornerRadius = 10
        
        purchaseMonitoring_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                  forCellWithReuseIdentifier: "ContentCellIdentifier")
        purchareReceipt_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                   forCellWithReuseIdentifier: "ContentCellIdentifier")
        purchaseMonitoringDetail_CollectioView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                forCellWithReuseIdentifier: "ContentCellIdentifier")
        purchaseMonitoring_DetailView.isHidden = true
        setup_DropDowns_UI()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        

    }
    //MARK:- Method to close PopUpView
    @objc func closePopUpView(_ sender:UITapGestureRecognizer){
        firstDate = nil
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    func setup_DropDowns_UI(){
        
        dropDown_purchaseMonitoring.dataSource = ["Monitoring 1", "Monitoring 2", "Monitoring 3", "Monitoring 4", "Monitoring 5"]
        dropDown_purchaseMonitoring.anchorView = purchaseMonitoringFilterView
        dropDown_purchaseMonitoring.cornerRadius = 8
        dropDown_purchaseMonitoring.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_purchaseMonitoring.selectionBackgroundColor = UIColor.black
        dropDown_purchaseMonitoring.selectedTextColor = UIColor.yellow
        
        
        dropDown_purchaseReceipt.dataSource = ["Receipt 1", "Receipt 2", "Receipt 3", "Receipt 4", "Receipt 5"]
        dropDown_purchaseReceipt.anchorView = purchaseReceiptFilterView
        dropDown_purchaseReceipt.cornerRadius = 8
        dropDown_purchaseReceipt.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_purchaseReceipt.selectionBackgroundColor = UIColor.black
        dropDown_purchaseReceipt.selectedTextColor = UIColor.yellow
        
    }
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnAction_purchaseMonitoringFilter(_ sender: Any) {
                dropDown_purchaseMonitoring.show()
                dropDown_purchaseMonitoring.selectionAction = {
                    [weak self] (index, item) in
                    print(index, item)
                    self?.btn_purchaseMonitoringFilter.setTitle(item, for: .normal)
                }
    }
    @IBAction func btnAction_purchaseMonitoringDateFilter(_ sender: Any) {
        openCalender()
    }
    
    @IBAction func btnAction_purchaseReceiptFilter(_ sender: Any) {
        dropDown_purchaseReceipt.show()
        dropDown_purchaseReceipt.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_purchaseReceiptFilter.setTitle(item, for: .normal)
        }
    }
    func openCalender() {
        bgView.isHidden = false
        btn_OverLay.isHidden = false
        btn_SelectDates.isHidden = false
        let calendar = FSCalendar(frame: CGRect(x: 20, y: self.view.frame.size.height / 3, width: self.view.frame.size.width - 40, height: 300))
        
        btn_OverLay.frame = CGRect(x: 20, y: calendar.frame.origin.y + calendar.frame.size.height - 10, width: self.view.frame.size.width - 40, height: 80)
        btn_OverLay.backgroundColor = UIColor.white
        btn_OverLay.layer.cornerRadius = 10
        btn_SelectDates.frame = CGRect(x: (self.view.frame.size.width - 200) / 2, y: calendar.frame.origin.y + calendar.frame.size.height + 15, width: 200, height: 40)
        
        btn_SelectDates.backgroundColor = UIColor.black
        btn_SelectDates.setTitle("Select Dates", for: .normal)
        btn_SelectDates.layer.cornerRadius = 10
        calendar.backgroundColor = UIColor.white
        calendar.allowsMultipleSelection = true
        
        //calendar.today = calendar.minimumDate
        calendar.layer.cornerRadius = 10
        calendar.dataSource = self
        calendar.delegate = self
        self.view.addSubview(bgView)
        view.addSubview(calendar)
        
        view.addSubview(btn_OverLay)
        view.addSubview(btn_SelectDates)
        self.calendar = calendar
        btn_SelectDates.addTarget(self, action: #selector(getAndSetDates), for: .touchUpInside)
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            
            print("datesRange contains: \(datesRange!)")
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    //    func minimumDate(for calendar: FSCalendar) -> Date {
    //        let gregorian = Calendar(identifier: .gregorian)
    //        var comps = DateComponents()
    //        comps.month = 1
    //        comps.month = 0
    //        comps.day = 1
    //        let minDate = gregorian.date(byAdding: comps, to: Date())
    //        return minDate!//Date()
    //    }
    @objc  func getAndSetDates() {
        print("PREVIOUS START DATE = \(firstDate ?? Date())")
        print("PREVIOUS LAST DATE = \(lastDate ?? Date())")
        
        if firstDate != nil && lastDate != nil{
            let dateFormatterGET = DateFormatter()
            
            dateFormatterGET.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateFormatterSET = DateFormatter()
            dateFormatterSET.dateFormat = "dd-MM-yyyy"
            let newStartDate = dateFormatterSET.string(from: firstDate!)
            let newEndDate = dateFormatterSET.string(from: lastDate!)
            print("CURRENT START DATE = \(newStartDate)")
            print("CURRENT END DATE = \(newEndDate)")
            checkIn_Date = newStartDate
            checkOut_Date = newEndDate
           
           
                btn_purchaseMonitoringDate.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
            
            closeCalendar()
        }
        else{
            if firstDate != nil && lastDate == nil {
                self.view.makeToast("Please, Select end date.")
            }
            if lastDate != nil && firstDate == nil {
                self.view.makeToast("Please, Select start date.")
            }
            checkIn_Date = ""
            checkOut_Date = ""
        }
        //2020-02-21
    }
    func closeCalendar() {
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    /*
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
     switch collectionView {
     case abnormalSales_TabMenu_CollectionView:
     return 4
     case abnormalSalesData_CollectionView:
     return 8
     default:
     return 0
     }
     }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
     switch collectionView {
     case abnormalSales_TabMenu_CollectionView:
     return 1
     case abnormalSalesData_CollectionView:
     return 50
     default:
     return 0
     }
     //return 50
     }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     switch collectionView {
     case abnormalSales_TabMenu_CollectionView:
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath as IndexPath)
     let tab_lbl : UILabel = cell.viewWithTag(1) as! UILabel
     if indexPath.item == selectedTabIndex {
     tab_lbl.backgroundColor = UIColor.black
     }
     else{
     tab_lbl.backgroundColor = UIColor.lightGray
     }
     tab_lbl.text = abnormalSalesTabsArray[indexPath.item]
     
     return cell
     
     case abnormalSalesData_CollectionView:
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
     for: indexPath) as! ContentCollectionViewCell
     
     //                if indexPath.section % 2 != 0 {
     //                    cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
     //                } else {
     cell.backgroundColor = UIColor.white
     // }
     
     if indexPath.section == 0 {
     if indexPath.row == 0 {
     cell.contentLabel.text = "No."
     } else {
     if indexPath.row == 0
     {
     
     }
     else{
     cell.contentLabel.text = abnormalSalesDataArray[indexPath.row]
     }
     }
     } else {
     if indexPath.row == 0 {
     cell.contentLabel.text = String(indexPath.section)
     } else {
     cell.contentLabel.text = "DATA"
     cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
     }
     }
     
     return cell
     default:
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath as IndexPath)
     
     
     return cell
     }
     
     
     
     
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     // handle tap events
     print("You selected cell #\(indexPath.item)!")
     switch collectionView {
     case abnormalSales_TabMenu_CollectionView:
     selectedTabIndex = indexPath.item
     abnormalSales_TabMenu_CollectionView.reloadData()
     default:
     abnormalSales_TabMenu_CollectionView.reloadData()
     }
     
     }
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case purchaseAnalysis_CollectionView:
            return 5
        case purchaseMonitoring_CollectionView:
            return 8
        case purchareReceipt_CollectionView:
            return 8
        case purchaseMonitoringDetail_CollectioView:
            return 10
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case purchaseAnalysis_CollectionView:
            return 1
            case purchaseMonitoring_CollectionView:
            return 50
        case purchareReceipt_CollectionView:
            return 50
        case purchaseMonitoringDetail_CollectioView:
            return 30
        default:
            return 0
        }
        //return 50
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case purchaseAnalysis_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "purchaseAnalysisCell", for: indexPath as IndexPath)
            
            
            let cellView : UIView = cell.viewWithTag(1)!
            
            cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            
            return cell
        case purchaseMonitoring_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            //                if indexPath.section % 2 != 0 {
            //                    cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            //                } else {
            cell.backgroundColor = UIColor.white
            // }
            cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.contentLabel.text = "No."
                } else {
                    if indexPath.row == 0
                    {
                        
                    }
                    else{
                        cell.contentLabel.text = "Test Data"
                    }
                }
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                } else {
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                }
            }
            
            return cell
        case purchareReceipt_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            //                if indexPath.section % 2 != 0 {
            //                    cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            //                } else {
            cell.backgroundColor = UIColor.white
            // }
            cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.contentLabel.text = "No."
                } else {
                    if indexPath.row == 0
                    {
                        
                    }
                    else{
                        cell.contentLabel.text = "Test Data"
                    }
                }
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                } else {
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                }
            }
            
            return cell
        case purchaseMonitoringDetail_CollectioView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            //                if indexPath.section % 2 != 0 {
            //                    cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            //                } else {
            cell.backgroundColor = UIColor.white
            // }
            cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.contentLabel.text = "No."
                } else {
                    if indexPath.row == 0
                    {
                        
                    }
                    else{
                        cell.contentLabel.text = "Test Data"
                    }
                }
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                } else {
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                }
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "purchaseAnalysisCell", for: indexPath as IndexPath)
            
            
           
            
            
            return cell
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        switch collectionView {
        case purchaseMonitoring_CollectionView:
            purchaseMonitoring_DetailView.isHidden = false
        default:
            print("You selected cell #\(indexPath.item)!")
        }
    }
    
    @IBAction func btnAction_Close_PurchaseMonitoringDetailView(_ sender: Any) {
        purchaseMonitoring_DetailView.isHidden = true
    }
}
