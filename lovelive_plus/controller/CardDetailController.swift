import UIKit

class CardDetailController: UIViewController {
    @IBOutlet var cardDetailView: UIView!
    @IBOutlet weak var cardDetailScrollView: UIScrollView!
    @IBOutlet weak var cardNonIdolizedImageButton: UIButton!
    @IBOutlet weak var cardIdolizedImageButton: UIButton!
    @IBOutlet weak var cardPanelView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idlabel: UILabel!
    @IBOutlet weak var minSmile: UILabel!
    @IBOutlet weak var minPure: UILabel!
    @IBOutlet weak var minCool: UILabel!
    @IBOutlet weak var nonIdolizedMaxSmile: UILabel!
    @IBOutlet weak var nonIdolizedMaxPure: UILabel!
    @IBOutlet weak var nonIdolizedMaxCool: UILabel!
    @IBOutlet weak var idolizedMaxSmile: UILabel!
    @IBOutlet weak var idolizedMaxPure: UILabel!
    @IBOutlet weak var idolizedMaxCool: UILabel!
    
    override func viewDidLoad() {
        cardDetailView.backgroundColor = Color.Blue50()
        
        cardPanelView.backgroundColor = Color.Blue100()
        cardPanelView!.layer.shadowOffset = CGSizeMake(1, 1)
        cardPanelView!.layer.shadowRadius = 5.0
        cardPanelView!.layer.shadowOpacity = 0.8
        cardPanelView!.layer.masksToBounds = false
    }
}
