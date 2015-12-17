import UIKit

class ViewController: UIViewController {

    @IBOutlet var eventImage: UIImageView?
    @IBOutlet var cardNavigator: UIImageView?
    @IBOutlet var mfNavigator: UIImageView?
    @IBOutlet var smNavigator: UIImageView?
    @IBOutlet var normalNavigator: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowForNavigator()
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

