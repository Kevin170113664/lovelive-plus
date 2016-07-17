import UIKit
import SwiftyJSON

class MfCalculatorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    let advancedOptionsViewHeight: CGFloat = 215
    let eventTimeViewHeight: CGFloat = 95
    let calculateZoneHeight: CGFloat = 65

    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var calculatorCardView: UIView!
    @IBOutlet weak var advancedOptionsView: UIView!
    @IBOutlet weak var eventTimeView: UIView!
    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!

    @IBOutlet weak var objectivePoints: UITextField!
    @IBOutlet weak var currentPoints: UITextField!
    @IBOutlet weak var currentRank: UITextField!
    @IBOutlet weak var songAmount: UIPickerView!
    @IBOutlet weak var difficulty: UIPickerView!

    @IBOutlet weak var wastedLpEveryDay: UITextField!
    @IBOutlet weak var isChineseExp: UISwitch!
    @IBOutlet weak var eventPointAddition: UISwitch!
    @IBOutlet weak var expAddition: UISwitch!
    @IBOutlet weak var songRank: UIPickerView!
    @IBOutlet weak var songRankRatio: UILabel!
    @IBOutlet weak var comboRank: UIPickerView!
    @IBOutlet weak var comboRankRatio: UILabel!
    @IBOutlet weak var currentLp: UITextField!
    @IBOutlet weak var currentExp: UITextField!
    @IBOutlet weak var eventEndDay: UITextField!
    @IBOutlet weak var eventEndHour: UITextField!
    @IBOutlet weak var eventLastHour: UITextField!

    let songAmountData = ["3", "2", "1"]
    let difficultyData = ["Expert", "Hard", "Normal", "Easy"]
    let songRankData = ["S", "A", "B", "C", "-"]
    let comboRankData = ["S", "A", "B", "C", "-"]
    let songRankRatioArray = ["S": 1.20, "A": 1.15, "B": 1.10, "C": 1.05, "-": 1.00]
    let comboRankRatioArray = ["S": 1.08, "A": 1.06, "B": 1.04, "C": 1.02, "-": 1.00]

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

    @IBAction func eventTimeButton(sender: UIButton) {
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
        addObserverToListenKeyboardEvent()
    }

    func addObserverToListenKeyboardEvent() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MfCalculatorController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MfCalculatorController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        scrollViewHeight.constant = UIScreen.mainScreen().bounds.height
    }

    func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo!
        let keyboardFrame: NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        scrollViewHeight.constant = UIScreen.mainScreen().bounds.height - calculateZoneHeight - keyboardRectangle.height
    }

    func keyboardWillHide(notification: NSNotification) {
        scrollViewHeight.constant = UIScreen.mainScreen().bounds.height
    }

    func initCalculatorCardView() {
        advancedOptionsView.hidden = true
        eventTimeView.hidden = true
        setPicker()
        setShadowForView(calculatorCardView)
        setShadowForView(calculateButton)
        comboRank.selectRow(1, inComponent: 0, animated: false)
    }

    func initEventTimePanel() {
        fillEventEndTime()
        eventEndDay.delegate = self
        eventEndDay.addTarget(self, action: #selector(MfCalculatorController.eventEndDayDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        eventEndHour.delegate = self
        eventEndHour.addTarget(self, action: #selector(MfCalculatorController.eventEndHourDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }

    func setPicker() {
        initPicker(songAmount)
        initPicker(difficulty)
        initPicker(songRank)
        initPicker(comboRank)
    }

    func initPicker(picker: UIPickerView) {
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = false
    }

    func setBackground() {
        self.view.backgroundColor = Color.Blue50()
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
        case songAmount: return songAmountData.count
        case difficulty: return difficultyData.count
        case songRank: return songRankData.count
        case comboRank: return comboRankData.count
        default: return 0
        }
    }

    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont(name: "San Francisco", size: 7.0)
        label.textAlignment = NSTextAlignment.Center

        switch (pickerView) {
        case songAmount: label.text = songAmountData[row]
            break
        case difficulty: label.text = difficultyData[row]
            break
        case songRank: label.text = songRankData[row]
            break
        case comboRank: label.text = comboRankData[row]
            break
        default: label.text = ""
        }

        return label
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CalculateReport" {
            let calculateReportController = segue.destinationViewController as! CalculateReportController

            let calculatorFactory = CalculatorFactory(objectivePoints: objectivePoints.text,
                    currentPoints: currentPoints.text,
                    currentRank: currentRank.text,
                    songAmount: songAmountData[songAmount.selectedRowInComponent(0)],
                    difficulty: difficultyData[difficulty.selectedRowInComponent(0)],
                    wastedLpEveryDay: wastedLpEveryDay.text,
                    eventPointsAddition: eventPointAddition.on,
                    expAddition: expAddition.on,
                    songRankRatio: songRankRatio.text,
                    comboRankRatio: comboRankRatio.text,
                    currentLp: currentLp.text,
                    currentExperience: currentExp.text,
                    eventEndDay: eventEndDay.text,
                    eventLastTime: eventLastHour.text)
            calculatorFactory.calculateMfProcess()

            setReportFields(calculateReportController, calculatorFactory: calculatorFactory)
        }
    }

    func setReportFields(calculateReportController: CalculateReportController, calculatorFactory: CalculatorFactory) {
        calculateReportController.totalLoveca = calculatorFactory.getLovecaAmount()
        calculateReportController.finalPoints = calculatorFactory.getFinalPoints()
        calculateReportController.finalRank = calculatorFactory.getFinalRank()
        calculateReportController.finalExp = String(format: "\(calculatorFactory.getFinalExp())/\(calculatorFactory.getCurrentRankUpExp())")
        calculateReportController.finalLp = calculatorFactory.getFinalLp()
        calculateReportController.playFrequency = calculatorFactory.getTimesNeedToPlay()
        calculateReportController.totalTime = calculatorFactory.getTotalPlayTime()
        calculateReportController.playTimeRatio = calculatorFactory.getPlayTimeRatio()
        calculateReportController.eventType = "mf"
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView) {
        case songRank: songRankRatio.text = String(songRankRatioArray[songRankData[songRank.selectedRowInComponent(0)]]!)
            break
        case comboRank: comboRankRatio.text = String(comboRankRatioArray[comboRankData[comboRank.selectedRowInComponent(0)]]!)
            break
        default: break
        }
    }

    func fillEventEndTime() {
        EventService().getLatestEvent(1, callback: {
            (latestEvent: NSArray) -> Void in
            let eventEndDate = NSDate(dateString: latestEvent[0]["end"] as! String)
            let eventEndCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            self.eventEndDay.text = String(eventEndCalendar.components(.Day, fromDate: eventEndDate).day)
            self.eventEndHour.text = String(eventEndCalendar.components(.Hour, fromDate: eventEndDate).hour)
            self.eventLastHour.text = CalculatorFactory.getEventLastHour(eventEndDate)
        })
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