import UIKit

class NormalCalculatorController: UIViewController {
    
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
    @IBOutlet weak var currentItems: UITextField!
    @IBOutlet weak var eventDifficulty: UIPickerView!
    @IBOutlet weak var oncePoints: UILabel!
    @IBOutlet weak var eventRank: UIPickerView!
    @IBOutlet weak var eventCombo: UIPickerView!
    
    @IBOutlet weak var wastedLpEveryDay: UITextField!
    @IBOutlet weak var isChina: UISwitch!
    @IBOutlet weak var currentLp: UITextField!
    @IBOutlet weak var currentExp: UITextField!
    @IBOutlet weak var normalDifficulty: UIPickerView!
    @IBOutlet weak var consumeLp: UILabel!
    @IBOutlet weak var eventEndDay: UITextField!
    @IBOutlet weak var eventEndHour: UITextField!
    @IBOutlet weak var eventLastHour: UITextField!
    
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
        advancedOptionsView.hidden = true
        eventTimeView.hidden = true
        setShadowForView(calculatorCardView)
        setShadowForView(calculateButton)
    }
    
    func setBackground() {
        scrollView.backgroundColor = Color.Blue50()
        calculateButton.backgroundColor = Color.Blue100()
        objectivePoints.backgroundColor = Color.Blue50()
        currentPoints.backgroundColor = Color.Blue50()
        currentRank.backgroundColor = Color.Blue50()
        currentItems.backgroundColor = Color.Blue50()
        eventDifficulty.backgroundColor = Color.Blue50()
        eventRank.backgroundColor = Color.Blue50()
        eventCombo.backgroundColor = Color.Blue50()
        wastedLpEveryDay.backgroundColor = Color.Blue50()
        currentLp.backgroundColor = Color.Blue50()
        currentExp.backgroundColor = Color.Blue50()
        normalDifficulty.backgroundColor = Color.Blue50()
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
    
    @IBAction func calculate(sender: AnyObject) {
        let calculateReportController = storyboard?.instantiateViewControllerWithIdentifier("CalculateReport") as! CalculateReportController
        calculateReportController.showInView(self.view, withMessage: "You just triggered a great popup window", animated: true)
    }
}
