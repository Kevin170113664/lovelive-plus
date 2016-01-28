import UIKit

class CalculateReportController: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBOutlet weak var calculateReportView: UIView!
    @IBOutlet weak var totalLoveCardLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateReportView.backgroundColor = Color.Blue50()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.closeButton.backgroundColor = Color.Blue100()
        self.calculateReportView.layer.cornerRadius = 5
        self.calculateReportView.layer.shadowOpacity = 0.8
        self.calculateReportView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    }
    
    func showInView(aView: UIView!, withMessage message: String!, animated: Bool)
    {
        aView.addSubview(self.view)
        totalLoveCardLabel!.text = message
        if animated
        {
            self.showAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    @IBAction func closeReport(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        self.removeAnimate()
    }
}
