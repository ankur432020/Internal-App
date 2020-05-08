//
//  StoreManagementViewController.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 12/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit
import DropDown
class StoreManagementViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var btn_ImageAdvertising: UIButton!
    @IBOutlet weak var btn_VideoAdvertising: UIButton!
    
    @IBOutlet weak var btn_ImageGallery: UIButton!
    
    @IBOutlet weak var btn_VideoGallery: UIButton!
    
    @IBOutlet weak var videoGalleryView: UIView!
    
    @IBOutlet weak var imageGallery_CollectionView: UICollectionView!
    
    @IBOutlet weak var imageGalleryView: UIView!
    @IBOutlet weak var videoGallery_CollectionView: UICollectionView!
    
    @IBOutlet weak var advertismentView: UIView!
    
    @IBOutlet weak var imageAdvert_BGView: UIView!
    @IBOutlet weak var customerResponseView: UIView!
    
    @IBOutlet weak var videoAdvert_BGView: UIView!
    
    @IBOutlet weak var responseTableView: UITableView!
    
    // DROPDOWS ---
    var dropDown_customerResponseFilter = DropDown()
    
    // AnchorViews ---
     @IBOutlet weak var customerResponseFilterView: UIView!
    
    @IBOutlet weak var btn_customerResponse_DateFilter: UIButton!
    @IBOutlet weak var btn_customerResponseFilter: UIButton!
    
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
        advertismentView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
         customerResponseView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 10, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        
        imageAdvert_BGView.layer.cornerRadius = 16
        
        imageAdvert_BGView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 8, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        btn_ImageAdvertising.layer.cornerRadius = 16
        
        btn_ImageAdvertising.dropShadowWithBorder(borderWidth: 8, borderColor: .white, shadowColor: .clear, shadowRadius: 0, shadowOffset: CGSize.zero, shadowOpacity: 0)
        btn_ImageAdvertising.clipsToBounds = true
        
        
        
        
        
        videoAdvert_BGView.layer.cornerRadius = 16
        videoAdvert_BGView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 8, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.8)
        btn_VideoAdvertising.layer.cornerRadius = 16
        btn_VideoAdvertising.dropShadowWithBorder(borderWidth: 8, borderColor: .white, shadowColor: .clear, shadowRadius: 0, shadowOffset: CGSize.zero, shadowOpacity: 0)
        btn_VideoAdvertising.clipsToBounds = true
        
        
        
        imageGalleryView.layer.cornerRadius = 16
        imageGalleryView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 4, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.4)
        btn_ImageGallery.layer.cornerRadius = 16
        btn_ImageGallery.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        
        videoGalleryView.layer.cornerRadius = 16
        videoGalleryView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray, shadowColor: UIColor.gray, shadowRadius: 4, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.4)
        btn_VideoGallery.layer.cornerRadius = 16
        btn_VideoGallery.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        imageGallery_CollectionView.layer.cornerRadius = 16
        videoGallery_CollectionView.layer.cornerRadius = 16
        
        
        dropDown_customerResponseFilter.dataSource = ["Customer Res 1", "Customer Res 2", "Customer Res 3", "Customer Res 4", "Customer Res 5"]
        dropDown_customerResponseFilter.cornerRadius = 8
        dropDown_customerResponseFilter.anchorView = customerResponseFilterView
        dropDown_customerResponseFilter.textFont = UIFont.systemFont(ofSize: 17)
        dropDown_customerResponseFilter.selectionBackgroundColor = UIColor.black
        dropDown_customerResponseFilter.selectedTextColor = UIColor.yellow
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.closePopUpView (_:)))
        self.bgView.addGestureRecognizer(gesture)
        
        
    }
    
    
    @IBAction func backBtn_Action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAction_customerResponse_DateFilter(_ sender: Any) {
        openCalender()
    }
    
    @IBAction func btnAction_customerResponseFilter(_ sender: Any) {
        dropDown_customerResponseFilter.show()
        dropDown_customerResponseFilter.selectionAction = {
            [weak self] (index, item) in
            print(index, item)
            self?.btn_customerResponseFilter.setTitle(item, for: .normal)
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
            
            
            btn_customerResponse_DateFilter.setTitle("\(checkIn_Date)-\(checkOut_Date)", for: .normal)
            
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageGallery_CollectionView:
            return 5
        case  videoGallery_CollectionView:
            return 5
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageGallery_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageGalleryCell", for: indexPath as IndexPath)
            
            
             let cellView : UIView = cell.viewWithTag(1)!
            
            //cellView.backgroundColor = UIColor.red
             cellView.dropShadowWithBorder(borderWidth: 5, borderColor: .white, shadowColor: .clear, shadowRadius: 0, shadowOffset: CGSize.zero, shadowOpacity: 0)
            cellView.clipsToBounds = true
          // cell.backgroundColor = UIColor.red
            
            return cell
        case videoGallery_CollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoGalleryCell", for: indexPath as IndexPath)
            
            
            let cellView : UIView = cell.viewWithTag(1)!
            
            //cellView.backgroundColor = UIColor.red
            cellView.dropShadowWithBorder(borderWidth: 5, borderColor: .white, shadowColor: .clear, shadowRadius: 0, shadowOffset: CGSize.zero, shadowOpacity: 0)
            cellView.clipsToBounds = true
            
         //   cell.backgroundColor = UIColor.blue
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoGalleryCell", for: indexPath as IndexPath)
            
            
            //let cellView : UIView = cell.viewWithTag(1)!
            
            //cellView.backgroundColor = UIColor.red
            // cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
            
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "responseCell") as UITableViewCell?)!
        cell.selectionStyle = .none
        
        let cellView : UIView = cell.viewWithTag(1)!
        cellView.dropShadowWithBorder(borderWidth: 1, borderColor: UIColor.lightGray.withAlphaComponent(0.2), shadowColor: UIColor.lightGray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        
        let profile_ImageView : UIImageView = cell.viewWithTag(2) as! UIImageView
        profile_ImageView.layer.cornerRadius = profile_ImageView.frame.size.width / 2
        profile_ImageView.layer.masksToBounds = false
        profile_ImageView.dropShadowWithBorder(borderWidth: 3, borderColor: UIColor.white, shadowColor: UIColor.gray, shadowRadius: 5, shadowOffset: CGSize(width: -1, height: 1), shadowOpacity: 0.5)
        let reply_Btn : UIButton = cell.viewWithTag(4) as! UIButton
         reply_Btn.layer.cornerRadius = reply_Btn.frame.size.width / 2
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
