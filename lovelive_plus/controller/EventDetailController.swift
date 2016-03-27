import UIKit

class EventDetailController: UIViewController {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventBeginTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    @IBOutlet weak var rank1: UILabel!
    @IBOutlet weak var points1: UILabel!
    @IBOutlet weak var rank2: UILabel!
    @IBOutlet weak var points2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}