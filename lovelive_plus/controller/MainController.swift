import UIKit

class MainController: UIViewController {

    @IBOutlet var eventImage: UIImageView?
    @IBOutlet var eventNavigator: UIButton?
    @IBOutlet var cardNavigator: UIButton?
    @IBOutlet var mfNavigator: UIButton?
    @IBOutlet var smNavigator: UIButton?
    @IBOutlet var normalNavigator: UIButton?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowForNavigator()
        showLatestEventImage()
        scrollView.backgroundColor = Color.Blue50()
    }

    func showLatestEventImage() {
        let eventService = EventService()
        eventService.getLatestEvent(1, callback: {
            (latestEvent: NSArray) -> Void in
            let imageUrl = latestEvent[0]["image"] as! String
            let block: SDWebImageCompletionBlock! = {
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
                print(self)
            }

            self.eventImage!.sd_setImageWithURL(NSURL(string: imageUrl), completed: block)
        })
    }

    func setShadowForNavigator() {
        mfNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        mfNavigator!.layer.shadowRadius = 5.0
        mfNavigator!.layer.shadowOpacity = 0.8
        mfNavigator!.layer.masksToBounds = false

        smNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        smNavigator!.layer.shadowRadius = 5.0
        smNavigator!.layer.shadowOpacity = 0.8
        smNavigator!.layer.masksToBounds = false

        normalNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        normalNavigator!.layer.shadowRadius = 5.0
        normalNavigator!.layer.shadowOpacity = 0.8
        normalNavigator!.layer.masksToBounds = false
    }
}