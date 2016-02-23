import UIKit

class CalculateReportController: UIViewController {

    @IBOutlet weak var calculateReportView: UIView!
    @IBOutlet weak var totalLovecaLabel: UILabel!
    @IBOutlet weak var finalPointsLabel: UILabel!
    @IBOutlet weak var finalRankLabel: UILabel!
    @IBOutlet weak var finalExpLabel: UILabel!
    @IBOutlet weak var finalLpLabel: UILabel!
    @IBOutlet weak var finalItemsLabel: UILabel!
    @IBOutlet weak var playFrequencyLabel: UILabel!
    @IBOutlet weak var eventFrequencyLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playTimeRatioLabel: UILabel!

    @IBOutlet weak var finalItemsTitle: UILabel!
    @IBOutlet weak var eventFrequencyTitle: UILabel!
    
    @IBOutlet weak var totalTimeTopMargin: NSLayoutConstraint!
    @IBOutlet weak var playFrequencyTopMargin: NSLayoutConstraint!
    @IBOutlet weak var totalTimeLabelTopMargin: NSLayoutConstraint!
    @IBOutlet weak var playFrequencyLabelTopMargin: NSLayoutConstraint!
    
    var eventType: String?
    var totalLoveca: String?
    var finalPoints: String?
    var finalRank: String?
    var finalExp: String?
    var finalLp: String?
    var finalItems: String?
    var playFrequency: String?
    var eventFrequency: String?
    var totalTime: String?
    var playTimeRatio: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateReportView.backgroundColor = Color.Blue100()
        showCommomData()
        showDataAccordingToEventType(eventType)
    }

    func showDataAccordingToEventType(eventType: String!) {
        switch (eventType) {
            case "normal": showNormalReportData()
                break
            case "sm": showSmReportData()
                break
            case "mf": showSmReportData()
                break
            default:
                break
        }
    }
    
    func showNormalReportData() {
        finalItemsLabel.text = finalItems
        eventFrequencyLabel.text = eventFrequency
    }
    
    func showSmReportData() {
        finalItemsTitle.hidden = true
        eventFrequencyTitle.hidden = true
        finalItemsLabel.hidden = true
        eventFrequencyLabel.hidden = true
        
        totalTimeTopMargin.constant = -20.5
        playFrequencyTopMargin.constant = -20.5
        totalTimeLabelTopMargin.constant = -20.5
        playFrequencyLabelTopMargin.constant = -20.5
    }
    
    func showCommomData() {
        totalLovecaLabel.text = totalLoveca
        finalPointsLabel.text = finalPoints
        finalRankLabel.text = finalRank
        finalExpLabel.text = finalExp
        finalLpLabel.text = finalLp
        playFrequencyLabel.text = playFrequency
        totalTimeLabel.text = totalTime
        playTimeRatioLabel.text = playTimeRatio
    }

    @IBAction func closeReport(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
