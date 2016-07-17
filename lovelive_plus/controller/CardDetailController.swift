import UIKit

class CardDetailController: UIViewController {
	internal var cardId: String?
	internal var card: NSDictionary = [:]
	internal var cardNonIdolizedImage: String?
	internal var cardIdolizedImage: String?
	internal var showImage = true
	internal var showTransparentImage = false
	internal var showCleanUrImage = false

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

	@IBAction func changeCardImageAction(sender: AnyObject) {
		if showImage {
			showImage = false
			showTransparentImage = true
			setCardImage()
			return
		}

		if showTransparentImage {
			showTransparentImage = false
			showCleanUrImage = true
			setCardImage()
			return
		}

		if showCleanUrImage {
			showCleanUrImage = false
			showImage = true
			setCardImage()
			return
		}

	}

	override func viewDidLoad() {
		cardDetailView.backgroundColor = Color.Blue50()
		cardDetailScrollView.showsVerticalScrollIndicator = false
		setShadowForView(cardPanelView)
		setShadowForView(cardSkillPanelView)
		setCardDetail()
		setImageButtonGesture()
	}

	func setImageButtonGesture() {
		let idolizedGesture = UILongPressGestureRecognizer(target: self, action: #selector(CardDetailController.saveIdolizedImage(_:)))
		cardIdolizedImageButton.addGestureRecognizer(idolizedGesture)
		if cardNonIdolizedImageButton != nil {
			let nonIdolizedGesture = UILongPressGestureRecognizer(target: self, action: #selector(CardDetailController.saveNonIdolizedImage(_:)))
			cardNonIdolizedImageButton.addGestureRecognizer(nonIdolizedGesture)
		}
	}

	func setCardDetail() {
		setCardImage()
		setBasicInfo()
		setSkillInfo()
	}

	func nonIdolizedImageExist() -> Bool {
		return card["is_promo"] as! Bool == false && card["is_special"] as! Bool == false
			&& card["card_image"] != nil && card["card_image"] as! String!

= ""
}

func setCardImage() {
	if showImage {
		if (nonIdolizedImageExist()) {
			cardNonIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["card_image"]! as! String), forState: UIControlState.Normal)
			cardNonIdolizedImage = card["card_image"] as? String
		}
		cardIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["card_idolized_image"]! as! String), forState: UIControlState.Normal)
		cardIdolizedImage = card["card_idolized_image"] as? String
	}

	if showTransparentImage {
		if (nonIdolizedImageExist()) {
			cardNonIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["transparent_image"]! as! String), forState: UIControlState.Normal)
			cardNonIdolizedImage = card["transparent_image"] as? String
		}
		cardIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["transparent_idolized_image"]! as! String), forState: UIControlState.Normal)
		cardIdolizedImage = card["transparent_idolized_image"] as? String
	}

	if showCleanUrImage {
		if card["clean_ur"] is NSNull && card["clean_ur_idolized"] is NSNull {
			showImage = true
			showCleanUrImage = false
			setCardImage()
		} else {
			if (nonIdolizedImageExist()) {
				cardNonIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["clean_ur"]! as! String), forState: UIControlState.Normal)
				cardNonIdolizedImage = card["clean_ur"] as? String
        }
			cardIdolizedImageButton.sd_setBackgroundImageWithURL(NSURL(string: card["clean_ur_idolized"]! as! String), forState: UIControlState.Normal)
			cardIdolizedImage = card["clean_ur_idolized"] as? String
		}
	}

}

func setBasicInfo() {
	let idol = card["idol"] as! NSDictionary
	setLabelText(nameLabel, value: idol["japanese_name"] as? String)
	setLabelText(idlabel, value: String(card["id"] as! Int))
	setLabelText(minSmile, value: String(card["minimum_statistics_smile"] as! Int))
	setLabelText(minPure, value: String(card["minimum_statistics_pure"] as! Int))
	setLabelText(minCool, value: String(card["minimum_statistics_cool"] as! Int))
	setLabelText(nonIdolizedMaxSmile, value: String(card["non_idolized_maximum_statistics_smile"] as! Int))
	setLabelText(nonIdolizedMaxPure, value: String(card["non_idolized_maximum_statistics_pure"] as! Int))
	setLabelText(nonIdolizedMaxCool, value: String(card["non_idolized_maximum_statistics_cool"] as! Int))
	setLabelText(idolizedMaxSmile, value: String(card["idolized_maximum_statistics_smile"] as! Int))
	setLabelText(idolizedMaxPure, value: String(card["idolized_maximum_statistics_pure"] as! Int))
	setLabelText(idolizedMaxCool, value: String(card["idolized_maximum_statistics_cool"] as! Int))
}

func setSkillInfo() {
	setLabelText(skillType, value: card["skill"] as? String)
	setLabelText(releaseDate, value: card["release_date"] as? String)
	setLabelText(centerSkillName, value: isStringValid(card["japanese_center_skill"] as? String) ?
		card["japanese_center_skill"] as? String : card["center_skill"] as? String)
	setLabelText(centerSkillDetail, value: card["japanese_center_skill_details"] as? String)
	setLabelText(skillName, value: card["japanese_skill"] as? String)
	if card["is_promo"] as! Bool == true {
		setLabelText(skillDetail, value: card["skill_details"] as? String)
	} else {
		setLabelText(skillDetail, value: isStringValid(card["japanese_skill_details"] as? String) ?
			card["japanese_skill_details"] as? String : card["skill_details"] as? String)
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

func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
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

func saveIdolizedImage(sender: UIGestureRecognizer) {
	if sender.state == .Ended {
		saveImageToAlbumWithUrl(cardIdolizedImage!)
    }
}

func saveNonIdolizedImage(sender: UIGestureRecognizer) {
	if sender.state == .Ended {
		saveImageToAlbumWithUrl(cardNonIdolizedImage!)
    }
}

func saveImageToAlbumWithUrl(imageUrl: String) {
	let imageView = UIImageView()
	imageView.sd_setImageWithURL(NSURL(string: imageUrl))
	if let image = imageView.image {
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(CardDetailController.image(_: didFinishSavingWithError:contextInfo:)), nil)
    }
}
}
