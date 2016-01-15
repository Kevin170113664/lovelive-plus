import UIKit

class CardController: UICollectionViewController {

    @IBOutlet var cardCollectionView: UICollectionView?
    @IBOutlet weak var searchItem: UIBarButtonItem!
    @IBOutlet weak var isIdolized: UIBarButtonItem!
    
    private let reuseIdentifier = "CardCell"
    private var cardArray = [Card]()
    private var roundIdolizedImageDictionary = NSMutableDictionary()
    private var roundNonIdolizedImageDictionary = NSMutableDictionary()
    private var maxCardId = 0
    private var selectedIndexPath: NSIndexPath?
    private var isIdolizedIcon = true

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
//        cardArray = cardArray.sort({ Int($0.cardId!) > Int($1.cardId!) })
        roundIdolizedImageDictionary.removeAllObjects()
        roundNonIdolizedImageDictionary.removeAllObjects()

        for card in cardArray {
            roundIdolizedImageDictionary.setValue(card.roundCardIdolizedImage!, forKey: card.cardId!)
            roundNonIdolizedImageDictionary.setValue(card.roundCardImage!, forKey: card.cardId!)
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
        
        if roundIdolizedImageDictionary.count > indexPath.row {
            if let url = roundIdolizedImageDictionary[String(roundIdolizedImageDictionary.count - indexPath.row)] as? String {
                cell.imageView!.sd_setImageWithURL(NSURL(string: url))
            }
        }
//        if roundNonIdolizedImageDictionary.count > indexPath.row {
//            if let url = roundNonIdolizedImageDictionary[String(roundNonIdolizedImageDictionary.count - indexPath.row)] as? String {
//                cell.imageView!.sd_setImageWithURL(NSURL(string: url))
//            }
//        }

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
            cardDetailController.cardId = String(roundIdolizedImageDictionary.count - selectedIndexPath!.row)
        }
        selectedIndexPath = nil
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return (selectedIndexPath != nil) ? true : false
    }

    func nonIdolizedImageExist(cardId: String?) {

    }
}