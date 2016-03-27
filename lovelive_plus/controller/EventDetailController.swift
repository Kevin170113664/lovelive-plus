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
    internal var event : Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Color.Blue50()
        setShadowForView(eventDetailView)
        setEventDetail()
    }
    
    func setEventDetail() {
        if let event = EventManager().queryEventByName(eventName) {
            showEventImage(event)
            eventTitle.text = eventName
            eventBeginTime.text = textForLabel(event.beginning)
            eventEndTime.text = textForLabel(event.end)
            rank1.text = textForLabel(event.japaneseT1Rank)
            points1.text = textForLabel(event.japaneseT1Points)
            rank2.text = textForLabel(event.japaneseT2Rank)
            points2.text = textForLabel(event.japaneseT2Points)
        }
    }

    func showEventImage(event: Event!) {
        if let eventImageUrl = event.image {
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