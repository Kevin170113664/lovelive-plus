import UIKit

class CalculateReportController: UIViewController {

    @IBOutlet weak var calculateReportView: UIView!
    @IBOutlet weak var totalLoveCardLabel: UILabel!
    @IBOutlet weak var finalPointsLabel: UILabel!
    @IBOutlet weak var finalRankLabel: UILabel!
    @IBOutlet weak var finalExpLabel: UILabel!
    @IBOutlet weak var finalLpLabel: UILabel!
    @IBOutlet weak var finalItemsLabel: UILabel!
    @IBOutlet weak var playFrequencyLabel: UILabel!
    @IBOutlet weak var eventFrequencyLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var playTimeRatioLabel: UILabel!

    var totalLoveCard: String?
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
        showReportData()
    }

    func showReportData() {
        totalLoveCardLabel.text = totalLoveCard
        finalPointsLabel.text = finalPoints
        finalRankLabel.text = finalRank
        finalExpLabel.text = finalExp
        finalLpLabel.text = finalLp
        finalItemsLabel.text = finalItems
        playFrequencyLabel.text = playFrequency
        eventFrequencyLabel.text = eventFrequency
        totalTimeLabel.text = totalTime
        playTimeRatioLabel.text = playTimeRatio
    }

    @IBAction func closeReport(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
