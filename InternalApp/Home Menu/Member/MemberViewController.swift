//
//  MemberViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 23/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import Charts
import TTSegmentedControl
import DropDown
class MemberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource {
    
    

    @IBOutlet weak var segmentedView: TTSegmentedControl!
    @IBOutlet weak var consumptionAnalysis_View: UIView!
    @IBOutlet weak var memberAnalysis_View: UIView!
    
    @IBOutlet weak var memberManagement_View: UIView!
    
    
    @IBOutlet weak var memberManagement_EDIT_ModeView: UIView!
    @IBOutlet weak var memberEnquiry_View: UIView!
    @IBOutlet weak var consumptionPreference_View: UIView!
    
    @IBOutlet weak var memberAnalysis_ChartView: LineChartView!
    var memberAnalysisChartDataArray1 = [Int]()
    var memberAnalysisChartDataArray2 = [Int]()
    var memberAnalysisChartDataArray3 = [Int]()
    var memberAnalysisChartDataArray4 = [Int]()
    var checkedUnchecked = 0
    var checkedUncheckedArray = [Int]()
   
    var consumptionPreferenceChartDataArray1 = [Int]()
    var consumptionPreferenceChartDataArray2 = [Int]()
    var consumptionPreferenceChartDataArray3 = [Int]()
    var consumptionPreferenceChartDataArray4 = [Int]()
    
    @IBOutlet weak var consumptionAnalysis_collectionView: UICollectionView!
    
    @IBOutlet weak var consumptionPreference_collectionView: UICollectionView!
    var consumptionAnalysisTabArray = ["No.","Buyer Name", "Membership Level", "Country", "Organization", "Total Item", "Price"]
     var consumptionPreferenceTabArray = ["No.","Item Name", "Category", "Total Stock", "Remaining Stock", "Price", "Velocity of Sale"]
    
    var memberInquiryTabArray = ["No.","Member Name", "Level", "Email", "Phone", "Organization", "Address", "Country", "Purchased Items"]
    
     var memberManagementTabArray = ["No.","Member Name", "Level", "Point","Email", "Phone", "Organization", "Address", "Country", "Purchased Items"]
    @IBOutlet weak var memberInquiry_collectionView: UICollectionView!
    
    @IBOutlet weak var memberManagement_collectionView: UICollectionView!
    
    @IBOutlet weak var memberManagement_EDIT_Mode_collectionView: UICollectionView!
    // DROPDOWS ---
    var dropDown_memberAnalysis = DropDown()
   
    
    // AnchorViews ---
     @IBOutlet weak var memberAnalysis_filterView: UIView!
    
    @IBOutlet weak var btn_memberAnalysisFilter: UIButton!
    
    @IBOutlet weak var btn_consumptionPref_DateFilter: UIButton!
    
    @IBOutlet weak var btn_memberAnalysis_DateFilter: UIButton!
    @IBOutlet weak var btn_consumptionAnalysis_DateFilter: UIButton!
    
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
    
    
    @IBOutlet weak var concumptionPreference_ChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        memberAnalysis_View.layer.cornerRadius = 8
        consumptionAnalysis_View.layer.cornerRadius = 8
        consumptionPreference_View.layer.cornerRadius = 8
        memberEnquiry_View.layer.cornerRadius = 8
        memberManagement_View.layer.cornerRadius = 8
        memberManagement_EDIT_ModeView.layer.cornerRadius = 8
        memberAnalysis_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        consumptionAnalysis_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        consumptionPreference_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        memberEnquiry_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        memberManagement_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        memberManagement_EDIT_ModeView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        memberAnalysisChartDataArray1 = [10, 40, 60, 20]
        memberAnalysisChartDataArray2 = [30, 40, 20, 50]
        memberAnalysisChartDataArray3 = [80, 30, 20, 80]
        memberAnalysisChartDataArray4 = [40, 20, 60, 30]
        updateMemberAnalysisChart()
        
        consumptionPreferenceChartDataArray1 = [1, 8, 1, 200]
        consumptionPreferenceChartDataArray2 = [100, 2, 2, 60]
        consumptionPreferenceChartDataArray3 = [30, 30, 20, 4]
        consumptionPreferenceChartDataArray4 = [4, 20, 60, 2]
        updateConsumptionPreferenceChart()
        consumptionAnalysis_collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                              forCellWithReuseIdentifier: "ContentCellIdentifier")
        consumptionPreference_collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                               forCellWithReuseIdentifier: "ContentCellIdentifier")
        memberInquiry_collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                      forCellWithReuseIdentifier: "ContentCellIdentifier")
        
        memberManagement_collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                              forCellWithReuseIdentifier: "ContentCellIdentifier")
        memberManagement_EDIT_Mode_collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                                 forCellWithReuseIdentifier: "ContentCellIdentifier")
        memberManagement_EDIT_ModeView.isHidden = true
        checkedUncheckedArray = [0,0,0,0,0,0,0,0,0,0]
       // items = [0,1,2,3,4,5,6,7,8,9]
        print("COUNT == \(checkedUncheckedArray.count)")
      setupSegmentView()
        dropDown_memberAnalysis.dataSource = ["M Level 1", "M Level 2","M Level 3","M Level 4","M Level 5"]
        dropDown_memberAnalysis.anchorView = memberAnalysis_filterView
        dropDown_memberAnalysis.cornerRadius = 8
        dropDown_memberAnalysis.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_memberAnalysis.selectionBackgroundColor = UIColor.black
        dropDown_memberAnalysis.selectedTextColor = UIColor.yellow
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        concumptionPreference_ChartView.isHidden = true
        consumptionPreference_collectionView.isHidden = false
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setupSegmentView() {
        segmentedView.isSwitch = true
        segmentedView.itemTitles = ["Graph", "Table"]
        segmentedView.selectedTextColor = UIColor.black
        segmentedView.containerBackgroundColor = UIColor.black
        segmentedView.defaultTextColor = UIColor.white
        segmentedView.thumbGradientColors = [UIColor.white, UIColor.white]
        segmentedView.selectItemAt(index: 1)
        segmentedView.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index) and Title \(title ?? "")")
            if index == 0
            {
                self.concumptionPreference_ChartView.isHidden = false
                self.consumptionPreference_collectionView.isHidden = true
            }
            else
            {
                self.concumptionPreference_ChartView.isHidden = true
                self.consumptionPreference_collectionView.isHidden = false
            }
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
    @objc  func getAndSetDates(sender:UIButton) {
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
            print(sender.tag)
            if sender.tag == 1
            {
                btn_memberAnalysis_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
            }
            else if sender.tag == 2
            {
                btn_consumptionAnalysis_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
            }
            else if sender.tag == 3
            {
                btn_consumptionPref_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
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
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    @IBAction func btnAction_memberShipLevel_Filter(_ sender: Any) {
        dropDown_memberAnalysis.show()
        dropDown_memberAnalysis.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_memberAnalysisFilter.setTitle(item, for: .normal)
        }
    }
    
    func updateMemberAnalysisChart() {
        var lineChartEntry1 = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var lineChartEntry3 = [ChartDataEntry]()
        var lineChartEntry4 = [ChartDataEntry]()
        
        for i in 0..<memberAnalysisChartDataArray1.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray1[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry1.append(value) // here we add it to the data set
        }
        for i in 0..<memberAnalysisChartDataArray2.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray2[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry2.append(value) // here we add it to the data set
        }
        for i in 0..<memberAnalysisChartDataArray3.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry3.append(value) // here we add it to the data set
        }
        for i in 0..<memberAnalysisChartDataArray4.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray4[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry4.append(value) // here we add it to the data set
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "IOS") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.magenta] //Sets the colour to blue
        
        
        
        line1.mode = .horizontalBezier
        line1.drawCirclesEnabled = false
        line1.lineWidth = 1.8
        line1.circleRadius = 4
        line1.setCircleColor(.white)
        line1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line1.fillColor = .magenta
        line1.fillAlpha = 0.3
        line1.drawFilledEnabled = true
        line1.drawHorizontalHighlightIndicatorEnabled = false
        
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "ANDROID") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        line2.mode = .horizontalBezier
        line2.drawCirclesEnabled = false
        line2.lineWidth = 1.8
        line2.circleRadius = 4
        line2.setCircleColor(.white)
        line2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line2.fillColor = .blue
        line2.fillAlpha = 0.3
        line2.drawFilledEnabled = true
        line2.drawHorizontalHighlightIndicatorEnabled = false
        
        let line3 = LineChartDataSet(entries: lineChartEntry3, label: "JAVA") //Here we convert lineChartEntry to a LineChartDataSet
        line3.colors = [NSUIColor.red] //Sets the colour to blue
        
        
        
        line3.mode = .horizontalBezier
        line3.drawCirclesEnabled = false
        line3.lineWidth = 1.8
        line3.circleRadius = 4
        line3.setCircleColor(.white)
        line3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line3.fillColor = .red
        line3.fillAlpha = 0.3
        line3.drawFilledEnabled = true
        line3.drawHorizontalHighlightIndicatorEnabled = false
        
        let line4 = LineChartDataSet(entries: lineChartEntry4, label: "WINDOWS") //Here we convert lineChartEntry to a LineChartDataSet
        line4.colors = [NSUIColor.green] //Sets the colour to blue
        
        
        
        line4.mode = .horizontalBezier
        line4.drawCirclesEnabled = false
        line4.lineWidth = 1.8
        line4.circleRadius = 4
        line4.setCircleColor(.white)
        line4.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line4.fillColor = .green
        line4.fillAlpha = 0.3
        line4.drawFilledEnabled = true
        line4.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSets: [line1, line2, line3, line4])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        memberAnalysis_ChartView.data = data
        
        
        
        memberAnalysis_ChartView.rightAxis.enabled  = false
        
        memberAnalysis_ChartView.legend.form = .none
        memberAnalysis_ChartView.animate(xAxisDuration: 2.5)
        
    }
    
    
    func updateConsumptionPreferenceChart() {
        var lineChartEntry1 = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var lineChartEntry3 = [ChartDataEntry]()
        var lineChartEntry4 = [ChartDataEntry]()
        
        for i in 0..<consumptionPreferenceChartDataArray1.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray1[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry1.append(value) // here we add it to the data set
        }
        for i in 0..<consumptionPreferenceChartDataArray2.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray2[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry2.append(value) // here we add it to the data set
        }
        for i in 0..<consumptionPreferenceChartDataArray3.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry3.append(value) // here we add it to the data set
        }
        for i in 0..<consumptionPreferenceChartDataArray4.count{
            let value = ChartDataEntry(x: Double(i), y: Double(memberAnalysisChartDataArray4[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry4.append(value) // here we add it to the data set
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "DATA 1") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.magenta] //Sets the colour to blue
        
        
        
        line1.mode = .horizontalBezier
        line1.drawCirclesEnabled = false
        line1.lineWidth = 1.8
        line1.circleRadius = 4
        line1.setCircleColor(.white)
        line1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line1.fillColor = .red
        line1.fillAlpha = 0.3
        line1.drawFilledEnabled = true
        line1.drawHorizontalHighlightIndicatorEnabled = false
        
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "DATA 2") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        line2.mode = .horizontalBezier
        line2.drawCirclesEnabled = false
        line2.lineWidth = 1.8
        line2.circleRadius = 4
        line2.setCircleColor(.white)
        line2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line2.fillColor = .green
        line2.fillAlpha = 0.3
        line2.drawFilledEnabled = true
        line2.drawHorizontalHighlightIndicatorEnabled = false
        
        let line3 = LineChartDataSet(entries: lineChartEntry3, label: "DATA 3") //Here we convert lineChartEntry to a LineChartDataSet
        line3.colors = [NSUIColor.red] //Sets the colour to blue
        
        
        
        line3.mode = .horizontalBezier
        line3.drawCirclesEnabled = false
        line3.lineWidth = 1.8
        line3.circleRadius = 4
        line3.setCircleColor(.white)
        line3.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line3.fillColor = .cyan
        line3.fillAlpha = 0.3
        line3.drawFilledEnabled = true
        line3.drawHorizontalHighlightIndicatorEnabled = false
        
        let line4 = LineChartDataSet(entries: lineChartEntry4, label: "DATA 4") //Here we convert lineChartEntry to a LineChartDataSet
        line4.colors = [NSUIColor.green] //Sets the colour to blue
        
        
        
        line4.mode = .horizontalBezier
        line4.drawCirclesEnabled = false
        line4.lineWidth = 1.8
        line4.circleRadius = 4
        line4.setCircleColor(.white)
        line4.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line4.fillColor = .black
        line4.fillAlpha = 0.3
        line4.drawFilledEnabled = true
        line4.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSets: [line1, line2, line3, line4])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        concumptionPreference_ChartView.data = data
        
        
        
        concumptionPreference_ChartView.rightAxis.enabled  = false
        
        concumptionPreference_ChartView.legend.form = .none
        concumptionPreference_ChartView.animate(xAxisDuration: 2.5)
        
    }
    
    @IBAction func btnAction_memberAnalysis_DateFilter(_ sender: Any) {
        btn_SelectDates.tag = 1
     
        openCalender()
    }
    
    @IBAction func btnAction_consumptionAnalysis_DateFilter(_ sender: Any) {
      
        btn_SelectDates.tag = 2
       
        openCalender()
    }
    
    
    @IBAction func btnAction_consumptionPreference_DateFilter(_ sender: Any) {
      
        btn_SelectDates.tag = 3
        openCalender()
    }
    @IBAction func btnAction_Edit_MemberManagementSection(_ sender: Any) {
        memberManagement_EDIT_ModeView.isHidden = false
    }
    
    @IBAction func btnAction_Close_EDIT_Mode_MemberManagement(_ sender: Any) {
        memberManagement_EDIT_ModeView.isHidden = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case consumptionAnalysis_collectionView:
            return 50
        case consumptionPreference_collectionView:
            return 50
        case memberInquiry_collectionView:
            return 50
        case memberManagement_collectionView:
            return 50
        case memberManagement_EDIT_Mode_collectionView:
            return 10
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case consumptionAnalysis_collectionView:
            return 7
        case consumptionPreference_collectionView:
            return 7
        case memberInquiry_collectionView:
            return 9
        case memberManagement_collectionView:
            return 10
        case memberManagement_EDIT_Mode_collectionView:
            return 10
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case consumptionAnalysis_collectionView:
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
//                                if indexPath.row == 0 {
//                                    cell.contentLabel.text = "No."
//                                } else {
//                                    if indexPath.row == 0
//                                    {
//
//                                    }
//                                    else{
                                        cell.contentLabel.text = consumptionAnalysisTabArray[indexPath.row]
                                    //}
                               // }
                
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                   
                } else {
                    
                
                        cell.contentLabel.text = "DATA"
                        cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                
                    
                }
            }
            
            return cell
        case consumptionPreference_collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            //            cell.layer.borderColor = UIColor.blue.cgColor
            //            cell.layer.borderWidth = 5
            
            cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                
//                if indexPath.row == 0 {
//                    cell.contentLabel.text = "No."
//                } else {
//                    if indexPath.row == 0
//                    {
//
//                    }
//                    else{
                        cell.contentLabel.text = consumptionPreferenceTabArray[indexPath.row]
                   // }
               // }
                
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                    
                } else {
                    
                    
                    
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    
                }
            }
            
            return cell
        case memberInquiry_collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            //            cell.layer.borderColor = UIColor.blue.cgColor
            //            cell.layer.borderWidth = 5
            
            cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                
                //                if indexPath.row == 0 {
                //                    cell.contentLabel.text = "No."
                //                } else {
                //                    if indexPath.row == 0
                //                    {
                //
                //                    }
                //                    else{
               // code = \u{21c5}
                cell.contentLabel.text = memberInquiryTabArray[indexPath.row]
                // }
                // }
                
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                    
                } else {
                    
                    
                    
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    
                }
            }
            
            return cell
        case memberManagement_collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            
            cell.statusView.isHidden = true
             cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                
                //                if indexPath.row == 0 {
                //                    cell.contentLabel.text = "No."
                //                } else {
                //                    if indexPath.row == 0
                //                    {
                //
                //                    }
                //                    else{
                let sort_code = "\u{21c5}"
                if indexPath.row == 0
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else  if indexPath.row == 1
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 2
                {
                     cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 3
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 9
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else{
                cell.contentLabel.text = memberManagementTabArray[indexPath.row]
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
        case memberManagement_EDIT_Mode_collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            
            cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
            if indexPath.section == 0 {
                 cell.contentLabel.font = UIFont.systemFont(ofSize: 16)
                let sort_code = "\u{21c5}"
                if indexPath.row == 0
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else  if indexPath.row == 1
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 2
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 3
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else if indexPath.row == 9
                {
                    cell.contentLabel.text = "\(sort_code)\(memberManagementTabArray[indexPath.row])"
                }
                else{
                    cell.contentLabel.text = memberManagementTabArray[indexPath.row]
                }
                
                
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 16)
                    cell.checkBoxView.isHidden = false
                   if checkedUncheckedArray[indexPath.section] == 0
                   {
                    cell.checkBox_Btn.isSelected = false
                    }
                   else{
                    cell.checkBox_Btn.isSelected = true
                    }
                    
                } else {
                    
                    
                    
                    cell.contentLabel.text = "DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    
                }
                cell.checkBox_Btn.addTarget(self, action: #selector(updateCheckedUnchekedData(sender:)), for: .touchUpInside)
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
        case consumptionAnalysis_collectionView:
            print("You selected cell #\(indexPath.item)!")
        case consumptionPreference_collectionView:
            print("You selected cell #\(indexPath.item)!")
        case memberInquiry_collectionView:
            print("You selected cell #\(indexPath.item)!")
        case memberManagement_collectionView:
            print("You selected cell #\(indexPath.item)!")
        case memberManagement_EDIT_Mode_collectionView:
            print("You selected cell #\(indexPath.item)!")
//            selectedIndexItem = indexPath.item
//            items = [1,2,3,4,5,6,7,8,9,0]
//            items = items.reversed()
//            memberManagement_EDIT_Mode_collectionView.reloadData()
        default:
            print("You selected cell #\(indexPath.item)!")
        }
        
    }
    @objc func updateCheckedUnchekedData(sender : UIButton) {
        let buttonPosition = sender.convert(sender.bounds.origin, to: self.memberManagement_EDIT_Mode_collectionView)
        
        if let indexPath = self.memberManagement_EDIT_Mode_collectionView.indexPathForItem(at: buttonPosition)
        {
            let rowIndex = indexPath.section
            print("IP == \(indexPath.section)")
            print(checkedUncheckedArray)
            if checkedUncheckedArray[rowIndex] == 0
            {
                checkedUncheckedArray[rowIndex] = 1
            }
            else
            {
                checkedUncheckedArray[rowIndex] = 0
            }
           
            //let indexPath_Reload = IndexPath(item: rowIndex, section: 0)
            //memberManagement_EDIT_Mode_collectionView.reloadItems(at: [indexPath_Reload])
            memberManagement_EDIT_Mode_collectionView.reloadData()
    }
    }

}
