import UIKit

class CardController: UIViewController {
    
    @IBOutlet var backButton: UINavigationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseManager = DatabaseManager()
        databaseManager.initDatabase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
