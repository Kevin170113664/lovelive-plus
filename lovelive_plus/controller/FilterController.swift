import UIKit

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var popupFilter: UIView!
    @IBOutlet weak var FirstLinePicker: UIPickerView!
    @IBOutlet weak var SecondLinePicker: UIPickerView!
    @IBOutlet weak var ThirdLinePicker: UIPickerView!
    
    var rarityPickerData = ["UR", "SR", "R", "N"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        self.popupFilter.backgroundColor = Color.Blue50()
        self.popupFilter.layer.cornerRadius = 5
        self.popupFilter.layer.shadowOpacity = 0.8
        self.popupFilter.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        FirstLinePicker.delegate = self
        FirstLinePicker.dataSource = self
        
        SecondLinePicker.delegate = self
        SecondLinePicker.dataSource = self
        
        ThirdLinePicker.delegate = self
        ThirdLinePicker.dataSource = self
    }
    
    func showInView(aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
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
    
    @IBAction func closeFilterPopup(sender: AnyObject) {
        self.removeAnimate()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rarityPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
}