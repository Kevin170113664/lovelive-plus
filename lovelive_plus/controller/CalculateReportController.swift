import UIKit

class CalculateReportController: UIViewController {

    @IBOutlet weak var calculateReportView: UIView!
    @IBOutlet weak var totalLoveCardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateReportView.backgroundColor = Color.Blue100()
    }
    
    @IBAction func closeReport(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
