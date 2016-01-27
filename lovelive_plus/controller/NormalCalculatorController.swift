import UIKit

class NormalCalculatorController: UIViewController {
    
    @IBAction func advancedOptionsButton(sender: UIButton) {
        eventTimeView.hidden = true
        if advancedOptionsView.hidden == true {
            advancedOptionsView.hidden = false
        } else {
            advancedOptionsView.hidden = true
        }
    }
    
    @IBAction func EventTimeButton(sender: UIButton) {
        advancedOptionsView.hidden = true
        if eventTimeView.hidden == true {
            eventTimeView.hidden = false
        } else {
            eventTimeView.hidden = true
        }
    }
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var calculatorCardView: UIView!
    @IBOutlet weak var advancedOptionsView: UIView!
    @IBOutlet weak var eventTimeView: UIView!
    
    override func viewDidLoad() {
        scrollView.backgroundColor = Color.Blue50()
        advancedOptionsView.hidden = true
        eventTimeView.hidden = true
        setShadowForView(calculatorCardView)
    }
    
    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
}
