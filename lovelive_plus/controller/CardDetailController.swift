import UIKit

class CardDetailController: UIViewController {
    internal var cardId: String?
    internal var card: Card?

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
        setCardDetail()
    }

    func setCardDetail() {
        card = DataController().queryCardById(cardId!)

        setCardImage()
        setBasicInfo()
        setSkillInfo()
    }

    func nonIdolizedImageExist() -> Bool {
        return card?.isPromo == 0 && card?.isSpecial == 0 && card!.cardImage != nil && card!.cardImage != ""
    }

    func setCardImage() {
        if (nonIdolizedImageExist()) {
            cardNonIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card!.cardImage!), forState: UIControlState.Normal)
        }
        cardIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card!.cardIdolizedImage!), forState: UIControlState.Normal)
    }

    func setBasicInfo() {
        setLabelText(nameLabel, value: card!.japaneseName)
        setLabelText(idlabel, value: card!.cardId)
        setLabelText(minSmile, value: card!.minimumStatisticsSmile)
        setLabelText(minPure, value: card!.minimumStatisticsPure)
        setLabelText(minCool, value: card!.minimumStatisticsCool)
        setLabelText(nonIdolizedMaxSmile, value: card!.nonIdolizedMaximumStatisticsSmile)
        setLabelText(nonIdolizedMaxPure, value: card!.nonIdolizedMaximumStatisticsPure)
        setLabelText(nonIdolizedMaxCool, value: card!.nonIdolizedMaximumStatisticsCool)
        setLabelText(idolizedMaxSmile, value: card!.idolizedMaximumStatisticsSmile)
        setLabelText(idolizedMaxPure, value: card!.idolizedMaximumStatisticsPure)
        setLabelText(idolizedMaxCool, value: card!.idolizedMaximumStatisticsCool)
    }

    func setSkillInfo() {
        setLabelText(skillType, value: card!.skill)
        setLabelText(releaseDate, value: card!.releaseDate)
        setLabelText(centerSkillName, value: isStringValid(card!.japaneseCenterSkill) ? card!.japaneseCenterSkill : card!.centerSkill)
        setLabelText(centerSkillDetail, value: card!.japaneseCenterSkillDetails)
        setLabelText(skillName, value: card!.japaneseSkill)
        setLabelText(skillDetail, value: isStringValid(card!.japaneseSkillDetails) ? card!.japaneseSkillDetails : card!.skillDetails)
    }

    func setLabelText(label: UILabel, value: String?) {
        if isStringValid(value) {
            label.text = value
        } else {
            return
        }
    }

    func isStringValid(value: String?) -> Bool {
        return value != "" && value != nil
    }

    func setShadowForView(view: UIView) {
        view.backgroundColor = Color.Blue100()
        view.layer.shadowOffset = CGSizeMake(1, 1)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
    }
}
