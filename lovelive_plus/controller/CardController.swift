import UIKit

class CardController: UICollectionViewController {

    @IBOutlet var cardCollectionView: UICollectionView?

    private let reuseIdentifier = "CardCell"
    private var cardArray = [Card]()
    private var roundIdolizeImageArray = [String]()
    private var maxCardId = 0

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
        roundIdolizeImageArray.removeAll()

        for card in cardArray {
            roundIdolizeImageArray.append(card.roundCardIdolizedImage!)
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
        if roundIdolizeImageArray.count > indexPath.row {
            if let url: String = roundIdolizeImageArray[indexPath.row] {
                cell.imageView!.sd_setImageWithURL(NSURL(string: url))
            }
        }

        return cell
    }
}