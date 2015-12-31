import UIKit

class CardController: UIViewController {
    
    @IBOutlet var backButton: UINavigationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let c = DataController()
        c.cacheAllCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
