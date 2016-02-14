import UIKit
import SwiftyJSON

class SmCalculatorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let advancedOptionsViewHeight: CGFloat = 120
    let eventTimeViewHeight: CGFloat = 90
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var calculatorCardView: UIView!
    @IBOutlet weak var advancedOptionsView: UIView!
    @IBOutlet weak var eventTimeView: UIView!
    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var objectivePoints: UITextField!
    @IBOutlet weak var currentPoints: UITextField!
    @IBOutlet weak var currentRank: UITextField!
    @IBOutlet weak var playRank: UIPickerView!
    @IBOutlet weak var oncePoints: UILabel!
    
    @IBOutlet weak var wastedLpEveryDay: UITextField!
    @IBOutlet weak var isChineseExp: UISwitch!
    @IBOutlet weak var currentLp: UITextField!
    @IBOutlet weak var currentExp: UITextField!
    @IBOutlet weak var songDifficulty: UIPickerView!
    @IBOutlet weak var songRank: UIPickerView!
    @IBOutlet weak var eventEndDay: UITextField!
    @IBOutlet weak var eventEndHour: UITextField!
    @IBOutlet weak var eventLastHour: UITextField!

    let playRankData = ["平均", "第一名", "第二名", "第三名", "第四名"]
    let difficultyData = ["Expert", "Hard", "Normal", "Easy"]
    let songRankData = ["S", "A", "B", "C", "-"]
    let difficultyBasicPointArray = ["Expert": 272.0, "Hard": 163.0, "Normal": 89.0, "Easy": 36.0]
    let playRankArray = ["平均": 1.1125, "第一名": 1.25, "第二名": 1.15, "第三名": 1.05, "第四名": 1.00]
    let songRankArray = ["S": 1.20, "A": 1.15, "B": 1.10, "C": 1.05, "-": 1.00]
    
    @IBAction func advancedOptionsButton(sender: UIButton) {
        cardViewHeight.constant -= eventTimeView.hidden ? 0 : eventTimeViewHeight
        eventTimeView.hidden = true
        if advancedOptionsView.hidden == true {
            cardViewHeight.constant += advancedOptionsViewHeight
            advancedOptionsView.hidden = false
        } else {
            cardViewHeight.constant -= advancedOptionsViewHeight
            advancedOptionsView.hidden = true
        }
    }
    
    @IBAction func EventTimeButton(sender: UIButton) {
        cardViewHeight.constant -= advancedOptionsView.hidden ? 0 : advancedOptionsViewHeight
        advancedOptionsView.hidden = true
        if eventTimeView.hidden == true {
            cardViewHeight.constant += eventTimeViewHeight
            eventTimeView.hidden = false
        } else {
            cardViewHeight.constant -= eventTimeViewHeight
            eventTimeView.hidden = true
        }
    }
    
    override func viewDidLoad() {
        setBackground()
        initCalculatorCardView()
        initEventTimePanel()
    }
    
    func initCalculatorCardView() {
        advancedOptionsView.hidden = true
        eventTimeView.hidden = true
        setPicker()
        setShadowForView(calculatorCardView)
        setShadowForView(calculateButton)
    }
    
    func initEventTimePanel() {
        fillEventEndTime()
        eventEndDay.delegate = self
        eventEndDay.addTarget(self, action: "eventEndDayDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        eventEndHour.delegate = self
        eventEndHour.addTarget(self, action: "eventEndHourDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func setPicker() {
        playRank.delegate = self
        playRank.dataSource = self
        playRank.showsSelectionIndicator = false
        
        songDifficulty.delegate = self
        songDifficulty.dataSource = self
        songDifficulty.showsSelectionIndicator = false
        
        songRank.delegate = self
        songRank.dataSource = self
        songRank.showsSelectionIndicator = false
    }
    
    func setBackground() {
        scrollView.backgroundColor = Color.Blue50()
        calculateButton.backgroundColor = Color.Blue100()
        objectivePoints.backgroundColor = Color.Blue50()
        currentPoints.backgroundColor = Color.Blue50()
        currentRank.backgroundColor = Color.Blue50()
        wastedLpEveryDay.backgroundColor = Color.Blue50()
        currentLp.backgroundColor = Color.Blue50()
        currentExp.backgroundColor = Color.Blue50()
        eventEndDay.backgroundColor = Color.Blue50()
        eventEndHour.backgroundColor = Color.Blue50()
        eventLastHour.backgroundColor = Color.Blue50()
    }
    
    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView) {
        case playRank: return playRankData.count
        case songDifficulty: return difficultyData.count
        case songRank: return songRankData.count
        default: return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView) {
        case playRank: return playRankData[row]
        case songDifficulty: return difficultyData[row]
        case songRank: return songRankData[row]
        default: return ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CalculateReport" {
            let calculateReportController = segue.destinationViewController as! CalculateReportController
            
//            let calculatorFactory = CalculatorFactory(objectivePoints: objectivePoints.text, currentPoints: currentPoints.text,
//                currentRank: currentRank.text, wastedLpEveryDay: wastedLpEveryDay.text, currentLp: currentLp.text,
//                currentExperience: currentExp.text, eventEndDay: eventEndDay.text, eventLastTime: eventLastHour.text,
//                currentItem: currentItems.text, eventDifficulty: eventDifficultyData[eventDifficulty.selectedRowInComponent(0)],
//                eventRank: eventRankData[eventRank.selectedRowInComponent(0)],
//                eventCombo: eventComboData[eventCombo.selectedRowInComponent(0)],
//                oncePoints: oncePoints.text, consumeLp: consumeLp.text, isChineseExp: isChineseExp.on)
//            calculatorFactory.calculateNormalProcess()
            
//            setReportFields(calculateReportController, calculatorFactory: calculatorFactory)
        }
    }
    
    func setReportFields(calculateReportController: CalculateReportController, calculatorFactory: CalculatorFactory) {
        calculateReportController.totalLoveCard = calculatorFactory.getLovecaAmount()
        calculateReportController.finalPoints = calculatorFactory.getFinalPoints()
        calculateReportController.finalRank = calculatorFactory.getFinalRank()
        calculateReportController.finalExp = String(format: "\(calculatorFactory.getFinalExp())/\(calculatorFactory.getCurrentRankUpExp())")
        calculateReportController.finalLp = calculatorFactory.getFinalLp()
        calculateReportController.finalItems = calculatorFactory.getFinalItem()
        calculateReportController.playFrequency = calculatorFactory.getTimesNeedToPlay()
        calculateReportController.eventFrequency = calculatorFactory.getEventTimesNeedToPlay()
        calculateReportController.totalTime = calculatorFactory.getTotalPlayTime()
        calculateReportController.playTimeRatio = calculatorFactory.getPlayTimeRatio()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateOncePoints()
    }
    
    func updateOncePoints() {
        let difficulty = difficultyData[songDifficulty.selectedRowInComponent(0)]
        let rank = songRankData[songRank.selectedRowInComponent(0)]
        let playedRank = playRankData[playRank.selectedRowInComponent(0)]
        
        oncePoints.text = String(lround(difficultyBasicPointArray[difficulty]! * songRankArray[rank]! * playRankArray[playedRank]!))
    }
    
    func fillEventEndTime() {
        EventService().getLatestEvent {
            (latestEvent: NSArray) -> Void in
            let eventEndDate = NSDate(dateString: latestEvent[0]["end"] as! String)
            let eventEndCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            self.eventEndDay.text = String(eventEndCalendar.components(.Day, fromDate: eventEndDate).day)
            self.eventEndHour.text = String(eventEndCalendar.components(.Hour, fromDate: eventEndDate).hour)
            self.eventLastHour.text = CalculatorFactory.getEventLastHour(eventEndDate)
        }
    }
    
    func eventEndDayDidChange(textField: UITextField) {
        let calendar = CalculatorCalendar()
        let eventEndDate = NSDate(eventDateString: "\(calendar.getYear())-\(calendar.getMonth())-\(textField.text!) \(eventEndHour.text!)")
        eventLastHour.text = CalculatorFactory.getEventLastHour(eventEndDate)
    }
    
    func eventEndHourDidChange(textField: UITextField) {
        let calendar = CalculatorCalendar()
        let eventEndDate = NSDate(eventDateString: "\(calendar.getYear())-\(calendar.getMonth())-\(eventEndDay.text!) \(textField.text!)")
        eventLastHour.text = CalculatorFactory.getEventLastHour(eventEndDate)
    }
}