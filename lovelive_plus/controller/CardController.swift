import UIKit

class CardController: UICollectionViewController {

    @IBOutlet var cardCollectionView: UICollectionView?

    private let reuseIdentifier = "CardCell"
    private var cardArray = [Card]()
    private var roundIdolizeImageDictionary = NSMutableDictionary()
    private var maxCardId = 0
    private var selectedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoundImageArray()

        cardCollectionView?.backgroundColor = Color.Blue50()
    }

    func loadRoundImageArray() {
        cardArray = DataController().queryAllCards()
        cardArray.count < 60 ? fetchCardDataFromInternet() : updateCardArray()
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
        cardArray = cardArray.sort({ Int($0.cardId!) > Int($1.cardId!) })
        roundIdolizeImageDictionary.removeAllObjects()

        for card in cardArray {
            roundIdolizeImageDictionary.setValue(card.roundCardIdolizedImage!, forKey: card.cardId!)
        }
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
        
        if roundIdolizeImageDictionary.count > indexPath.row {
            if let url = roundIdolizeImageDictionary[String(roundIdolizeImageDictionary.count - indexPath.row)] as? String {
                cell.imageView!.sd_setImageWithURL(NSURL(string: url))
            }
        }

        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            selectedIndexPath = indexPath
            performSegueWithIdentifier("CardDetail", sender: cell)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "CardDetail" && selectedIndexPath != nil) {
            let cardDetailController = segue.destinationViewController as! CardDetailController;
            cardDetailController.cardId = String(roundIdolizeImageDictionary.count - selectedIndexPath!.row)
        }
        selectedIndexPath = nil
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return (selectedIndexPath != nil) ? true : false
    }
}