import UIKit

class MainController: UIViewController {

    @IBOutlet var eventImage: UIButton?
    @IBOutlet var cardNavigator: UIButton?
    @IBOutlet var mfNavigator: UIButton?
    @IBOutlet var smNavigator: UIButton?
    @IBOutlet var normalNavigator: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowForNavigator()

        let cardService = CardService()
        cardService.getCardList(75, callback: { (cardList: NSArray) -> Void in
            print(cardList)
        })
    }

    func setShadowForNavigator() {
        mfNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        mfNavigator!.layer.shadowRadius = 5.0
        mfNavigator!.layer.shadowOpacity = 0.8
        mfNavigator!.layer.masksToBounds = false

        smNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        smNavigator!.layer.shadowRadius = 5.0
        smNavigator!.layer.shadowOpacity = 0.8
        smNavigator!.layer.masksToBounds = false

        normalNavigator!.layer.shadowOffset = CGSizeMake(5, 5)
        normalNavigator!.layer.shadowRadius = 5.0
        normalNavigator!.layer.shadowOpacity = 0.8
        normalNavigator!.layer.masksToBounds = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

