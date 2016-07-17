import UIKit

class EventDetailController: UIViewController {
    
    @IBOutlet weak var eventDetailView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventBeginTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    @IBOutlet weak var rank1: UILabel!
    @IBOutlet weak var points1: UILabel!
    @IBOutlet weak var rank2: UILabel!
    @IBOutlet weak var points2: UILabel!

    internal var eventName : String?
    internal var event: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.Blue50()
        setShadowForView(eventDetailView)
        setEventDetail()
    }
    
    func setEventDetail() {
            showEventImage(event)
        eventTitle.text = event["japanese_name"] as? String
        eventBeginTime.text = textForLabel(event["beginning"] as? String)
        eventEndTime.text = textForLabel(event["end"] as? String)
        rank1.text = textForLabel(event["japanese_t1_rank"] as? Int)
        points1.text = textForLabel(event["japanese_t1_points"] as? Int)
        rank2.text = textForLabel(event["japanese_t2_rank"] as? Int)
        points2.text = textForLabel(event["japanese_t2_points"] as? Int)
    }

    func showEventImage(event: NSDictionary) {
        if let eventImageUrl = event["image"] as? String {
            let encodedUrl = eventImageUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            eventImage.contentMode = UIViewContentMode.ScaleAspectFit
            eventImage.sd_setImageWithURL(NSURL(string: encodedUrl!))
        }
    }

    func textForLabel(rawText: AnyObject?) -> String! {
        return rawText != nil ? String(rawText!) : "未知"
    }
    
    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
}