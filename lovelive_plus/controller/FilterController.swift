import UIKit

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var popupFilter: UIView!
	@IBOutlet weak var firstLinePicker: UIPickerView!
	@IBOutlet weak var secondLinePicker: UIPickerView!
	@IBOutlet weak var thirdLinePicker: UIPickerView!

	@IBAction func okButtonClick(sender: AnyObject) {
		self.dismissViewControllerAnimated(true) {
			() -> Void in
			let filter = NSMutableDictionary()

			for component in 0 ..< 3 {
				for (_, picker) in self.getPickerArray().enumerate() {
					let selectedRow = picker.0.selectedRowInComponent(component)
					if picker.1[component][selectedRow] != picker.1[component][0] {
						filter.setValue(picker.1[component][selectedRow], forKey: self.filterMap[picker.1[component][0]]!)
					}
				}
			}

			self.delegate?.applyFilterDictionary(filter)
		}
	}

	weak var delegate: FilterPopoverDelegate?

	let filterMap = ["稀有度": "rarity", "角色": "japanese_name", "属性": "attribute", "年级": "idol_year", "小组": "sub_unit",
	                 "技能类型": "skill", "活动卡": "is_event", "特典卡": "is_promo", "卡牌主题": "japanese_collection"]

	let firstLinePickerData = [Rarity().rarities, IdolName().idolNames, Attribute().attributes]
	let secondLinePickerData = [Grade().grades, SubUnit().subUnits, SkillType().skillTypes]
	let thirdLinePickerData = [["活动卡", "是", "否"], ["特典卡", "是", "否"], Collection().collections]

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