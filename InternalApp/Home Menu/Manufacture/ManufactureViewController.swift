//
//  ManufactureViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 25/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import Charts
import DropDown
class ManufactureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, FSCalendarDelegate, FSCalendarDataSource {
    
    
    var cusmtomPicker: CustomPickerView!
    @IBOutlet weak var manufacturingStatics_View: UIView!
    @IBOutlet weak var manufacturingData_View: UIView!
    
    @IBOutlet weak var manufacturing_CollectionView: UICollectionView!
    
    @IBOutlet weak var manufacturingStatics_ChartView: LineChartView!
    
   
    @IBOutlet weak var textF_Category: UITextField!
    var manufacturingStaticsChartDataArray1 = [Int]()
    var manufacturingStaticsChartDataArray2 = [Int]()
    var manufacturingStaticsChartDataArray3 = [Int]()
    var manufacturingStaticsChartDataArray4 = [Int]()
    
     var manufacturingStaticsTabArray = ["No.", "Item Id", "Item Name", "Manufacturing Date", "Manager", "Amount", "Unit", "Cost"]
    var manufacturingStaticsDataArray = ["1.", "12344", "Item Name A", "12/03/2020", "Paul", "230", "Kg", "$ 35000"]
    
    
    //
    
    let picker_Category = UIPickerView()
    var arrayOfCategory = ["Cate 1","Cate 2","Cate 3","Cate 4", "Cate option 4","Cate 5"]
    var arrayOfDate = ["Date 1","Date 2","Date 3","Date 4", "Dae 4","Date 5"]
    var activeTextField = 0
    //
    
    // DROPDOWS---
    var manufactureStaticsFilter_DropDown = DropDown()
    
    @IBOutlet weak var filter_imageView: UIImageView!
    @IBOutlet weak var btn_manufactureFilter: UIButton!
    
    @IBOutlet weak var btn_manufactureFilterDate: UIButton!
    @IBOutlet weak var manufactureFilterView: UIView!
    @IBOutlet weak var date_imagView: UIImageView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manufacturingData_View.layer.cornerRadius = 8
        manufacturingData_View.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        manufacturing_CollectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "ContentCellIdentifier")
        
        manufacturingStaticsChartDataArray1 = [0, 40, 60, 30]
        manufacturingStaticsChartDataArray2 = [36, 40, 20, 50]
        manufacturingStaticsChartDataArray3 = [100, 0, 20, 80]
        manufacturingStaticsChartDataArray4 = [40, 10, 60, 30]
        updateManufacturingStaticsChart()
        
//        textF_Category.delegate = self
//        textF_Category.inputView = picker_Category
//        textF_Category.tintColor = UIColor.clear
        
        
        
        //setUP_PickerView_UI()
        //createToolbar()
        textF_Category.isHidden  = true
        
        manufactureStaticsFilter_DropDown.dataSource = arrayOfCategory
        manufactureStaticsFilter_DropDown.cornerRadius = 8
        manufactureStaticsFilter_DropDown.anchorView = manufactureFilterView
        manufactureStaticsFilter_DropDown.textFont = UIFont.systemFont(ofSize: 17)
        manufactureStaticsFilter_DropDown.selectionBackgroundColor = UIColor.black
       manufactureStaticsFilter_DropDown.direction = .any
        manufactureStaticsFilter_DropDown.selectedTextColor = UIColor.yellow
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        
        
       
    }
    
    @IBAction func btnAction_openDate(_ sender: Any) {
        openCalender()
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
           
           
                btn_manufactureFilterDate.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
           
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
    @IBAction func btnAction_openCategory(_ sender: Any) {
       manufactureStaticsFilter_DropDown.show()
        manufactureStaticsFilter_DropDown.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_manufactureFilter.setTitle(item, for: .normal)
          
            
        }
        
    }
    func setUP_PickerView_UI() {
        cusmtomPicker = CustomPickerView()
        picker_Category.delegate = cusmtomPicker
        picker_Category.dataSource = cusmtomPicker
        picker_Category.delegate?.pickerView?(cusmtomPicker, didSelectRow: 0, inComponent: 0)
        picker_Category.backgroundColor = UIColor.yellow
      
    }
  
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        switch textField {
//        case textF_Category:
//            activeTextField = 1
//            cusmtomPicker.dataArray = arrayOfCategory
//            picker_Category.reloadAllComponents()
//        default:
//            activeTextField = 0
//        }
//        
//    }
    
    func createToolbar()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.yellow
        toolbar.barStyle = .black
        toolbar.backgroundColor = UIColor.black
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ManufactureViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textF_Category.inputAccessoryView = toolbar
        
    }
    
    @objc func closePickerView()
    {
        view.endEditing(true)
        print(cusmtomPicker.pickedValue!)
        switch activeTextField {
       
        case 1:
            textF_Category.text = cusmtomPicker.pickedValue
        default:
            textF_Category.text = ""
        }
        
        
    }
    
    
   
    @IBAction func btnAction_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateManufacturingStaticsChart() {
        var lineChartEntry1 = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        var lineChartEntry3 = [ChartDataEntry]()
        var lineChartEntry4 = [ChartDataEntry]()
        
        for i in 0..<manufacturingStaticsChartDataArray1.count{
            let value = ChartDataEntry(x: Double(i), y: Double(manufacturingStaticsChartDataArray1[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry1.append(value) // here we add it to the data set
        }
        for i in 0..<manufacturingStaticsChartDataArray2.count{
            let value = ChartDataEntry(x: Double(i), y: Double(manufacturingStaticsChartDataArray2[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry2.append(value) // here we add it to the data set
        }
        for i in 0..<manufacturingStaticsChartDataArray3.count{
            let value = ChartDataEntry(x: Double(i), y: Double(manufacturingStaticsChartDataArray3[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry3.append(value) // here we add it to the data set
        }
        for i in 0..<manufacturingStaticsChartDataArray4.count{
            let value = ChartDataEntry(x: Double(i), y: Double(manufacturingStaticsChartDataArray4[i])) // here we set the X and Y status in a data chart entry
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
        
        manufacturingStatics_ChartView.data = data
        
        
        
        manufacturingStatics_ChartView.rightAxis.enabled  = false
        
        manufacturingStatics_ChartView.legend.form = .none
        manufacturingStatics_ChartView.animate(xAxisDuration: 2.5)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case manufacturing_CollectionView:
            return 50
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case manufacturing_CollectionView:
            return 8
       
        default:
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case manufacturing_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCellIdentifier",
                                                          for: indexPath) as! ContentCollectionViewCell
            
            
            cell.backgroundColor = UIColor.white
            
            cell.statusView.isHidden = true
            cell.checkBoxView.isHidden = true
            
            if indexPath.section == 0 {
                
                cell.contentLabel.text = manufacturingStaticsTabArray[indexPath.row]
                
                
            } else {
                if indexPath.row == 0 {
                    cell.contentLabel.text = String(indexPath.section)
                    
                } else {
                    
                    
                    
                    cell.contentLabel.text = manufacturingStaticsDataArray[indexPath.row]//"DATA"
                    cell.contentLabel.font = UIFont.systemFont(ofSize: 14)
                    
                    
                }
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

    }
//    func open_Picker() {
//        let picker: UIPickerView
//        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
//        picker.backgroundColor = .white
//
//        picker.showsSelectionIndicator = true
//        picker.delegate = self
//        picker.dataSource = self
//
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
//
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//       // textField1.inputView = picker
//        //textField1.inputAccessoryView = toolBar
//    }
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//       // textField1.text = pickerData[row]
//    }
//
//     @objc func donePicker() {
//
//       // textField1.resignFirstResponder()
//
//    }
}
