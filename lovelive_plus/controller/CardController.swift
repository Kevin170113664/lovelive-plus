import UIKit

@objc protocol FilterPopoverDelegate: UIPopoverPresentationControllerDelegate {
	func applyFilterDictionary(filter: NSDictionary)
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
	private var cardArray: NSArray = []
	private var simpleCardArray = [SimpleCard]()
	private var maxCardId = 10
	private var selectedIndexPath: NSIndexPath?
	private var isIdolized = true

	override func viewDidLoad() {
		super.viewDidLoad()
		loadUrCardArray()
		cardCollectionView?.backgroundColor = Color.Blue50()
	}

	func loadUrCardArray() {
		let cardService = CardService()

		cardService.getCardsByFilter(["rarity": "UR", "is_promo": "False", "is_special": "False", "page_size": "100"], callback: {
			(filterCards: NSArray) -> Void in
			self.cardArray = self.sortByIdDesc(filterCards)
			self.cardCollectionView?.reloadData()
		})
	}

	func applyFilterDictionary(filter: NSDictionary) {
		let cardService = CardService()

		cardService.getCardsByFilter(filter, callback: {
			(filterCards: NSArray) -> Void in
			self.cardArray = self.sortByIdDesc(filterCards)
			self.cardCollectionView?.reloadData()
		})
	}

	func sortByIdDesc(cards: NSArray) -> NSArray {
		return cards.sort({ $0["id"] as! Int > $1["id"] as! Int })
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

		let card = cardArray[indexPath.row]
		if (shouldShowNonIdolizedImage(card as! NSDictionary)) {
			if let url = card["round_card_image"] as? String {
				cell.imageView!.sd_setImageWithURL(NSURL(string: url))
			}
		} else {
			if let url = card["round_card_idolized_image"] as? String {
				cell.imageView!.sd_setImageWithURL(NSURL(string: url))
			}
		}

		return cell
	}

	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		let card = cardArray[indexPath.row]
		if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
			selectedIndexPath = indexPath
			if (isPromoCard(card as! NSDictionary)) {
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
		cardDetailController.card = cardArray[(selectedIndexPath?.row)!] as! NSDictionary
		selectedIndexPath = nil
	}

	func showFilterView(segue: UIStoryboardSegue) {
		let filterController = segue.destinationViewController as! FilterController
		filterController.modalPresentationStyle = UIModalPresentationStyle.Popover
		filterController.popoverPresentationController!.delegate = self
		filterController.preferredContentSize = CGSizeMake(430, 235)
		filterController.delegate = self
	}

	func shouldShowNonIdolizedImage(card: NSDictionary) -> Bool {
		return !isIdolized && card["is_special"] as? Bool == false && card["is_promo"] as? Bool == false
	}

	func isPromoCard(card: NSDictionary) -> Bool {
		return card["is_special"] as! Bool == true || card["is_promo"] as! Bool == true
	}

	func isCardDetailSegue(identifier: String) -> Bool {
		return identifier == "CardDetail" || identifier == "PromoCardDetail"
	}
}