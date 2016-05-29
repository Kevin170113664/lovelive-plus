import UIKit
import SwiftyJSON

class NormalCalculatorController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

	let advancedOptionsViewHeight: CGFloat = 135
	let eventTimeViewHeight: CGFloat = 100

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
	@IBOutlet weak var currentItems: UITextField!
	@IBOutlet weak var eventDifficulty: UIPickerView!
	@IBOutlet weak var oncePoints: UILabel!
	@IBOutlet weak var eventRank: UIPickerView!
	@IBOutlet weak var eventCombo: UIPickerView!

	@IBOutlet weak var wastedLpEveryDay: UITextField!
	@IBOutlet weak var isChineseExp: UISwitch!
	@IBOutlet weak var currentLp: UITextField!
	@IBOutlet weak var currentExp: UITextField!
	@IBOutlet weak var normalDifficulty: UIPickerView!
	@IBOutlet weak var consumeLp: UILabel!
	@IBOutlet weak var eventEndDay: UITextField!
	@IBOutlet weak var eventEndHour: UITextField!
	@IBOutlet weak var eventLastHour: UITextField!

	let eventDifficultyData = ["Expert", "Hard", "Normal", "Easy", "4xExpert", "4xHard", "4xNormal", "4xEasy"]
	let eventRankData = ["S", "A", "B", "C", "-"]
	let eventComboData = ["S", "A", "B", "C", "-"]
	let normalDifficultyData = ["Expert", "Hard", "Normal", "Easy"];

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
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
		scrollViewHeight.constant = UIScreen.mainScreen().bounds.height
	}

	func keyboardWillShow(notification: NSNotification) {
		let userInfo: NSDictionary = notification.userInfo!
		let keyboardFrame: NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
		let keyboardRectangle = keyboardFrame.CGRectValue()
		scrollViewHeight.constant = UIScreen.mainScreen().bounds.height - keyboardRectangle.height
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
		eventCombo.selectRow(1, inComponent: 0, animated: false)
	}

	func initEventTimePanel() {
		fillEventEndTime()
		eventEndDay.delegate = self
		eventEndDay.addTarget(self, action: "eventEndDayDidChange:", forControlEvents: UIControlEvents.EditingChanged)
		eventEndHour.delegate = self
		eventEndHour.addTarget(self, action: "eventEndHourDidChange:", forControlEvents: UIControlEvents.EditingChanged)
	}

	func setPicker() {
		eventDifficulty.delegate = self
		eventDifficulty.dataSource = self
		eventDifficulty.showsSelectionIndicator = false

		eventRank.delegate = self
		eventRank.dataSource = self
		eventRank.showsSelectionIndicator = false

		eventCombo.delegate = self
		eventCombo.dataSource = self
		eventCombo.showsSelectionIndicator = false

		normalDifficulty.delegate = self
		normalDifficulty.dataSource = self
		normalDifficulty.showsSelectionIndicator = false
	}

	func setBackground() {
		self.view.backgroundColor = Color.Blue50()
		scrollView.backgroundColor = Color.Blue50()
		calculateButton.backgroundColor = Color.Blue100()
		objectivePoints.backgroundColor = Color.Blue50()
		currentPoints.backgroundColor = Color.Blue50()
		currentRank.backgroundColor = Color.Blue50()
		currentItems.backgroundColor = Color.Blue50()
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
		case eventDifficulty: return eventDifficultyData.count
		case eventRank: return eventRankData.count
		case eventCombo: return eventComboData.count
		case normalDifficulty: return normalDifficultyData.count
		default: return 0
		}
	}

	func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
		let label = UILabel()
		label.textColor = UIColor.blackColor()
		label.font = UIFont(name: "San Francisco", size: 7.0)
		label.textAlignment = NSTextAlignment.Center

		switch (pickerView) {
		case eventDifficulty: label.text = eventDifficultyData[row]
			break
		case eventRank: label.text = eventRankData[row]
			break
		case eventCombo: label.text = eventComboData[row]
			break
		case normalDifficulty: label.text = normalDifficultyData[row]
			break
		default: label.text = ""
		}

		return label
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "CalculateReport" {
			let calculateReportController = segue.destinationViewController as! CalculateReportController

			let calculatorFactory = CalculatorFactory(objectivePoints: objectivePoints.text, currentPoints: currentPoints.text,
				currentRank: currentRank.text, wastedLpEveryDay: wastedLpEveryDay.text, currentLp: currentLp.text,
				currentExperience: currentExp.text, eventEndDay: eventEndDay.text, eventLastTime: eventLastHour.text,
				currentItem: currentItems.text, eventDifficulty: eventDifficultyData[eventDifficulty.selectedRowInComponent(0)],
				eventRank: eventRankData[eventRank.selectedRowInComponent(0)],
				eventCombo: eventComboData[eventCombo.selectedRowInComponent(0)],
				oncePoints: oncePoints.text, consumeLp: consumeLp.text, isChineseExp: isChineseExp.on)
			calculatorFactory.calculateNormalProcess()

			setReportFields(calculateReportController, calculatorFactory: calculatorFactory)
		}
	}

	func setReportFields(calculateReportController: CalculateReportController, calculatorFactory: CalculatorFactory) {
		calculateReportController.totalLoveca = calculatorFactory.getLovecaAmount()
		calculateReportController.finalPoints = calculatorFactory.getFinalPoints()
		calculateReportController.finalRank = calculatorFactory.getFinalRank()
		calculateReportController.finalExp = String(format: "\(calculatorFactory.getFinalExp())/\(calculatorFactory.getCurrentRankUpExp())")
		calculateReportController.finalLp = calculatorFactory.getFinalLp()
		calculateReportController.finalItems = calculatorFactory.getFinalItem()
		calculateReportController.playFrequency = calculatorFactory.getTimesNeedToPlay()
		calculateReportController.eventFrequency = calculatorFactory.getEventTimesNeedToPlay()
		calculateReportController.totalTime = calculatorFactory.getTotalPlayTime()
		calculateReportController.playTimeRatio = calculatorFactory.getPlayTimeRatio()
		calculateReportController.eventType = "normal"
	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch (pickerView) {
		case normalDifficulty:
			updateConsumeLp(normalDifficultyData[row])
			break
		default:
			updateOncePoints()
			break
		}
	}

	func updateConsumeLp(difficulty: String) {
		let normalDifficultyArray = ["Expert": "25", "Hard": "15", "Normal": "10", "Easy": "5"]
		consumeLp.text = normalDifficultyArray[difficulty]
	}

	func updateOncePoints() {
		let eventPoint = readNormalEventPointsFile()
		var pointMultiply = 1
		var difficulty = eventDifficultyData[eventDifficulty.selectedRowInComponent(0)]
		var rank = eventRankData[eventRank.selectedRowInComponent(0)]
		var combo = eventComboData[eventCombo.selectedRowInComponent(0)]

		if difficulty.substringToIndex(difficulty.startIndex.advancedBy(1)) == "4" {
			pointMultiply = 4
			difficulty = difficulty.substringFromIndex(difficulty.startIndex.advancedBy(2))
		}
		if rank == "-" {
			rank = "D"
		}
		if combo == "-" {
			combo = "D"
		}

		oncePoints.text = String(pointMultiply * (eventPoint[difficulty]![rank]!![combo] as! Int))
	}

	func readNormalEventPointsFile() -> NSDictionary {
		if let path = NSBundle.mainBundle().pathForResource("normalEvent", ofType: "json") {
			if let data = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe) {
				let json = JSON(data: data)
				return json.dictionaryObject!
			}
		}
		return NSDictionary()
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

extension NSDate {
	convenience
	init(dateString: String) {
		let dateStringFormatter = NSDateFormatter()
		dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
		let date = dateStringFormatter.dateFromString(dateString)!
		self.init(timeInterval: 0, sinceDate: date)
	}

	convenience
	init(eventDateString: String) {
		let dateStringFormatter = NSDateFormatter()
		dateStringFormatter.dateFormat = "yyyy-MM-dd HH"
		if let date = dateStringFormatter.dateFromString(eventDateString) {
			self.init(timeInterval: 0, sinceDate: date)
		} else {
			self.init(timeInterval: 0, sinceDate: NSDate())
		}
	}
}
