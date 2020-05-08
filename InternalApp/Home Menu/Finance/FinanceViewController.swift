//
//  FinanceViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 24/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
class FinanceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , FSCalendarDelegate, FSCalendarDataSource{

    @IBOutlet weak var application_View: UIView!
    
    
    @IBOutlet weak var totalBill_CollectionView: UICollectionView!
    @IBOutlet weak var invoicing_CollectionView: UICollectionView!
    @IBOutlet weak var invoicing_View: UIView!
    
    @IBOutlet weak var applicationFess_CollectionView: UICollectionView!
    @IBOutlet weak var billing_View: UIView!
    
    @IBOutlet weak var btn_EmployeeFees: UIButton!
    
    @IBOutlet weak var btn_StoreFees: UIButton!
    var applicationFeeTabArray = [String]()
    
    @IBOutlet weak var createA_Bill_View: UIView!
    
    var storeTabArray = [String]()
    
    @IBOutlet weak var totalBillSummary_View: UIView!
    @IBOutlet weak var bill_ButtonAction_SegmentView: UIView!
    @IBOutlet weak var productDescription_View: UIView!
    
    
    @IBOutlet weak var textF_vendor: UITextField!
    
    @IBOutlet weak var textF_vendorRef: UITextField!
    
    @IBOutlet weak var textF_bankAccount: UITextField!
    @IBOutlet weak var textF_currency: UITextField!
    @IBOutlet weak var textF_dueDate: UITextField!
    @IBOutlet weak var textF_billDate: UITextField!
    @IBOutlet weak var textF_sourceDoc: UITextField!
    
    
    @IBOutlet weak var totalBill_View: UIView!
    
    @IBOutlet weak var textF_amount: UITextField!
    @IBOutlet weak var textF_taxes: UITextField!
    @IBOutlet weak var textF_unitPrice: UITextField!
    @IBOutlet weak var textF_quantity: UITextField!
    @IBOutlet weak var textF_unitOfMeasure: UITextField!
    @IBOutlet weak var textF_Account: UITextField!
    @IBOutlet weak var textF_assetCategory: UITextField!
    @IBOutlet weak var textF_product: UITextField!
    var totalBillTabArray = ["Product", "Description", "Asset Category", "Account", "Qty.", "Unit", "Unit Price", "Taxes", "Total"]
    var totalBillDataArray = ["Product A", "Meat product", "-", "Sample Text", "1.", "Kg", "$2000", "$0", "$2000"]
    
    @IBOutlet weak var texftF_productDescp: UITextField!
    
    
    @IBOutlet weak var totalAmount_lbl: UILabel!
    @IBOutlet weak var taxes_lbl: UILabel!
    @IBOutlet weak var untaxedAmount_lbl: UILabel!
    
    
    @IBOutlet weak var invoiceDetail_BG_View: UIView!
    
    @IBOutlet weak var invoiceDetail_View: UIView!
    
    @IBOutlet weak var invoiceNumber_lbl: UILabel!
    
    @IBOutlet weak var inv_CustomerName_lbl: UILabel!
    
    @IBOutlet weak var inv_SalesTeam_lbl: UILabel!
    
    @IBOutlet weak var inv_TotalBill_View: UIView!
    @IBOutlet weak var inv_Bill_CollectionView: UICollectionView!
    @IBOutlet weak var inv_BillSummary_View: UIView!
    @IBOutlet weak var inv_DueDate_lbl: UILabel!
    @IBOutlet weak var inv_Date_lbl: UILabel!
    @IBOutlet weak var inv_Journal_lbl: UILabel!
    @IBOutlet weak var inv_Currency_lbl: UILabel!
    
    @IBOutlet weak var inv_UntaxedAmount_lbl: UILabel!
    
    @IBOutlet weak var inv_TotalAmount_lbl: UILabel!
    @IBOutlet weak var inv_Taxes_lbl: UILabel!
    
    // DROPDOWS ---
    var dropDown_applicationFee = DropDown()
    var dropDown_invoicing = DropDown()
    
    
    // AnchorViews ---
    @IBOutlet weak var applicationFeeFilterView: UIView!
    @IBOutlet weak var invoicingFilterView: UIView!
    
    @IBOutlet weak var btn_applicationFee_Filter: UIButton!
    
    
    @IBOutlet weak var btn_invoicing_Filter: UIButton!
    
    @IBOutlet weak var btn_invoicingDate_Filter: UIButton!
    
    //CALENDER
    fileprivate weak var calendar: FSCalendar!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    var btn_SelectDates = UIButton()
    var bgView = UIView()
    var btn_OverLay = UIView()
    var checkIn_Date = ""
    var checkOut_Date = ""
    //
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        application_View.layer.cornerRadius = 8
        application_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        invoicing_View.layer.cornerRadius = 8
        invoicing_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        billing_View.layer.cornerRadius = 8
        billing_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        totalBill_View.layer.cornerRadius = 8
        totalBill_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        inv_TotalBill_View.layer.cornerRadius = 8
        inv_TotalBill_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        productDescription_View.layer.cornerRadius = 8
        productDescription_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        
        
        btn_StoreFees.isSelected = true
        btn_StoreFees.backgroundColor = UIColor.black
        btn_EmployeeFees.isSelected = false
        btn_EmployeeFees.backgroundColor = UIColor.lightGray
        applicationFeeTabArray = ["No.", "Store Name", "Store Id", "Store Address", "Store Fee", "Store Manager", "Store Capacity"]
        applicationFess_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "ContentCellIdentifier")
        totalBill_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                forCellWithReuseIdentifier: "ContentCellIdentifier")
        
        inv_Bill_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "ContentCellIdentifier")
        
        textF_vendor.layer.borderWidth = 1
        textF_vendor.layer.borderColor = UIColor.lightGray.cgColor
        textF_vendor.layer.cornerRadius = 10
        
        textF_vendorRef.layer.borderWidth = 1
        textF_vendorRef.layer.borderColor = UIColor.lightGray.cgColor
        textF_vendorRef.layer.cornerRadius = 10
        
        textF_sourceDoc.layer.borderWidth = 1
        textF_sourceDoc.layer.borderColor = UIColor.lightGray.cgColor
        textF_sourceDoc.layer.cornerRadius = 10
        
        textF_billDate.layer.borderWidth = 1
        textF_billDate.layer.borderColor = UIColor.lightGray.cgColor
        textF_billDate.layer.cornerRadius = 10
        
        textF_dueDate.layer.borderWidth = 1
        textF_dueDate.layer.borderColor = UIColor.lightGray.cgColor
        textF_dueDate.layer.cornerRadius = 10
        
        textF_currency.layer.borderWidth = 1
        textF_currency.layer.borderColor = UIColor.lightGray.cgColor
        textF_currency.layer.cornerRadius = 10
        
        textF_bankAccount.layer.borderWidth = 1
        textF_bankAccount.layer.borderColor = UIColor.lightGray.cgColor
        textF_bankAccount.layer.cornerRadius = 10
        
        textF_product.layer.borderWidth = 1
        textF_product.layer.borderColor = UIColor.lightGray.cgColor
        textF_product.layer.cornerRadius = 10
        
        texftF_productDescp.layer.borderWidth = 1
        texftF_productDescp.layer.borderColor = UIColor.lightGray.cgColor
        texftF_productDescp.layer.cornerRadius = 10
        
        textF_assetCategory.layer.borderWidth = 1
        textF_assetCategory.layer.borderColor = UIColor.lightGray.cgColor
        textF_assetCategory.layer.cornerRadius = 10
        
        textF_Account.layer.borderWidth = 1
        textF_Account.layer.borderColor = UIColor.lightGray.cgColor
        textF_Account.layer.cornerRadius = 10
        
        textF_quantity.layer.borderWidth = 1
        textF_quantity.layer.borderColor = UIColor.lightGray.cgColor
        textF_quantity.layer.cornerRadius = 10
        
        textF_unitOfMeasure.layer.borderWidth = 1
        textF_unitOfMeasure.layer.borderColor = UIColor.lightGray.cgColor
        textF_unitOfMeasure.layer.cornerRadius = 10
        
        textF_unitPrice.layer.borderWidth = 1
        textF_unitPrice.layer.borderColor = UIColor.lightGray.cgColor
        textF_unitPrice.layer.cornerRadius = 10
        
        textF_taxes.layer.borderWidth = 1
        textF_taxes.layer.borderColor = UIColor.lightGray.cgColor
        textF_taxes.layer.cornerRadius = 10
        
        textF_amount.layer.borderWidth = 1
        textF_amount.layer.borderColor = UIColor.lightGray.cgColor
        textF_amount.layer.cornerRadius = 10
        
        untaxedAmount_lbl.text = "$2000"
        taxes_lbl.text = "$20"
        totalAmount_lbl.text = "$2020"
        
        invoiceDetail_BG_View.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        invoiceDetail_BG_View.isHidden = true
        invoiceDetail_BG_View.layer.cornerRadius = 8
        
        invoiceDetail_View.layer.cornerRadius = 8
        
        inv_CustomerName_lbl.text = "Helen Tommy"
        inv_SalesTeam_lbl.text = "Sales"
        inv_Currency_lbl.text = "CNY"
        inv_Journal_lbl.text = "CNY"
        inv_Date_lbl.text = "25/03/2020"
        inv_DueDate_lbl.text = "27/03/2020"
        inv_UntaxedAmount_lbl.text = "$2000"
        inv_Taxes_lbl.text = "$20"
        inv_TotalAmount_lbl.text = "$2020"
        
        setup_DropDowns_UI()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
    }
    

    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setup_DropDowns_UI(){
        
        dropDown_applicationFee.dataSource = ["Application Fee 1", "Application Fee 2", "Application Fee 3", "Application Fee 4", "Application Fee 5"]
        dropDown_applicationFee.anchorView = applicationFeeFilterView
        dropDown_applicationFee.cornerRadius = 8
        dropDown_applicationFee.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_applicationFee.selectionBackgroundColor = UIColor.black
        dropDown_applicationFee.selectedTextColor = UIColor.yellow
        
        
        dropDown_invoicing.dataSource = ["Invoicing 1", "Invoicing 2", "Invoicing 3", "Invoicing 4", "Invoicing 5"]
        dropDown_invoicing.anchorView = invoicingFilterView
        dropDown_invoicing.cornerRadius = 8
        dropDown_invoicing.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_invoicing.selectionBackgroundColor = UIColor.black
        dropDown_invoicing.selectedTextColor = UIColor.yellow
        
    }
    @IBAction func btnAction_EmployeeFess(_ sender: Any) {
        btn_StoreFees.isSelected = false
        btn_StoreFees.backgroundColor = UIColor.lightGray
        btn_EmployeeFees.isSelected = true
        btn_EmployeeFees.backgroundColor = UIColor.black
        applicationFeeTabArray = ["No.", "Employee Name", "Employee Id", "Employee Address", "Employee Fee", "Employee Manager", "Employee Capacity"]
        applicationFess_CollectionView.reloadData()
    
    }
    
    @IBAction func btnAction_StoreFees(_ sender: Any) {
        btn_StoreFees.isSelected = true
        btn_StoreFees.backgroundColor = UIColor.black
        btn_EmployeeFees.isSelected = false
        btn_EmployeeFees.backgroundColor = UIColor.lightGray
        applicationFeeTabArray = ["No.", "Store Name", "Store Id", "Store Address", "Store Fee", "Store Manager", "Store Capacity"]
        applicationFess_CollectionView.reloadData()
        
    }
    
    @IBAction func btnAction_applicationFeeFilter(_ sender: Any) {
        dropDown_applicationFee.show()
        dropDown_applicationFee.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_applicationFee_Filter.setTitle(item, for: .normal)
        }
    }
    @IBAction func btnAction_Close_InvoiceDetailView(_ sender: Any) {
         invoiceDetail_BG_View.isHidden = true
    }
    
    @IBAction func btnAction_invoicingFilter(_ sender: Any) {
        dropDown_invoicing.show()
        dropDown_invoicing.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_invoicing_Filter.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnAction_invoicingDateFilter(_ sender: Any) {
        btn_SelectDates.tag = 1
        openCalender()
    }
    
    @IBAction func btnAction_BillDate(_ sender: Any) {
        textF_dueDate.text = ""
        btn_SelectDates.tag = 2
        openCalender()
    }
    
    @IBAction func btnAction_DueDate(_ sender: Any) {
        if textF_billDate.text!.isEmpty {
            self.view.makeToast("Please Select Bill Date")
        }
        else{
        btn_SelectDates.tag = 3
        openCalender()
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
        if btn_SelectDates.tag == 2 {
            calendar.allowsMultipleSelection = false
        }
        else if btn_SelectDates.tag == 3
        {
            calendar.allowsMultipleSelection = false
           
        }
        else
        {
            calendar.allowsMultipleSelection = true
        }
        
        
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
        func minimumDate(for calendar: FSCalendar) -> Date {
            print("get tag == > \(btn_SelectDates.tag) === \(FSCalendar.self)")
            if btn_SelectDates.tag == 3 {
                let gregorian = Calendar(identifier: .gregorian)
                var comps = DateComponents()
                comps.month = 1
                comps.month = 0
                comps.day = 0
                let minDate = gregorian.date(byAdding: comps, to: firstDate!)
                return minDate!
            }
            else{
           return self.dateFormatter.date(from: "1989-01-01")!// for example
            }
        }
    @objc  func getAndSetDates(sender:UIButton) {
        print("PREVIOUS START DATE = \(firstDate ?? Date())")
        print("PREVIOUS LAST DATE = \(lastDate ?? Date())")
        if sender.tag == 2 {
            if firstDate != nil{
                let dateFormatterGET = DateFormatter()
                
                dateFormatterGET.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatterSET = DateFormatter()
                //dateFormatterSET.dateFormat = "yyyy-MM-dd"
                dateFormatterSET.dateFormat = "dd-MM-yyyy"
                let newStartDate = dateFormatterSET.string(from: firstDate!)
                
                print("CURRENT START DATE = \(newStartDate)")
                
                checkIn_Date = newStartDate
                
                textF_billDate.text = "\(checkIn_Date)"
                
                closeCalendar()
            }
            else{
                self.view.makeToast("Please select date.")
                checkIn_Date = ""
            }
        }
        else if sender.tag == 3 {
            if lastDate != nil{
                let dateFormatterGET = DateFormatter()
                
                dateFormatterGET.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatterSET = DateFormatter()
                //dateFormatterSET.dateFormat = "yyyy-MM-dd"
                dateFormatterSET.dateFormat = "dd-MM-yyyy"
                let newStartDate = dateFormatterSET.string(from: lastDate!)
                
                print("CURRENT START DATE = \(newStartDate)")
                
                checkIn_Date = newStartDate
                
                
                textF_dueDate.text = "\(checkIn_Date)"
                closeCalendar()
            }
            else{
                self.view.makeToast("Please select date.")
                checkIn_Date = ""
            }
        }
        else{
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
                print(sender.tag)
                if sender.tag == 1
                {
                    btn_invoicingDate_Filter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
                }
                
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
        }
        //2020-02-21
    }
    func closeCalendar() {
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    //MARK:- Method to close PopUpView
    @objc func closePopUpView(_ sender:UITapGestureRecognizer){
        firstDate = nil
        lastDate = nil
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case applicationFess_CollectionView:
       return 20
        case invoicing_CollectionView:
        return 1
        case totalBill_CollectionView:
            return 6
        case inv_Bill_CollectionView:
            return 6
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case applicationFess_CollectionView:
            return 7
        case invoicing_CollectionView:
            return 10
        case totalBill_CollectionView:
        return 9
        case inv_Bill_CollectionView:
            return 9
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case applicationFess_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
    
            cell.backgroundColor = UIColor.white
    
                cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
            
            if indexPath.section == 0 {
           
                cell.contentLabel.text = applicationFeeTabArray[indexPath.row]
               
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                
                } else {
                    
                   
                       
                        cell.contentLabel.text = "DATA"
                        cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                 
                    
                }
            }
            
            return cell
        case invoicing_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "invoicingCell", for: indexPath as IndexPath)
            
            let cellView : UIView = cell.viewWithTag(1)!
            
           
            cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.1), shadowColor: UIColor.lightGray, shadowRadius: 3, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            return cell
        case totalBill_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            
            cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
           
            if indexPath.section == 0 {
                
                cell.contentLabel.text = totalBillTabArray[indexPath.row]
                
                
            } else {
//                if indexPath.row == 0 {
//                    cell.contentLabel.text = String(indexPath.section)
//                    
//                } else {
                    
                    
                    
                    cell.contentLabel.text = totalBillDataArray[indexPath.row]//"DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    
              //  }
            }
            
            return cell
        case inv_Bill_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            
            cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
            
            if indexPath.section == 0 {
                
                cell.contentLabel.text = totalBillTabArray[indexPath.row]
                
                
            } else {
                //                if indexPath.row == 0 {
                //                    cell.contentLabel.text = String(indexPath.section)
                //
                //                } else {
                
                
                
                cell.contentLabel.text = totalBillDataArray[indexPath.row]//"DATA"
                cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                
                
                //  }
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier", for: indexPath as IndexPath)
            
            
            
            return cell
        }
        
        
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        print("SECTION == \(indexPath.section)")
        //employeeDetail_View.isHidden = false
        switch collectionView {
        case applicationFess_CollectionView:
            print("You selected cell #\(indexPath.item)!")
        case invoicing_CollectionView:
             invoiceDetail_BG_View.isHidden = false
        default:
           print("You selected cell #\(indexPath.item)!")
        }
        
    }

}
