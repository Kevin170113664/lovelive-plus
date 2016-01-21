import UIKit

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var popupFilter: UIView!
    @IBOutlet weak var firstLinePicker: UIPickerView!
    @IBOutlet weak var secondLinePicker: UIPickerView!
    @IBOutlet weak var thirdLinePicker: UIPickerView!
    
    let rarityPickerData = [["稀有度", "UR", "SR", "R", "N"],
        ["角色", "高坂穂乃果", "南ことり", "園田海未", "小泉花陽", "西木野真姫", "星空凛", "東條希", "矢澤にこ", "絢瀬絵里"],
        ["属性", "Smile", "Pure", "Cool"]]

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rarityPickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rarityPickerData[component][row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.Blue100()

        firstLinePicker.delegate = self
        firstLinePicker.dataSource = self

        secondLinePicker.delegate = self
        secondLinePicker.dataSource = self

        thirdLinePicker.delegate = self
        thirdLinePicker.dataSource = self
    }
}