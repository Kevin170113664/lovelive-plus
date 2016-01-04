import UIKit

class CardController: UIViewController {
    
    @IBOutlet var backButton: UINavigationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataController().cacheAllCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
