import UIKit

class MainController: UIViewController {

    @IBOutlet var eventImage: UIImageView?
    @IBOutlet var cardNavigator: UIImageView?
    @IBOutlet var mfNavigator: UIImageView?
    @IBOutlet var smNavigator: UIImageView?
    @IBOutlet var normalNavigator: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowForNavigator()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("goToCardPage"))
        cardNavigator!.userInteractionEnabled = true
        cardNavigator!.addGestureRecognizer(tapGestureRecognizer)
    }

    func goToCardPage() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let cardController = storyBoard.instantiateViewControllerWithIdentifier("cardController") as? CardController {
            self.presentViewController(cardController, animated:true, completion:nil)
        } else {}
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

