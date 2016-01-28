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
        scrollView.backgroundColor = Color.Blue50()
        calculateButton.backgroundColor = Color.Blue100()
        advancedOptionsView.hidden = true
        eventTimeView.hidden = true
        setShadowForView(calculatorCardView)
        setShadowForView(calculateButton)
    }
    
    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
}
