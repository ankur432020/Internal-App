//
//  SalesViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 13/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import UICircularProgressRing
import Charts
import DropDown

class SalesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource {
    
    
    @IBOutlet weak var promotionalTableView: UITableView!
    
    @IBOutlet weak var abnormalSalesData_CollectionView: UICollectionView!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var abnormalSales_TabMenu_CollectionView: UICollectionView!
    
    @IBOutlet weak var salesDataView: UIView!
    var currentSalesProgressRing = UICircularProgressRing()
    var outOfStockProgressRing = UICircularProgressRing()
    
    @IBOutlet weak var totalSaleView: UIView!
    @IBOutlet weak var outOfStockView: UIView!
    @IBOutlet weak var currentSaleView: UIView!
    
    @IBOutlet weak var merchandisingView: UIView!
    
    @IBOutlet weak var cashReconciliationView: UIView!
    
    @IBOutlet weak var dailyBusinessView: UIView!
    
    @IBOutlet weak var categorySalesView: UIView!
    
    @IBOutlet weak var abnormalSalesView: UIView!
    
    @IBOutlet weak var promotionalSalesView: UIView!
    
    
    @IBOutlet weak var merchandisingTableView: UITableView!
    var timerForShowScrollIndicator: Timer?
    
    var cashReconciliationCollectedDataArray = [String]()
    var cashReconciliationSalesDataArray = [String]()
    @IBOutlet weak var cashReconciliation_TableView: UITableView!
    
    
    @IBOutlet weak var btn_merchandisingFilter: UIButton!
    
    @IBOutlet weak var btn_salesCategoryFilter: UIButton!
    @IBOutlet weak var btn_dailyBusinessFilter: UIButton!
    
    @IBOutlet weak var dailyBusiness_ChatView: LineChartView!
    
    @IBOutlet weak var salesCategory_ChartView: LineChartView!
    var dailyBusinessChartDataArray = [Int]()
    var salesCategoryChartDataArray1 = [Int]()
    var salesCategoryChartDataArray2 = [Int]()
    var salesCategoryChartDataArray3 = [Int]()
    var salesCategoryChartDataArray4 = [Int]()
    var selectedTabIndex = 0
    var abnormalSalesTabsArray = [String]()
    var abnormalSalesDataArray = [String]()
    
    // DROPDOWS ---
    var dropDown_merchandising = DropDown()
    var dropDown_businessDaily = DropDown()
    var dropDown_salesCategory = DropDown()
    
    // AnchorViews ---
    @IBOutlet weak var merchandisingFilterView: UIView!
    @IBOutlet weak var dailyBusinessgFilterView: UIView!
    @IBOutlet weak var salesCategoryFilterView: UIView!
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
    var selected_Date = ""
    //
    
    @IBOutlet weak var btn_SalesDate: UIButton!
    
    @IBOutlet weak var btn_AbnormalSalesDateFilter: UIButton!
    var bgView = UIView()
    var currentSale_Value = 0
    
    @IBOutlet weak var totalSales_Lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        currentSaleView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        setUpCurrentSaleView()
        currentSaleView.addSubview(currentSalesProgressRing)
        
        outOfStockView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        setUpOutOfStockView()
        outOfStockView.addSubview(outOfStockProgressRing)
        
        totalSaleView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        merchandisingView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        cashReconciliationView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        dailyBusinessView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        categorySalesView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        abnormalSalesView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        promotionalSalesView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        cashReconciliationCollectedDataArray = ["","Cash Collected","Check Collected","  Credit Cards Collected","Coupons Collected",""]
        cashReconciliationSalesDataArray = ["","Cash Sales","Check Sales","Credit Cards Sales","Coupons Sales",""]
        
        
        dailyBusinessChartDataArray = [0, 50, 100]
        salesCategoryChartDataArray1 = [10, 40, 60, 20]
        salesCategoryChartDataArray2 = [30, 40, 20, 50]
        salesCategoryChartDataArray3 = [80, 30, 20, 80]
        salesCategoryChartDataArray4 = [40, 20, 60, 30]
        
        updateDailyBusinessChart()
        updateSalesCategoryChart()
        abnormalSalesTabsArray = ["Returns", "Refunds", "Cancelled", "Exchanges"]
        abnormalSalesDataArray = ["","Item Name", "Buyer Name", "Coupon Code", "No. of Items", "Price Per Item", "Total Price", "Pay Mode"]
        abnormalSalesData_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "ContentCellIdentifier")
        
        
        setup_DropDowns_UI()
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        totalSales_Lbl.text = "\(0)"
       getCurrentSale_Method()
        getOutOfStock_Method()
        getTotalSale_Method()
    }
    
    func setup_DropDowns_UI(){
        
        dropDown_merchandising.dataSource = ["mer 1", "mer 2", "mer 3", "mer 4", "mer 5"]
        dropDown_merchandising.anchorView = merchandisingFilterView
        dropDown_merchandising.cornerRadius = 8
        dropDown_merchandising.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_merchandising.selectionBackgroundColor = UIColor.black
        dropDown_merchandising.selectedTextColor = UIColor.yellow
        
        
        dropDown_businessDaily.dataSource = ["businessDaily 1", "businessDaily 2", "businessDaily 3", "businessDaily 4", "businessDaily 5"]
        dropDown_businessDaily.anchorView = dailyBusinessgFilterView
        dropDown_businessDaily.cornerRadius = 8
        dropDown_businessDaily.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_businessDaily.selectionBackgroundColor = UIColor.black
        dropDown_businessDaily.selectedTextColor = UIColor.yellow
        
        
        dropDown_salesCategory.dataSource = ["salesCategory 1", "salesCategory 2", "salesCategory 3", "salesCategory 4", "salesCategory 5"]
        dropDown_salesCategory.anchorView = salesCategoryFilterView
        dropDown_salesCategory.cornerRadius = 8
        dropDown_salesCategory.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_salesCategory.selectionBackgroundColor = UIColor.black
        dropDown_salesCategory.selectedTextColor = UIColor.yellow
    
    }
    //MARK:- Method to close PopUpView
    @objc func closePopUpView(_ sender:UITapGestureRecognizer){
        firstDate = nil
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    @IBAction func btnAction_MerchandisingFilter(_ sender: Any) {
        dropDown_merchandising.show()
        dropDown_merchandising.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_merchandisingFilter.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnAction_DailyBusinessFilter(_ sender: Any) {
        dropDown_businessDaily.show()
        dropDown_businessDaily.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_dailyBusinessFilter.setTitle(item, for: .normal)
        }
    }
    
    
    @IBAction func btnAction_SalesCategoryFilter(_ sender: Any) {
        dropDown_salesCategory.show()
        dropDown_salesCategory.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_salesCategoryFilter.setTitle(item, for: .normal)
        }
    }
    func updateDailyBusinessChart() {
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<dailyBusinessChartDataArray.count{
            let value = ChartDataEntry(x: Double(i), y: Double(dailyBusinessChartDataArray[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [NSUIColor.darkGray] //Sets the colour to blue
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        line1.mode = .horizontalBezier
        line1.drawCirclesEnabled = false
        line1.lineWidth = 1.8
        line1.circleRadius = 4
        line1.setCircleColor(.white)
        line1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        line1.fillColor = .darkGray
        line1.fillAlpha = 0.3
        line1.drawFilledEnabled = true
        line1.drawHorizontalHighlightIndicatorEnabled = false
        
        //line1.fillFormatter = CubicLineSampleFillFormatter()
        dailyBusiness_ChatView.data = data //finally - it adds the chart data to the chart and causes an update
        dailyBusiness_ChatView.chartDescription?.text = "" // Here we set the description for the graph
        dailyBusiness_ChatView.rightAxis.enabled  = false
        
        dailyBusiness_ChatView.legend.form = .none
        dailyBusiness_ChatView.animate(xAxisDuration: 2.5)
        
    }
    func openCalendar()  {
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
        calendar.allowsMultipleSelection = false
        
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
        if firstDate != nil
        {
            firstDate = date
            return
        }
        // only first date is selected:
       /* if firstDate != nil && lastDate == nil {
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
        }*/
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
//        return minDate!
//    }
    @objc  func getAndSetDates(sender:UIButton) {
        print("PREVIOUS START DATE = \(firstDate ?? Date())")
       
        
        
        if firstDate != nil{
            let dateFormatterGET = DateFormatter()
            
            dateFormatterGET.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateFormatterSET = DateFormatter()
           //dateFormatterSET.dateFormat = "yyyy-MM-dd"
            dateFormatterSET.dateFormat = "dd-MM-yyyy"
            let newStartDate = dateFormatterSET.string(from: firstDate!)
            
            print("CURRENT START DATE = \(newStartDate)")
            
            selected_Date = newStartDate
            if sender.tag == 10{
                btn_SalesDate.setTitle(selected_Date, for: .normal)}
            else
            {
                btn_AbnormalSalesDateFilter.setTitle(selected_Date, for: .normal)
            }
    
            closeCalendar()
        }
        else{
            self.view.makeToast("Please select date.")
            selected_Date = ""
        }
        //2020-02-21
    }
    func closeCalendar() {
        bgView.isHidden = true
        calendar.isHidden = true
        btn_OverLay.isHidden = true
        btn_SelectDates.isHidden = true
    }
    func updateSalesCategoryChart() {
        var lineChartEntry1 = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var lineChartEntry3 = [ChartDataEntry]()
        var lineChartEntry4 = [ChartDataEntry]()
        
        for i in 0..<salesCategoryChartDataArray1.count{
            let value = ChartDataEntry(x: Double(i), y: Double(salesCategoryChartDataArray1[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry1.append(value) // here we add it to the data set
        }
        for i in 0..<salesCategoryChartDataArray2.count{
            let value = ChartDataEntry(x: Double(i), y: Double(salesCategoryChartDataArray2[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry2.append(value) // here we add it to the data set
        }
        for i in 0..<salesCategoryChartDataArray3.count{
            let value = ChartDataEntry(x: Double(i), y: Double(salesCategoryChartDataArray3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry3.append(value) // here we add it to the data set
        }
        for i in 0..<salesCategoryChartDataArray4.count{
            let value = ChartDataEntry(x: Double(i), y: Double(salesCategoryChartDataArray4[i])) // here we set the X and Y status in a data chart entry
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
        
        salesCategory_ChartView.data = data
        
        
        
        salesCategory_ChartView.rightAxis.enabled  = false
        
        salesCategory_ChartView.legend.form = .none
        salesCategory_ChartView.animate(xAxisDuration: 2.5)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startTimerForShowScrollIndicator()
    }
    
    @IBAction func btnAction_openDate(_ sender: Any) {
        btn_SelectDates.tag = 10
        openCalendar()
      
    }
    
    @IBAction func btnAction_abnormalSales_DateFilter(_ sender: Any) {
        btn_SelectDates.tag = 20
        openCalendar()
    }
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.0001) {
            self.merchandisingTableView.flashScrollIndicators()
        }
    }
    
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    } 
    
    func setUpCurrentSaleView() {
        
        var view_Width = 0.0
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            
            view_Width = 118.0
        case .pad:
            
            view_Width = 235.0
        case .unspecified:
            view_Width = 118.0
        case .tv:
            view_Width = 118.0
        case .carPlay:
            view_Width = 118.0
        @unknown default:
            view_Width = 118.0
        }
        currentSalesProgressRing = UICircularProgressRing(frame: CGRect(x: (view_Width / 2.2 ) - 40, y: -2, width: 80, height: 80))
        // Change any of the properties you'd like
        //  currentSalesProgressRing.center = currentSaleView.center
        currentSalesProgressRing.maxValue = 0
        currentSalesProgressRing.minValue = 0
        currentSalesProgressRing.value = 0
        let formatter = UICircularProgressRingFormatter.init(valueIndicator: " CNY", rightToLeft: false, showFloatingPoint: false, decimalPlaces: 0)
        currentSalesProgressRing.valueFormatter = formatter
        currentSalesProgressRing.font = UIFont.systemFont(ofSize: 10)
        
        currentSalesProgressRing.innerRingColor = UIColor.green
        currentSalesProgressRing.outerRingColor = UIColor.clear
        currentSalesProgressRing.innerRingWidth = 1
        currentSalesProgressRing.outerRingWidth = 1
        currentSalesProgressRing.style = .bordered(width:1, color: UIColor.lightGray)
        let knobStyle = UICircularRingValueKnobStyle.init(size: 10.0, color: UIColor.green, path: UICircularRingValueKnobPath.oval, shadowBlur: 0.0, shadowOffset: CGSize.zero, shadowColor: .green, image: nil, imageTintColor: nil, imageInsets: .zero)
        currentSalesProgressRing.valueKnobStyle = knobStyle
    }
    
    func setUpOutOfStockView() {
        var view_Width = 0.0
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            
            view_Width = 118.0
        case .pad:
            
            view_Width = 235.0
        case .unspecified:
            view_Width = 118.0
        case .tv:
            view_Width = 118.0
        case .carPlay:
            view_Width = 118.0
        @unknown default:
            view_Width = 118.0
        }
        outOfStockProgressRing = UICircularProgressRing(frame: CGRect(x: (view_Width / 2.2 ) - 40, y: -2, width: 80, height: 80))
        // Change any of the properties you'd like
        // outOfStockProgressRing.center = currentSaleView.center
        
        outOfStockProgressRing.minValue = 0
       
        let formatter = UICircularProgressRingFormatter.init(valueIndicator: " items", rightToLeft: false, showFloatingPoint: false, decimalPlaces: 0)
        outOfStockProgressRing.valueFormatter = formatter
        outOfStockProgressRing.font = UIFont.systemFont(ofSize: 10)
        
        outOfStockProgressRing.innerRingColor = UIColor.green
        outOfStockProgressRing.outerRingColor = UIColor.clear
        outOfStockProgressRing.innerRingWidth = 1
        outOfStockProgressRing.outerRingWidth = 1
        outOfStockProgressRing.style = .bordered(width:1, color: UIColor.lightGray)
        var knobColor = UIColor()
        if outOfStockProgressRing.maxValue == outOfStockProgressRing.value {
            knobColor = UIColor.clear
        }
        else
        {
            knobColor = UIColor.green
        }
        let knobStyle = UICircularRingValueKnobStyle.init(size: 10.0, color: knobColor, path: UICircularRingValueKnobPath.oval, shadowBlur: 0.0, shadowOffset: CGSize.zero, shadowColor: .green, image: nil, imageTintColor: nil, imageInsets: .zero)
        
        outOfStockProgressRing.valueKnobStyle = knobStyle
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case merchandisingTableView:
            return 10
        case cashReconciliation_TableView:
            return 6
        case promotionalTableView:
            return 20
        default:
            return 0
        }
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case merchandisingTableView:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "merchandisingDataCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            let itemName_lbl : UILabel = cell.viewWithTag(1) as! UILabel
            let slider : CustomSlider = cell.viewWithTag(2) as! CustomSlider
            let itemValue_lbl : UILabel = cell.viewWithTag(3) as! UILabel
            
            
            slider.setThumbImage(UIImage(), for: .normal)
            itemName_lbl.text = "Food Product"
            itemValue_lbl.text = "4000/4000"
            if indexPath.row == 0 {
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
            {print(indexPath.row)
                slider.value = 30
            }
            else
            {
                slider.value = 60
            }
            return cell
        case cashReconciliation_TableView:
            if indexPath.row == 0
            {
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cashRecHeaderCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == 5
            {
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cashRecTotalCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                let totalCollected_lbl: UILabel = cell.viewWithTag(11) as! UILabel
                let totalRecorded_lbl: UILabel = cell.viewWithTag(22) as! UILabel
                let totalDifference_lbl: UILabel = cell.viewWithTag(33) as! UILabel
                totalCollected_lbl.text = "11"
                totalRecorded_lbl.text = "22"
                totalDifference_lbl.text = "33"
                
                return cell
            }
            else {
                let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cashRecDataCell") as UITableViewCell?)!
                cell.selectionStyle = .none
                let collectedData_lbl: UILabel = cell.viewWithTag(1) as! UILabel
                let collectedDataValue_lbl: UILabel = cell.viewWithTag(2) as! UILabel
                let salesData_lbl: UILabel = cell.viewWithTag(3) as! UILabel
                let salesDataValue_lbl: UILabel = cell.viewWithTag(4) as! UILabel
                let differenceValue_lbl: UILabel = cell.viewWithTag(5) as! UILabel
                print("hello \(indexPath.row)")
                collectedData_lbl.adjustsFontSizeToFitWidth = true
                salesData_lbl.adjustsFontSizeToFitWidth = true
                collectedData_lbl.text = cashReconciliationCollectedDataArray[indexPath.row]
                salesData_lbl.text = cashReconciliationSalesDataArray[indexPath.row]
                if indexPath.row == 1
                {
                    collectedDataValue_lbl.text = "100"
                    salesDataValue_lbl.text = "60"
                    differenceValue_lbl.text = "40"
                }
                else if indexPath.row == 2
                {
                    collectedDataValue_lbl.text = "100"
                    salesDataValue_lbl.text = "50"
                    differenceValue_lbl.text = "50"
                }
                else if indexPath.row == 3
                {
                    collectedDataValue_lbl.text = "100"
                    salesDataValue_lbl.text = "160"
                    differenceValue_lbl.text = "-60"
                }
                else if indexPath.row == 4
                {
                    collectedDataValue_lbl.text = "200"
                    salesDataValue_lbl.text = "30"
                    differenceValue_lbl.text = "170"
                }
                else
                {
                    collectedDataValue_lbl.text = ""
                    salesDataValue_lbl.text = ""
                    differenceValue_lbl.text = ""
                }
                
                
                return cell
            }
        case promotionalTableView:
            
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "promotionalDataCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            return cell
        default:
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "merchandisingDataCell") as UITableViewCell?)!
            cell.selectionStyle = .none
            
            
            
            
            return cell
        }
        
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
       
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case merchandisingTableView:
            return 44
        case cashReconciliation_TableView:
            if indexPath.row == 0
            {
                return 42
            }
            else if indexPath.row == 5
            {
                return 44
            }
            else
            {
                return 43
            }
        case promotionalTableView:
            return 60
        default:
            return 0
        }
    }
    
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
             self.abnormalSales_TabMenu_CollectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        default:
            abnormalSales_TabMenu_CollectionView.reloadData()
        }
       
    }
    func getCurrentSale_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_CURRENT_SALE
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
             
                    if let sum = responseJSONs["sum"] as? Int
                    {
                        //self.currentSale_Value = sum
                        print("CUURENT SALE == \(sum)")
                        DispatchQueue.main.async {
                        self.currentSalesProgressRing.maxValue = 100000
                        self.currentSalesProgressRing.value = CGFloat(sum)
                            appDelegate.hideHUD()
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
    
    func getOutOfStock_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_OUT_OF_STOCK
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
                DispatchQueue.main.async {
                    self.outOfStockProgressRing.maxValue = CGFloat(responseJSONs.count)
                    
                    self.outOfStockProgressRing.value = CGFloat(responseJSONs.count)
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
    
    
    func getTotalSale_Method() {
        appDelegate.showHUD(withMessage: msg_PLEASE_WAIT)
        let url1 = BASE_URL + k_API_GET_TOTAL_SALE
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
                if let sum = responseJSONs["sum"] as? Int
                {
                    //self.currentSale_Value = sum
                    print("TOTAL SALE == \(sum)")
                    DispatchQueue.main.async {
                        self.totalSales_Lbl.text = "\(sum)"
                        appDelegate.hideHUD()
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
}

