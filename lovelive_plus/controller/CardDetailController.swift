import UIKit

class CardDetailController: UIViewController {
    @IBOutlet var cardDetailView: UIView!
    @IBOutlet weak var cardDetailScrollView: UIScrollView!
    @IBOutlet weak var cardNonIdolizedImageButton: UIButton!
    @IBOutlet weak var cardIdolizedImageButton: UIButton!
    @IBOutlet weak var cardPanelView: UIView!
    @IBOutlet weak var cardSkillPanelView: UIView!
    
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
    
    @IBOutlet weak var skillType: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var centerSkillName: UILabel!
    @IBOutlet weak var centerSkillDetail: UILabel!
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillDetail: UILabel!
    
    override func viewDidLoad() {
        cardDetailView.backgroundColor = Color.Blue50()
        setShadowForView(cardPanelView)
        setShadowForView(cardSkillPanelView)
    }

    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
}
