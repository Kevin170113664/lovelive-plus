import UIKit

class CardController: UIViewController {
    
    @IBOutlet var backButton: UINavigationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plistManager = PlistManager()
        plistManager.cacheAllCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
