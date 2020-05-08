//
//  HRViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 21/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
import AFNetworking
class HRViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource, UITextFieldDelegate{

   // @IBOutlet weak var workSchedule_TableView: UITableView!
    @IBOutlet weak var workScheduling_View: UIView!
    
    @IBOutlet weak var workSchedule_CollectionView: UICollectionView!
    @IBOutlet weak var userDetailStatusBG_View: UIView!
    @IBOutlet weak var userDetailStatus_View: UIView!
    @IBOutlet weak var userDetail_ImageView: UIImageView!
    @IBOutlet weak var employeeDetail_View: UIView!
    @IBOutlet weak var taskManagement_View: UIView!
    @IBOutlet weak var leaveManagement_View: UIView!
    
    
    @IBOutlet weak var btn_EditAndSaveProfile: UIButton!
    
    @IBOutlet weak var employeeName_lbl: UILabel!
    
    
    @IBOutlet weak var textF_empNumber: UITextField!
    @IBOutlet weak var textF_empEmail: UITextField!
    @IBOutlet weak var textF_empCurrentStatus: UITextField!
    @IBOutlet weak var textF_empTimeRange: UITextField!
    @IBOutlet weak var textF_empShift: UITextField!
    @IBOutlet weak var textF_empDesignation: UITextField!
    
    var isEdit = false
    var mobileNumberLimit = 12
    var departmentArray = [String]()
    
    @IBOutlet weak var btn_leaveApplicationForm: UIButton!
    
    @IBOutlet weak var btn_leaveRequests: UIButton!
    
    @IBOutlet weak var leaveApplicationForm_View: UIView!
    
    @IBOutlet weak var leaveRequests_View: UIView!
    
    @IBOutlet weak var textF_leaveFromDate: UITextField!
    
    @IBOutlet weak var textF_natureOfLeave: UITextField!
    @IBOutlet weak var textF_teamMail_Id: UITextField!
    @IBOutlet weak var textView_reasonForLeave: UITextView!
    @IBOutlet weak var textF_leaveToDate: UITextField!
    @IBOutlet weak var textF_leaveType: UITextField!
    @IBOutlet weak var textF_empID: UITextField!
    
    @IBOutlet weak var leaveRequests_CollectionView: UICollectionView!
    var leaveRequestTabArray = [String]()
    
    
    @IBOutlet weak var taskManagement_CollectionView: UICollectionView!
    var taskManegementTabArray = [String]()
    var leaveTypeDisplayNameArray = [String]()
    var leaveTypeIdArray = [Int]()
    var selectedLeaveTypeId = 0
    var numberOfDays = 0
    
    // DROPDOWS ---
    var dropDown_leaveRequest = DropDown()
     var dropDown_taskManagement = DropDown()
//    var dropDownShift = DropDown()
//    var dropDownStatus = DropDown()
    var dropDownLeaveType = DropDown()
    
    
    
    // AnchorViews ---
    @IBOutlet weak var leaveRequestFilterView: UIView!
    @IBOutlet weak var taskManagementFilterView: UIView!
    
    
    @IBOutlet weak var btn_taskMgt_Filter: UIButton!
    
    @IBOutlet weak var btn_leaveReq_DateFilter: UIButton!
    @IBOutlet weak var btn_leaveReq_Filter: UIButton!
    @IBOutlet weak var btn_taskMgt_DateFilter: UIButton!
    
    
  
    
    
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
    let dateTimePicker: UIDatePicker = UIDatePicker()
    var toolBar = UIToolbar()
    
    var allEmployee_DataArray = [[String:Any]]()
    var allEmployee_LeaveDataArray = [[String:Any]]()
    var leaveTypeArray = [[String:Any]]()
    var selectedEmployeeId = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        workScheduling_View.layer.cornerRadius = 8
        employeeDetail_View.layer.cornerRadius = 8
        workScheduling_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        taskManagement_View.layer.cornerRadius = 8
        taskManagement_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        leaveManagement_View.layer.cornerRadius = 8
        leaveManagement_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        btn_EditAndSaveProfile.tintColor = UIColor.white
        update_UserProfileView()
        userDetail_ImageView.layer.cornerRadius = userDetail_ImageView.frame.size.width / 2
        userDetail_ImageView.layer.borderColor = UIColor.green.cgColor
        userDetail_ImageView.layer.borderWidth = 6
        userDetailStatus_View.layer.cornerRadius = userDetailStatus_View.frame.size.width / 2
        userDetailStatusBG_View.layer.cornerRadius = userDetailStatusBG_View.frame.size.width / 2
        userDetailStatus_View.backgroundColor = UIColor.green
        employeeDetail_View.isHidden = true
        
       
       
        textF_empShift.isUserInteractionEnabled = false
        textF_empCurrentStatus.isUserInteractionEnabled = false
        textF_empDesignation.isUserInteractionEnabled = false
        textF_empTimeRange.isUserInteractionEnabled = false
        textF_empNumber.delegate = self
        textF_empID.delegate = self
        
        departmentArray = ["Account Panel", "HR Panel", "Project Manager Panel", "Mobile Panel", "Web Panel", "Design Panel"]
        leaveRequestTabArray = ["Employee Id",  "Employee Name", "Lead Name", "Starting Date", "Ending Date", "No. of Days", "Reason", "Status"]
        taskManegementTabArray = ["Task Id",  "Task Description", "Starting Date", "Ending Date", "Batch", "Leader", "Employee", "Status" , "Priority"]
        btn_leaveApplicationForm.isSelected = true
        btn_leaveApplicationForm.backgroundColor = UIColor.black
        btn_leaveRequests.isSelected = false
        btn_leaveRequests.backgroundColor = UIColor.lightGray
   leaveApplicationForm_View.isHidden = false
        leaveRequests_View.isHidden = true
        
        textF_empID.layer.borderWidth = 1
        textF_empID.layer.borderColor = UIColor.lightGray.cgColor
        textF_empID.layer.cornerRadius = 10
        textF_empID.setLeftPaddingPoints(20)
        
        textF_leaveType.layer.borderWidth = 1
        textF_leaveType.layer.borderColor = UIColor.lightGray.cgColor
        textF_leaveType.layer.cornerRadius = 10
        textF_leaveType.setLeftPaddingPoints(20)
        textF_leaveType.isUserInteractionEnabled = false
        
        textF_leaveFromDate.layer.borderWidth = 1
        textF_leaveFromDate.layer.borderColor = UIColor.lightGray.cgColor
        textF_leaveFromDate.layer.cornerRadius = 10
        textF_leaveFromDate.isUserInteractionEnabled = false
        textF_leaveFromDate.setLeftPaddingPoints(20)
        
        
        textF_leaveToDate.layer.borderWidth = 1
        textF_leaveToDate.layer.borderColor = UIColor.lightGray.cgColor
        textF_leaveToDate.layer.cornerRadius = 10
        textF_leaveToDate.isUserInteractionEnabled = false
        textF_leaveToDate.setLeftPaddingPoints(20)
        
        textF_teamMail_Id.layer.borderWidth = 1
        textF_teamMail_Id.layer.borderColor = UIColor.lightGray.cgColor
        textF_teamMail_Id.layer.cornerRadius = 10
        textF_teamMail_Id.setLeftPaddingPoints(20)
        
        textView_reasonForLeave.layer.borderWidth = 1
        textView_reasonForLeave.layer.borderColor = UIColor.lightGray.cgColor
        textView_reasonForLeave.layer.cornerRadius = 10
        
        
        textF_natureOfLeave.layer.borderWidth = 1
        textF_natureOfLeave.layer.borderColor = UIColor.lightGray.cgColor
        textF_natureOfLeave.layer.cornerRadius = 10
        textF_natureOfLeave.setLeftPaddingPoints(20)
        textF_natureOfLeave.isUserInteractionEnabled = false
        textView_reasonForLeave.text = ""
        
        leaveRequests_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                forCellWithReuseIdentifier: "ContentCellIdentifier")
        taskManagement_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                              forCellWithReuseIdentifier: "ContentCellIdentifier")
        setup_DropDowns_UI()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        
        //createToolbar()
        getAll_Employee_Method()
        getLeaveType_method()
        getLeaveList()
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       /* if  textField == textF_empNumber {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        if textField == textF_empNumber {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= mobileNumberLimit
        }
       
            return true*/
        if textField == textF_empNumber {
            let allowedCharacters = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            let Range = range.length + range.location > (textF_empNumber.text?.count)!
            
            if Range == false && alphabet == false {
                return false
            }
            
            
            let NewLength = (textF_empNumber.text?.count)! + string.count - range.length
            return NewLength <= mobileNumberLimit
            
            
        }
        else if textField == textF_empID
        {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        else {
            return false
        }
        
    }
    
    func setup_DropDowns_UI(){
        
        dropDown_leaveRequest.dataSource = ["Leave Request 1", "Leave Request 2", "Leave Request 3", "Leave Request 4", "Leave Request 5"]
        dropDown_leaveRequest.anchorView = leaveRequestFilterView
        dropDown_leaveRequest.cornerRadius = 8
        dropDown_leaveRequest.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_leaveRequest.selectionBackgroundColor = UIColor.black
        dropDown_leaveRequest.selectedTextColor = UIColor.yellow
        
        
        dropDown_taskManagement.dataSource = ["Task Mgt 1", "Task Mgt 2", "Task Mgt 3", "Task Mgt 4", "Task Mgt 5"]
        dropDown_taskManagement.anchorView = taskManagementFilterView
        dropDown_taskManagement.cornerRadius = 8
        dropDown_taskManagement.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_taskManagement.selectionBackgroundColor = UIColor.black
        dropDown_taskManagement.selectedTextColor = UIColor.yellow
        
        
        
//        dropDownShift.dataSource = ["Morning Shift", "Night Shift"]
//        dropDownShift.anchorView = textF_empTimeRange
//        dropDownShift.cornerRadius = 8
//        dropDownShift.textFont = UIFont.systemFont(ofSize: 17)
//        dropDownShift.selectionBackgroundColor = UIColor.black
//        dropDownShift.selectedTextColor = UIColor.yellow
        
        
//        dropDownStatus.dataSource = ["In", "Out"]
//        dropDownStatus.anchorView = textF_empEmail
//        dropDownStatus.cornerRadius = 8
//        dropDownStatus.textFont = UIFont.systemFont(ofSize: 17)
//        dropDownStatus.selectionBackgroundColor = UIColor.black
//        dropDownStatus.selectedTextColor = UIColor.yellow
        
        
        dropDownLeaveType.anchorView = textF_leaveFromDate
        dropDownLeaveType.cornerRadius = 8
        dropDownLeaveType.textFont = UIFont.systemFont(ofSize: 17)
        dropDownLeaveType.selectionBackgroundColor = UIColor.black
        dropDownLeaveType.selectedTextColor = UIColor.yellow
        
    }
    @IBAction func btnAction_EditAndSave_EmpProfile(_ sender: Any) {
        if !isEdit == true {
            isEdit = true
            btn_EditAndSaveProfile.setTitle("Save", for: .normal)
            update_UserProfileView()
            textF_empEmail.becomeFirstResponder()
        }
        else
        {
            validateForm()
        }
        
        
    }
    func validateForm() {
         if textF_empEmail.text!.isEmpty {
            self.view.makeToast("Please enter employee email.")
        }
        else if textF_empNumber.text!.isEmpty {
            self.view.makeToast("Please enter employee phone number.")
        }
        else{
            print("ALL OK")
            isEdit = false
            btn_EditAndSaveProfile.setTitle("Edit", for: .normal)
            update_UserProfileView()
            editEmloyeeInfo(withEmpId: selectedEmployeeId, empEmail: textF_empEmail.text!, empNumber: textF_empNumber.text!)
        }
    }
    func update_UserProfileView() {
        if  isEdit {
            //textF_empDesignation.isUserInteractionEnabled = true
            //textF_empShift.isUserInteractionEnabled = true
           // btn_empShift.isUserInteractionEnabled = true
            //textF_empTimeRange.isUserInteractionEnabled = true
           // textF_empCurrentStatus.isUserInteractionEnabled = true
           // btn_empStatus.isUserInteractionEnabled = true
            textF_empEmail.isUserInteractionEnabled = true
            textF_empNumber.isUserInteractionEnabled = true
        }
        else
        {
            //textF_empDesignation.isUserInteractionEnabled = false
            //textF_empShift.isUserInteractionEnabled = false
            //btn_empShift.isUserInteractionEnabled = false
           // textF_empTimeRange.isUserInteractionEnabled = false
            //textF_empCurrentStatus.isUserInteractionEnabled = false
           
            textF_empEmail.isUserInteractionEnabled = false
            textF_empNumber.isUserInteractionEnabled = false
        }
    }
    

    
    @IBAction func btnAction_selectLeaveType(_ sender: Any) {
        dropDownLeaveType.show()
        dropDownLeaveType.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            //self?.btn_taskMgt_Filter.setTitle(item, for: .normal)
            self?.selectedLeaveTypeId = self?.leaveTypeArray[index]["id"] as! Int
            self?.textF_leaveType.text = item
        }
    }
    
    @IBAction func btnAction_taskManagementFilter(_ sender: Any) {
        dropDown_taskManagement.show()
        dropDown_taskManagement.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_taskMgt_Filter.setTitle(item, for: .normal)
        }
    }
    
    
    @IBAction func btnAction_leaveReq_Filter(_ sender: Any) {
        dropDown_leaveRequest.show()
        dropDown_leaveRequest.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_leaveReq_Filter.setTitle(item, for: .normal)
        }
    }
    @IBAction func btnAction_taskManagement_DateFilter(_ sender: Any) {
        btn_SelectDates.tag = 4
        openCalender()
    }
    
    @IBAction func btnAction_taskManagement_EDIT(_ sender: Any) {
    }
    
    
    @IBAction func btnAction_resetLeaveApplicationForm(_ sender: Any) {
    }
    
    @IBAction func btnAction_submitLeaveApplicationRequest(_ sender: Any) {
       
        if textF_empID.text!.isEmpty {
            self.view.makeToast("Please enter employee ID.")
        }
        else if textF_leaveType.text!.isEmpty {
            self.view.makeToast("Please select leave type.")
        }
        else if textF_leaveFromDate.text!.isEmpty {
            self.view.makeToast("Please select from date.")
        }
        else if textF_leaveToDate.text!.isEmpty {
            self.view.makeToast("Please select to date.")
        }
        else if textF_teamMail_Id.text!.isEmpty {
            self.view.makeToast("Please enter message to manager.")
        }
        else if textView_reasonForLeave.text.isEmpty{
            self.view.makeToast("Please enter reason for leave.")
        }
        else
        {
            print("ALL OK")
            submitLeaveRequestMethod(withEmpId: textF_empID.text!, leaveTypeId: selectedLeaveTypeId, fromDate: textF_leaveFromDate.text!, toDate: textF_leaveToDate.text!, managerMessage: textF_teamMail_Id.text!, reasonForLeave: textView_reasonForLeave.text)
        }
    }
    
    @IBAction func btnAction_leaveReq_DateFilter(_ sender: Any) {
        btn_SelectDates.tag = 1
        openCalender()
    }
    
    @IBAction func btnAction_leaveApplication_FromDate(_ sender: UIButton) {
       /* btn_SelectDates.tag = 2
         firstDate = nil
        openCalender()*/
   textF_leaveToDate.text = ""
        textF_natureOfLeave.text = ""
       dateTimePicker.tag = 2
        openDatePicker()
      
        
    }
    
    @IBAction func btnAction_leaveApplication_ToDate(_ sender: UIButton) {
       /* btn_SelectDates.tag = 3
         firstDate = nil
        openCalender()*/
        
        if textF_leaveFromDate.text!.isEmpty {
            self.view.makeToast("Please Select From-Date First.")
        }
        else{
        dateTimePicker.tag = 3
        openDatePicker()
        }
       
    }
    
    func openDatePicker() {
        bgView.isHidden = false
        
        self.view.endEditing(true)
        
        dateTimePicker.isHidden = false
        toolBar.isHidden = false
        
       
        
        self.dateTimePicker.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.dateTimePicker.frame.size.height)
      
        self.toolBar.frame = CGRect(x: 0.0, y:self.view.frame.size.height - self.dateTimePicker.frame.size.height, width: self.view.frame.width, height: 50)
       
        
        dateTimePicker.backgroundColor = .white
        UIView.animate(withDuration: 0.60, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.dateTimePicker.frame = CGRect(x: 0, y: self.view.frame.size.height - self.dateTimePicker.frame.size.height , width: self.view.frame.width, height: self.dateTimePicker.frame.size.height)
            
           self.toolBar.frame = CGRect(x: 0.0, y:self.view.frame.size.height - (self.dateTimePicker.frame.size.height + self.toolBar.frame.size.height), width: self.view.frame.width, height: 50)
        }) { (flag :Bool) in
            
            self.dateTimePicker.frame = CGRect(x: 0, y: self.view.frame.size.height - self.dateTimePicker.frame.size.height , width: self.view.frame.width, height: self.dateTimePicker.frame.size.height)
            
           self.toolBar.frame = CGRect(x: 0.0, y:self.view.frame.size.height - (self.dateTimePicker.frame.size.height + self.toolBar.frame.size.height), width: self.view.frame.width, height: 50)
        }
        toolBar.tintColor = UIColor.yellow
        toolBar.barStyle = .black
        toolBar.backgroundColor = UIColor.black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(bgView)
        self.view.addSubview(dateTimePicker)
        self.view.addSubview(toolBar)
        print("TAG===>\( dateTimePicker.tag)")
        if dateTimePicker.tag == 3
        {
            
            dateTimePicker.minimumDate = dateTimePicker.date
        }
        else
        {
            dateTimePicker.minimumDate = nil
        }
        dateTimePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    @objc func onDoneButtonTapped() {
        dateTimePicker.isHidden = true
        toolBar.isHidden = true
        bgView.isHidden = true
    }
   
    @objc func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
       // dateFormatter.dateStyle = DateFormatter.Style.full
       // dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.short
         dateFormatter.timeStyle = DateFormatter.Style.short
        print("SENDER TAG == \(sender)")
        if dateTimePicker.tag == 2 {
            let str_FromDate = dateFormatter.string(from: dateTimePicker.date)
            textF_leaveFromDate.text = str_FromDate
        }
        else{
            let str_ToDate = dateFormatter.string(from: dateTimePicker.date)
            textF_leaveToDate.text = str_ToDate
             numberOfDays = convertDaysFromDates(fromDate: textF_leaveFromDate.text!, toDate: textF_leaveToDate.text!)
            textF_natureOfLeave.text = "\(numberOfDays)"
            
        }
        
    }
    @IBAction func btnAction_leaveApplicationForm(_ sender: Any) {
        btn_leaveApplicationForm.isSelected = true
         btn_leaveApplicationForm.backgroundColor = UIColor.black
        btn_leaveRequests.isSelected = false
        btn_leaveRequests.backgroundColor = UIColor.lightGray
        leaveApplicationForm_View.isHidden = false
        leaveRequests_View.isHidden = true
    }
    @IBAction func btnAction_leaveRequests(_ sender: Any) {
        btn_leaveApplicationForm.isSelected = false
        btn_leaveApplicationForm.backgroundColor = UIColor.lightGray
         btn_leaveRequests.backgroundColor = UIColor.black
        btn_leaveRequests.isSelected = true
        leaveApplicationForm_View.isHidden = true
        leaveRequests_View.isHidden = false
        allEmployee_LeaveDataArray = [[String: Any]]()
        getLeaveList()
    }
    @IBAction func btnAction_CloseEmployeeDetailView(_ sender: Any) {
       self.view.endEditing(true)
        isEdit = false
        btn_EditAndSaveProfile.setTitle("Edit", for: .normal)
        update_UserProfileView()
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
                UIView.transition(with: workScheduling_View, duration: 0.7, options: transitionOptions, animations: {
                    self.employeeDetail_View.isHidden = true
                })
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
    //    func minimumDate(for calendar: FSCalendar) -> Date {
    //        let gregorian = Calendar(identifier: .gregorian)
    //        var comps = DateComponents()
    //        comps.month = 1
    //        comps.month = 0
    //        comps.day = 1
    //        let minDate = gregorian.date(byAdding: comps, to: Date())
    //        return minDate!//Date()
    //    }
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
                
                    textF_leaveFromDate.text = "\(checkIn_Date)"
                
                closeCalendar()
            }
            else{
                self.view.makeToast("Please select date.")
                checkIn_Date = ""
            }
        }
        else if sender.tag == 3 {
            if firstDate != nil{
                let dateFormatterGET = DateFormatter()
                
                dateFormatterGET.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatterSET = DateFormatter()
                //dateFormatterSET.dateFormat = "yyyy-MM-dd"
                dateFormatterSET.dateFormat = "dd-MM-yyyy"
                let newStartDate = dateFormatterSET.string(from: firstDate!)
                
                print("CURRENT START DATE = \(newStartDate)")
                
                checkIn_Date = newStartDate
                
           
                    textF_leaveToDate.text = "\(checkIn_Date)"
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
                    btn_leaveReq_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
                }
                else if sender.tag == 4
                {
                    btn_taskMgt_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
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
        if calendar != nil {
            calendar.isHidden = true
        }
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
        dateTimePicker.isHidden = true
        toolBar.isHidden = true
    }
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return departmentArray.count//5
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "scheduleSectionCell") as UITableViewCell?)!
            cell.selectionStyle = .none
        let sectionTitle_lbl: UILabel = cell.viewWithTag(1) as! UILabel
        sectionTitle_lbl.text = departmentArray[indexPath.row]//"Account Panel"
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: departmentArray[indexPath.row], attributes: underlineAttribute)
        sectionTitle_lbl.attributedText = underlineAttributedString
        let employeeCollectionView: UICollectionView = cell.viewWithTag(2) as! UICollectionView
        employeeCollectionView.backgroundColor = UIColor.white
            return cell
        
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 180
      
    }*/
    
    
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case leaveRequests_CollectionView:
            return allEmployee_LeaveDataArray.count
        case taskManagement_CollectionView:
            return 50
        default:
            return 1
        }
        //return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case leaveRequests_CollectionView:
            return 8
        case taskManagement_CollectionView:
            return 9
        default:
            if allEmployee_DataArray.count > 0{
            return allEmployee_DataArray.count
            }
            else
            {
                return 0
            }
        }
           // return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case leaveRequests_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            //                if indexPath.section % 2 != 0 {
            //                    cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            //                } else {
            cell.backgroundColor = UIColor.white
            // }
            cell.cancelBtn.layer.cornerRadius = 10
       
            cell.cancelBtn.layer.masksToBounds = true
            cell.okBtn.layer.cornerRadius = 10
            
            cell.okBtn.layer.masksToBounds = true
            cell.checkBoxView.isHidden = true
            if #available(iOS 11.0, *) {
                cell.cancelBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                cell.okBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
            
            
            if indexPath.section == 0 {
                cell.contentLabel.text = leaveRequestTabArray[indexPath.row]
                cell.statusView.isHidden = true
                 cell.checkBoxView.isHidden = true
                
            } else {
                if allEmployee_LeaveDataArray.count > 0{
                    if indexPath.row == 0 {
                        let empIdArray = allEmployee_LeaveDataArray[indexPath.section]["employee_id"] as! NSArray
                        cell.contentLabel.text = "\(empIdArray[0])"//String(indexPath.section)
                        cell.statusView.isHidden = true
                        cell.checkBoxView.isHidden = true
                        cell.contentLabel.isHidden = false
                    } else {
                        
                        if indexPath.row == 7
                        {
                            cell.contentLabel.isHidden = true
                            cell.statusView.isHidden = false
                            cell.checkBoxView.isHidden = true
                        }
                        else
                        {
                            
                            cell.contentLabel.isHidden = false
                            cell.statusView.isHidden = true
                            cell.checkBoxView.isHidden = true
                            switch(indexPath.row)
                            {
                            case 1:
                                let empIdArray = allEmployee_LeaveDataArray[indexPath.section]["employee_id"] as! NSArray
                                cell.contentLabel.text = "\(empIdArray[1])"
                            case 2:
                                cell.contentLabel.text = "NO KEY"
                            case 3:
                                cell.contentLabel.text = "\(allEmployee_LeaveDataArray[indexPath.section]["date_from"] ?? "NO DATA")"
                            case 4:
                                cell.contentLabel.text = "\(allEmployee_LeaveDataArray[indexPath.section]["date_to"] ?? "NO DATA")"
                            case 5:
                                cell.contentLabel.text = "\(allEmployee_LeaveDataArray[indexPath.section]["duration_display"] ?? "NO DATA")"
                            case 6:
                                cell.contentLabel.text = "\(allEmployee_LeaveDataArray[indexPath.section]["name"] ?? "NO DATA")"
                            default:
                                cell.contentLabel.text = "DATA"
                            }
                            
                            cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                        }
                        
                    }
                }
            }
            
            return cell
        case taskManagement_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
           
            cell.backgroundColor = UIColor.white
//            cell.layer.borderColor = UIColor.blue.cgColor
//            cell.layer.borderWidth = 5
            
             cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
          
                cell.contentLabel.text = taskManegementTabArray[indexPath.row]
                
                
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "employeeCell", for: indexPath as IndexPath)
            
            let user_ImageView: UIImageView = cell.viewWithTag(1) as! UIImageView
            let employeeNamae_Lbl: UILabel = cell.viewWithTag(2) as! UILabel
            let employeeDesignation_Lbl: UILabel = cell.viewWithTag(3) as! UILabel
            let statusView: UIView = cell.viewWithTag(4)!
            user_ImageView.layer.cornerRadius = user_ImageView.frame.size.width / 2
            user_ImageView.layer.borderColor = UIColor.green.cgColor
            user_ImageView.layer.borderWidth = 1.8
            
            if allEmployee_DataArray.count > 0 {
                employeeNamae_Lbl.text = allEmployee_DataArray[indexPath.item]["name"] as? String
                if let jobTitle  =  allEmployee_DataArray[indexPath.item]["job_title"] as? String{
                    employeeDesignation_Lbl.text = jobTitle
                    
                }
                else{
                    employeeDesignation_Lbl.text = "No Data"
                }
                if let imageString = allEmployee_DataArray[indexPath.item]["image_128"] as? String
                {
                    DispatchQueue.main.async {
                        user_ImageView.image = appDelegate.convertBase64StringToImage(imageString: imageString)
                    }
                }
                else
                {
                    user_ImageView.image = UIImage(named: "user-profile")
                }
                
                
            }
            else
            {
                employeeNamae_Lbl.text = "N/A"
                employeeDesignation_Lbl.text = "N/A"
            }
            statusView.layer.cornerRadius = statusView.frame.size.width / 2
            //statusView.layer.borderWidth = 1
            // statusView.clipsToBounds = true
            
            if indexPath.item % 2 == 0 {
                statusView.backgroundColor = UIColor.green
                // statusView.layer.borderColor = UIColor.white.cgColor
                
            }
            else{
                statusView.backgroundColor = UIColor.red
                //statusView.layer.borderColor = UIColor.red.withAlphaComponent(0.8).cgColor
            }
            
            
            return cell
        }
        
            
     
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        print("SECTION == \(indexPath.section)")
        //employeeDetail_View.isHidden = false
        switch collectionView {
        case leaveRequests_CollectionView:
              print("You selected cell #\(indexPath.item)!")
        case taskManagement_CollectionView:
             print("You selected cell #\(indexPath.item)!")
        default:
             perform(#selector(flip), with: nil, afterDelay: 0.0)
             clearData()
             getEmloyeeInfo(withEmpId: allEmployee_DataArray[indexPath.item]["id"] as! Int)
        }
       
    }
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: employeeDetail_View, duration: 0.7, options: transitionOptions, animations: {
            self.employeeDetail_View.isHidden = false
        })
    }
    
    func getLeaveType_method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_LEAVE_TYPE
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
                    self.leaveTypeArray.append(responseJSONs[i])
                }
                
                DispatchQueue.main.async {
                    print("LEAVE TYPE = \(self.leaveTypeArray)")
                    
                    appDelegate.hideHUD()
                    for i in 0..<self.leaveTypeArray.count{

                        self.dropDownLeaveType.dataSource.append(self.leaveTypeArray[i]["display_name"] as! String)
                    
                    }
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
    func getAll_Employee_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_ALL_EMPLOYEE
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
                    self.allEmployee_DataArray.append(responseJSONs[i])
                }
                
                DispatchQueue.main.async {
                    print("ALL EMP = \(self.allEmployee_DataArray)")
                    
                    self.workSchedule_CollectionView.reloadData()
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
    
    func getEmloyeeInfo(withEmpId: Int) {
        print(msg_PLEASE_WAIT)
        selectedEmployeeId = withEmpId
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_GET_EMPLOYEE_INFO
        //get_employee_info
        let empId = withEmpId
        
        print(url)
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        let manager = AFHTTPSessionManager()
        
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
       
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        let parametes = ["employee_id": empId]
        
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
           if let content = responseObject as? NSArray {
            if let data = content[0] as? [String:Any]
                    {
                        print("DATA === ???? \(data)")
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                            if let empImage = data["image_1920"] as? String{
                                
                                DispatchQueue.main.async {
                                    self.userDetail_ImageView.image = appDelegate.convertBase64StringToImage(imageString: empImage)
                                }
                            }
                            if let empName = data["display_name"] as? String{
                                self.employeeName_lbl.text = empName
                                
                               
                            }
                            if let empDesignation = data["job_title"] as? String{
                             
                                self.textF_empDesignation.text = empDesignation
                                
                            }
                           // if let empShift = data["job_title"] as? String{
                            
                                self.textF_empShift.text = "NO KEY"
                           // }
                            var  timeRange = ""
                            
                            if let empTime_InRange = data["last_check_in"] as? String {
                                
                                timeRange = self.setDateFormatTo_TIME(dateString: empTime_InRange)//empTime_InRange
                            }
                            if let empTime_OutRange = data["last_check_out"] as? String {
                                
                                timeRange = timeRange + " - " + self.setDateFormatTo_TIME(dateString: empTime_OutRange)//empTime_OutRange
                            }
                            self.textF_empTimeRange.text = timeRange
                            if let empStatus = data["attendance_state"] as? String{
                                if empStatus == "checked_out"
                                {
                                    self.textF_empCurrentStatus.textColor = UIColor.red
                                    self.textF_empCurrentStatus.text = "Out"
                                     self.userDetail_ImageView.layer.borderColor = UIColor.red.cgColor
                                    self.userDetailStatus_View.backgroundColor = UIColor.red
                                }
                                else
                                {
                                    self.textF_empCurrentStatus.textColor = UIColor.green
                                     self.userDetail_ImageView.layer.borderColor = UIColor.green.cgColor
                                    self.textF_empCurrentStatus.text = "In"
                                    self.userDetailStatus_View.backgroundColor = UIColor.green
                                }
                                
                                
                            }
                            if let empEmail = data["work_email"] as? String{
                                
                                self.textF_empEmail.text = empEmail
                            }
                            if let empNumber = data["mobile_phone"] as? String{
                                self.textF_empNumber.text = empNumber
                            }
                            
                           
                        }
                    }
            }

        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
  
    func setDateFormatTo_TIME(dateString: String) -> String {
        print("Previous Date Format = \(dateString)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: newDate!)
    }
    
    func getLeaveList() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_LEAVE_LIST
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
                    self.allEmployee_LeaveDataArray.append(responseJSONs[i])
                }
                
                DispatchQueue.main.async {
                    print("ALL EMP LEAVE REQUEST = \(self.allEmployee_LeaveDataArray)")
                    
                    self.leaveRequests_CollectionView.reloadData()
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
    func editEmloyeeInfo(withEmpId: Int, empEmail: String, empNumber: String) {
        print(msg_PLEASE_WAIT)
        
        print("SELECTED EMP ID  =  \(withEmpId)")
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_POST_EDIT_EMPLOYEE_INFO
        
        let empId = withEmpId
        
        print(url)
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        let manager = AFHTTPSessionManager()
        
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
        // manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
        let userData = "{\"mobile_phone\":\"\(empNumber)\",\"work_email\":\"\(empEmail)\"}"
        let parametes = ["employee_id": empId,"new_data":userData] as [String : Any]
        
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            if let content = responseObject as?  [String: Any] {
                if let code = content["code"] as? Int
                { print("CODE == \(code)")
                    if code == 200
                    {
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                            self.view.makeToast("Successfully Updated Employee Info.")
                        }
                    }
                    else{
                        if let err = content["err"] as? String{
                            if err == "Empty Token or Error Token"
                            {
                                let alert = UIAlertController(title: "Alert ! Session Expired", message: "Your Session is Expired.\nPlease login.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Login",
                                                              style: UIAlertAction.Style.default,
                                                              handler: {(_: UIAlertAction!) in
                                                                DispatchQueue.main.async {
                                                                    appDelegate.hideHUD()
                                                                }
                                                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                                                
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else{
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                            self.view.makeToast("Failed: Try Again!")
                        }
                        }
                    }
                }
            }
            
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
    
    func submitLeaveRequestMethod(withEmpId: String, leaveTypeId: Int, fromDate: String, toDate: String, managerMessage: String, reasonForLeave: String) {
        let myUrl = NSURL(string: "https://13.eotor.net/apis/post_leave_req");
        
        let request = NSMutableURLRequest(url : myUrl! as URL);
        
        request.httpMethod = "POST";
       // ["employee_id": empId,"date_start":startDate, "date_end":endDate, "leave_type_id": lID, "reason": reasonForLeave, "manager_message":managerMessage, "number_of_days": nday,"start_am_pm":startAM_PM]
        let empId = withEmpId
        let timeArray = fromDate.components(separatedBy: " ")
        print(timeArray[2])
        var startAM_PM = timeArray[2]
        if startAM_PM == "AM" {
            startAM_PM = "am"
        }
        else
        {
            startAM_PM = "pm"
        }
        
        let startDate = convertDateFormater(fromDate)
        print("START D \(startDate)")
        let endDate = convertDateFormater(toDate)
        print("END D \(endDate)")
        let lID = "\(leaveTypeId)"
        let nday = "\(numberOfDays)"
       
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postParameters = "{\"employee_id\":\"\(empId)\",\"date_start\":\"\(startDate)\",\"date_end\":\"\(endDate)\",\"leave_type_id\":\"\(lID)\",\"reason\":\"\(reasonForLeave)\",\"manager_message\":\"\(managerMessage)\",\"number_of_days\":\"\(nday)\",\"start_am_pm\":\"\(startAM_PM)\"}"
        
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data, response, error in
            if error != nil
            {
                print("error is \(String(describing: error))")
                return;
            }
            
            do
            {
                print(response!)
                let myJSON = try  JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                if let parseJSON = myJSON
                {
                   // var msg : String!
                   // msg = parseJSON["message"] as! String?
                   // print(msg)
                    
                }
            }
            catch
            {
                print(error.localizedDescription)
                print(error)
            }
            
        }
        task.resume()
    }
    func submitLeaveRequestMethod2(withEmpId: String, leaveTypeId: Int, fromDate: String, toDate: String, managerMessage: String, reasonForLeave: String) {
        print(msg_PLEASE_WAIT)
        
        print("SELECTED EMP ID  =  \(withEmpId)")
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url = BASE_URL + k_API_POST_LEAVE_REQUEST
        
        let empId = withEmpId
        let timeArray = fromDate.components(separatedBy: " ")
        print(timeArray[2])
        var startAM_PM = timeArray[2]
        if startAM_PM == "AM" {
            startAM_PM = "am"
        }
        else
        {
            startAM_PM = "pm"
        }
        
        let startDate = convertDateFormater(fromDate)
        print("START D \(startDate)")
        let endDate = convertDateFormater(toDate)
        print("END D \(endDate)")
        let lID = "\(leaveTypeId)"
        let nday = "\(numberOfDays)"
        print(url)
        let accessToken = "\(UserDefaults.standard.object(forKey: "access_token") ?? "No Data")"
        
        print("AT ==> \(accessToken)")
        let manager = AFHTTPSessionManager()
        
        manager.requestSerializer.setValue(accessToken, forHTTPHeaderField: "Authorization")
        // manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
       // manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")

        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
       // let userData = "{\"mobile_phone\":\"\(empNumber)\",\"work_email\":\"\(empEmail)\"}"
        let parametes = ["employee_id": empId,"date_start":startDate, "date_end":endDate, "leave_type_id": lID, "reason": reasonForLeave, "manager_message":managerMessage, "number_of_days": nday,"start_am_pm":startAM_PM] as [String : Any]
        
        manager.post(url, parameters: parametes, progress: nil, success: {
            (operation, responseObject) in
            print(responseObject!)
            if let content = responseObject as?  [String: Any] {
                if let code = content["code"] as? Int
                { print("CODE == \(code)")
                    if code == 200
                    {
                        DispatchQueue.main.async {
                            appDelegate.hideHUD()
                            self.view.makeToast("Successfully Updated Employee Info.")
                        }
                    }
                    else{
                        if let err = content["err"] as? String{
                            if err == "Empty Token or Error Token"
                            {
                                let alert = UIAlertController(title: "Alert ! Session Expired", message: "Your Session is Expired.\nPlease login.", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Login",
                                                              style: UIAlertAction.Style.default,
                                                              handler: {(_: UIAlertAction!) in
                                                                DispatchQueue.main.async {
                                                                    appDelegate.hideHUD()
                                                                }
                                                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                                                
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else{
                            DispatchQueue.main.async {
                                appDelegate.hideHUD()
                                self.view.makeToast("Failed: Try Again!")
                            }
                        }
                    }
                }
            }
            
        }, failure: {
            (operation, error) in
            appDelegate.hideHUD()
            self.view.makeToast("Failed: Unauthorized")
            print("Error: " + error.localizedDescription)
        })
        //access_token_e26faff633b14dbad81ef47e50add93239bbed3f
        
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy, H:mm a"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-dd-MM"
        //2020-06-01
        return  dateFormatter.string(from: date!)
        
    }
    func convertDaysFromDates(fromDate: String, toDate: String) -> Int {
        
        let startDate = convertDateFormater(fromDate)
        let endDate = convertDateFormater(toDate)
        let dateFormatter = DateFormatter()
        // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let start_DATE = dateFormatter.date(from:startDate)!
        let end_DATE = dateFormatter.date(from:endDate)!
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start_DATE)
        let date2 = calendar.startOfDay(for: end_DATE)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        print("DAY ==\(components.day ?? 0)")
        
        let numberOfDays = components.day
        return numberOfDays!
    }
    func clearData() {
        employeeName_lbl.text = ""
        textF_empDesignation.text = ""
        textF_empShift.text = ""
        textF_empTimeRange.text = ""
        textF_empCurrentStatus.text = ""
        textF_empEmail.text = ""
        textF_empNumber.text = ""
        userDetail_ImageView.image = UIImage(named: "user-profile")
    }
}
