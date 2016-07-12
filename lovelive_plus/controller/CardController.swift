import UIKit

@objc protocol FilterPopoverDelegate: UIPopoverPresentationControllerDelegate {
	func applyFilterDictionary(filterDictionary: NSMutableDictionary)
}

class CardController: UICollectionViewController, FilterPopoverDelegate {

	@IBOutlet var cardCollectionView: UICollectionView?

	@IBAction func changeFaceAction(sender: AnyObject) {
		isIdolized = !isIdolized
		cardCollectionView?.reloadData()
	}

	private let reuseIdentifier = "CardCell"
	private let segueIdentifier = "CardDetail"
	private let promoSegueIdentifier = "PromoCardDetail"
	private var cardArray = [Card]()
	private var simpleCardArray = [SimpleCard]()
	private var maxCardId = 10
	private var selectedIndexPath: NSIndexPath?
	private var isIdolized = true

	override func viewDidLoad() {
		super.viewDidLoad()
		loadCardArray()
		cardCollectionView?.backgroundColor = Color.Blue50()
	}

	func loadCardArray() {
		cardArray = CardManager().queryAllCards()
		if cardArray.count < maxCardId {
			fetchCardDataFromInternet()
		} else {
			updateCardArray()
			updateLatestCards()
		}
	}

	func fetchCardDataFromInternet() {
		showNotFinishAlert("温馨提示", message: "第一次下载数据需要30秒左右，请耐心等待噢~")
		CardService().getAllCardIds({
			(cardIdArray: NSArray) -> Void in
			self.maxCardId = cardIdArray.lastObject as! Int
			self.fetchCardAccordingToMaxCardId()
		})
	}

	func updateLatestCards() {
		CardService().getAllCardIds({
			(cardIdArray: NSArray) -> Void in
			CardManager().updateLatest20Cards(cardIdArray.lastObject as! Int)
		})
	}

	func fetchCardAccordingToMaxCardId() {
		if cardArray.count < maxCardId {
			CardManager().cacheAllCards({
				() -> Void in
				self.cardArray = CardManager().queryAllCards()
				self.updateCardArray()
				self.cardCollectionView?.reloadData()
			})
		}
	}

	func updateCardArray() {
		generateSimpleCardArray()

		CardService().getAllCardIds({
			(cardIdArray: NSArray) -> Void in
			self.maxCardId = cardIdArray.lastObject as! Int
			if (self.maxCardId > self.cardArray.count) {
				self.fetchCardAccordingToMaxCardId()
			}
		})
	}

	func generateSimpleCardArray() {
		cardArray = removeDuplicateCard()
		cardArray = cardArray.sort({ Int($0.cardId!) > Int($1.cardId!) })
		maxCardId = cardArray.count

		simpleCardArray.removeAll()
		for card in cardArray {
			simpleCardArray.append(generateSimpleCard(card))
		}
	}

	func generateSimpleCard(card: Card) -> SimpleCard {
		let simpleCard = SimpleCard()
		simpleCard.cardId = card.cardId!
		simpleCard.isPromo = card.isPromo
		simpleCard.isSpecial = card.isSpecial
		simpleCard.roundCardIdolizedImage = card.roundCardIdolizedImage
		simpleCard.roundCardImage = card.roundCardImage

		return simpleCard
	}

	func removeDuplicateCard() -> [Card] {
		let cardDictionary = NSMutableDictionary()
		var cleanCardArray = [Card]()

		for card in cardArray {
			if let cardId = card.cardId {
				cardDictionary.setValue(card, forKey: cardId)
			}
		}

		for d in cardDictionary {
			cleanCardArray.append(d.value as! Card)
		}

		return cleanCardArray
	}

	func applyFilterDictionary(filterDictionary: NSMutableDictionary) {
		cardArray = CardManager().queryCardsByFilterDictionary(filterDictionary)
		cardArray = removeDuplicateCard()
		cardArray = cardArray.sort({ Int($0.cardId!) > Int($1.cardId!) })

		simpleCardArray.removeAll()
		for card in cardArray {
			simpleCardArray.append(generateSimpleCard(card))
		}

		cardCollectionView?.reloadData()
	}

	func showNotFinishAlert(title: String, message: String) {
		let delay = 10 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)

		presentViewController(alertController, animated: true, completion: nil)
		dispatch_after(time, dispatch_get_main_queue(), {
			alertController.dismissViewControllerAnimated(true, completion: nil)
		})
	}
}

extension CardController {

	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}

	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cardArray.count
	}

	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
		cell.backgroundColor = Color.Blue50()

		let simpleCard = simpleCardArray[indexPath.row]
		if (shouldShowNonIdolizedImage(simpleCard)) {
			if let url = simpleCard.roundCardImage {
				cell.imageView!.sd_setImageWithURL(NSURL(string: url))
			}
		} else {
			if let url = simpleCard.roundCardIdolizedImage {
				cell.imageView!.sd_setImageWithURL(NSURL(string: url))
			}
		}

		return cell
	}

	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let simpleCard = simpleCardArray[indexPath.row]
		if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
			selectedIndexPath = indexPath
			if (isPromoCard(simpleCard)) {
				performSegueWithIdentifier(promoSegueIdentifier, sender: cell)
			} else {
				performSegueWithIdentifier(segueIdentifier, sender: cell)
			}
		}
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		isCardDetailSegue(segue.identifier!) ? showCardDetailView(segue) : showFilterView(segue)
	}

	override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
		if isCardDetailSegue(identifier) {
			return (selectedIndexPath != nil) ? true : false
		} else {
			return true
		}
	}

	func showCardDetailView(segue: UIStoryboardSegue) {
		let cardDetailController = segue.destinationViewController as! CardDetailController
		cardDetailController.cardId = simpleCardArray[(selectedIndexPath?.row)!].cardId
		selectedIndexPath = nil
	}

	func showFilterView(segue: UIStoryboardSegue) {
		let filterController = segue.destinationViewController as! FilterController
		filterController.modalPresentationStyle = UIModalPresentationStyle.Popover
		filterController.popoverPresentationController!.delegate = self
		filterController.preferredContentSize = CGSizeMake(430, 235)
		filterController.delegate = self
	}

	func shouldShowNonIdolizedImage(simpleCard: SimpleCard) -> Bool {
		return !isIdolized && simpleCard.isSpecial == 0 && simpleCard.isPromo == 0
	}

	func isPromoCard(simpleCard: SimpleCard) -> Bool {
		return simpleCard.isSpecial == 1 || simpleCard.isPromo == 1
	}

	func isCardDetailSegue(identifier: String) -> Bool {
		return identifier == "CardDetail" || identifier == "PromoCardDetail"
	}
}