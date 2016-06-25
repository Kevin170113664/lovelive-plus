import UIKit

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var popupFilter: UIView!
	@IBOutlet weak var firstLinePicker: UIPickerView!
	@IBOutlet weak var secondLinePicker: UIPickerView!
	@IBOutlet weak var thirdLinePicker: UIPickerView!

	@IBAction func okButtonClick(sender: AnyObject) {
		self.dismissViewControllerAnimated(true) {
			() -> Void in
			let filterDictionary = NSMutableDictionary()

			for component in 0 ..< 3 {
				for (_, picker) in self.getPickerArray().enumerate() {
					let selectedRow = picker.0.selectedRowInComponent(component)
					filterDictionary.setValue(picker.1[component][selectedRow], forKey: picker.1[component][0])
				}
			}

			self.delegate?.applyFilterDictionary(filterDictionary)
		}
	}

	weak var delegate: FilterPopoverDelegate?

	let firstLinePickerData = [["稀有度", "UR", "SR", "R", "N"],
	                           ["角色", "高坂 穂乃果", "南 ことり", "園田 海未", "小泉 花陽", "西木野 真姫", "星空 凛", "東條 希", "矢澤 にこ", "絢瀬 絵里"],
	                           ["属性", "Smile", "Pure", "Cool"]]
	let secondLinePickerData = [["年级", "一年级", "二年级", "三年级"],
	                            ["小组", "Printemps", "BiBi", "Lily White"],
	                            ["技能类型", "加分", "判定", "回复"]]
	let thirdLinePickerData = [["活动卡", "是", "否"], ["特典卡", "是", "否"],
	                           ["卡牌主题", "クリスマス編", "舞踏会編", "動物編part2", "くのいち編", "プール編", "マリン編", "手品師編",
	                            "サイバー編", "職業編Part2", "ホワイトデー編", "バレンタイン編", "七福神編", "雪山編", "星座編",
	                            "ハロウィン編", "カフェメイド編", "チャイナドレス編", "7月編", "6月編", "5月編", "4月編",
	                            "3月編", "2月編", "1月編", "12月編", "11月編", "10月編", "9月編", "8月編", "動物編", "職業編", "初期", ]]

	func getPickerArray() -> [UIPickerView:Array<Array<String>>] {
		var pickerArray = [UIPickerView: Array < Array < String>>]()
		pickerArray[firstLinePicker] = firstLinePickerData
		pickerArray[secondLinePicker] = secondLinePickerData
		pickerArray[thirdLinePicker] = thirdLinePickerData

		return pickerArray
	}

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

	func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
		let label = UILabel()
		label.textColor = UIColor.blackColor()
		label.font = UIFont(name: "San Francisco", size: 7.0)
		label.textAlignment = NSTextAlignment.Center

		switch (pickerView) {
		case firstLinePicker: label.text = firstLinePickerData[component][row]
			break
		case secondLinePicker: label.text = secondLinePickerData[component][row]
			break
		case thirdLinePicker: label.text = thirdLinePickerData[component][row]
			break
		default: label.text = ""
		}

		return label
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = Color.Blue50()
		setPicker()
	}

	func setPicker() {
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