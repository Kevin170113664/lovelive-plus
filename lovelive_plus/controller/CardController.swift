import UIKit

class CardController: UICollectionViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet var cardCollectionView: UICollectionView?
    
    @IBAction func changeFaceAction(sender: AnyObject) {
        isIdolized = !isIdolized
        cardCollectionView?.reloadData()
    }
    
    private let reuseIdentifier = "CardCell"
    private let segueIdentifier = "CardDetail"
    private var cardArray = [Card]()
    private var maxCardId = 784
    private var selectedIndexPath: NSIndexPath?
    private var isIdolized = true

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoundImageArray()

        cardCollectionView?.backgroundColor = Color.Blue50()
    }

    func loadRoundImageArray() {
        cardArray = DataController().queryAllCards()
        cardArray.count < maxCardId ? fetchCardDataFromInternet() : updateCardArray()
    }

    func fetchCardDataFromInternet() {
        CardService().getAllCardIds({
            (cardIdArray: NSArray) -> Void in
            self.maxCardId = cardIdArray.lastObject as! Int
            self.fetchCardAccordingToMaxCardId()
        })
    }

    func fetchCardAccordingToMaxCardId() {
        if cardArray.count < maxCardId {
            DataController().cacheAllCards({
                () -> Void in
                self.cardArray = DataController().queryAllCards()
                self.updateCardArray()
                self.cardCollectionView?.reloadData()
            })
        }
    }

    func updateCardArray() {
        cardArray = removeDuplicateCard()
        maxCardId = cardArray.count
        
        CardService().getAllCardIds({
            (cardIdArray: NSArray) -> Void in
            self.maxCardId = cardIdArray.lastObject as! Int
            if (self.maxCardId > self.cardArray.count) {
                self.fetchCardAccordingToMaxCardId()
            }
        })
    }

    func removeDuplicateCard() -> [Card] {
        let cardDictionary = NSMutableDictionary()
        var cleanCardArray = [Card]()

        for card in cardArray {
            cardDictionary.setValue(card, forKey: card.cardId!)
        }

        for d in cardDictionary {
            cleanCardArray.append(d.value as! Card)
        }

        return cleanCardArray
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
        
        if let card = DataController().queryCardById(String(maxCardId - indexPath.row)) {
            if (shouldShowNonIdolizedImage(card)) {
                if let url = card.roundCardImage {
                    cell.imageView!.sd_setImageWithURL(NSURL(string: url))
                }
            } else {
                if let url = card.roundCardIdolizedImage {
                    cell.imageView!.sd_setImageWithURL(NSURL(string: url))
                }
            }
        }

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            selectedIndexPath = indexPath
            performSegueWithIdentifier(segueIdentifier, sender: cell)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.identifier == "CardDetail" ? showCardDetailView(segue) : showFilterView(segue)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "CardDetail" {
            return (selectedIndexPath != nil) ? true : false
        } else {
            return true
        }
    }
    
    func showCardDetailView(segue: UIStoryboardSegue) {
        let cardDetailController = segue.destinationViewController as! CardDetailController;
        cardDetailController.cardId = String(maxCardId - selectedIndexPath!.row)
        selectedIndexPath = nil
    }
    
    func showFilterView(segue: UIStoryboardSegue) {
        let filterController = segue.destinationViewController
        filterController.modalPresentationStyle = UIModalPresentationStyle.Popover
        filterController.popoverPresentationController!.delegate = self
    }

    func shouldShowNonIdolizedImage(card: Card) -> Bool {
        return !isIdolized && card.isSpecial == 0 && card.isPromo == 0
    }
}