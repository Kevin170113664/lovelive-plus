import UIKit

class CardDetailController: UIViewController {
    internal var cardId: String?
    internal var card: Card?
    internal var cardNonIdolizedImage: String?
    internal var cardIdolizedImage: String?

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
        cardDetailScrollView.showsVerticalScrollIndicator = false
        setShadowForView(cardPanelView)
        setShadowForView(cardSkillPanelView)
        setCardDetail()
    }

    func setCardDetail() {
        card = CardManager().queryCardById(cardId!)

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
            cardNonIdolizedImage = card!.cardImage
        }
        cardIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card!.cardIdolizedImage!), forState: UIControlState.Normal)
        cardIdolizedImage = card!.cardIdolizedImage
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
        if card!.isPromo == 1 {
            setLabelText(skillDetail, value: card!.skillDetails)
        } else {
            setLabelText(skillDetail, value: isStringValid(card!.japaneseSkillDetails) ? card!.japaneseSkillDetails : card!.skillDetails)
        }
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
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            showAlertAfterSaving("保存成功", message: "卡牌图片已经保存到您的相册中")
        } else {
            showAlertAfterSaving("保存错误", message: "保存到相册失败了哟>.<")
        }
    }
    
    func showAlertAfterSaving(title: String, message: String) {
        let delay = 0.8 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        presentViewController(alertController, animated: true, completion: nil)
        dispatch_after(time, dispatch_get_main_queue(), {
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    @IBAction func saveToAlbum(sender: AnyObject) {
        if sender as! UIButton == cardIdolizedImageButton {
            saveImageToAlbumWithUrl(cardIdolizedImage!)
        } else {
            saveImageToAlbumWithUrl(cardNonIdolizedImage!)
        }
    }
    
    func saveImageToAlbumWithUrl(imageUrl: String) {
        let imageView = UIImageView()
        imageView.sd_setImageWithURL(NSURL(string: imageUrl))
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
    }
}
