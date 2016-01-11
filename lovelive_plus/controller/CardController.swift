import UIKit

class CardController: UICollectionViewController {
    
    @IBOutlet var cardCollectionView: UICollectionView?
    
    private let reuseIdentifier = "CardCell"
    private var cardArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataController = DataController()
        cardArray = dataController.queryAllCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.backgroundColor = UIColor.whiteColor()

        if let url = cardArray[indexPath.row].roundCardIdolizedImage {
            cell.imageView!.sd_setImageWithURL(NSURL(string: url))
        }
        
        return cell
    }
}