import UIKit

class CardDetailController: UIViewController {
    @IBOutlet var cardDetailView: UIView!
    @IBOutlet weak var cardDetailScrollView: UIScrollView!
    @IBOutlet weak var cardNonIdolizedImageButton: UIButton!
    @IBOutlet weak var cardIdolizedImageButton: UIButton!
    @IBOutlet weak var cardPanelView: UIView!

    override func viewDidLoad() {
        cardDetailView.backgroundColor = Color.Blue50()
        
        cardPanelView.backgroundColor = Color.Blue100()
        cardPanelView!.layer.shadowOffset = CGSizeMake(1, 1)
        cardPanelView!.layer.shadowRadius = 5.0
        cardPanelView!.layer.shadowOpacity = 0.8
        cardPanelView!.layer.masksToBounds = false
    }
}
