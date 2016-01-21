import UIKit

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var popupFilter: UIView!
    @IBOutlet weak var firstLinePicker: UIPickerView!
    @IBOutlet weak var secondLinePicker: UIPickerView!
    @IBOutlet weak var thirdLinePicker: UIPickerView!

    @IBAction func okButtonClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
            () -> Void in }
    }

    let firstLinePickerData = [["稀有度", "UR", "SR", "R", "N"],
                               ["角色", "高坂穂乃果", "南ことり", "園田海未", "小泉花陽", "西木野真姫", "星空凛", "東條希", "矢澤にこ", "絢瀬絵里"],
                               ["属性", "Smile", "Pure", "Cool"]]
    let secondLinePickerData = [["年级", "一年级", "二年级", "三年级"],
                                ["小组", "Printemps", "BiBi", "Lily White"],
                                ["技能类型", "加分", "判定", "回复"]]
    let thirdLinePickerData = [["活动卡", "是", "否"], ["特典卡", "是", "否"],
                               ["卡牌主题", "クリスマス編", "舞踏会編", "動物編part2", "くのいち編", "プール編", "マリン編", "手品師編",
                                "サイバー編", "職業編Part2", "ホワイトデー編", "バレンタイン編", "七福神編", "雪山編", "星座編",
                                "ハロウィン編", "カフェメイド編", "チャイナドレス編", "7月編", "6月編", "5月編", "4月編",
                                "3月編", "2月編", "1月編", "12月編", "11月編", "10月編", "9月編", "8月編", "動物編", "職業編", "初期", ]]

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView) {
        case firstLinePicker: return firstLinePickerData[component].count
        case secondLinePicker: return secondLinePickerData[component].count
        case thirdLinePicker: return thirdLinePickerData[component].count
        default: return 0
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView) {
        case firstLinePicker: return firstLinePickerData[component][row]
        case secondLinePicker: return secondLinePickerData[component][row]
        case thirdLinePicker: return thirdLinePickerData[component][row]
        default: return ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.Blue50()

        firstLinePicker.delegate = self
        firstLinePicker.dataSource = self
        firstLinePicker.showsSelectionIndicator = false

        secondLinePicker.delegate = self
        secondLinePicker.dataSource = self
        secondLinePicker.showsSelectionIndicator = false

        thirdLinePicker.delegate = self
        thirdLinePicker.dataSource = self
        thirdLinePicker.showsSelectionIndicator = false
    }
}