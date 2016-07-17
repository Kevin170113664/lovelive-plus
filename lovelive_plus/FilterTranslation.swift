class FilterTranslation {

	func translate(filters: NSDictionary) -> NSDictionary {
		if let skill = filters["skill"] as? String {
			if skill == "加分" {
				filters.setValue("Score Up", forKey: "skill")
			}
			if skill == "判定" {
				filters.setValue("Perfect Lock", forKey: "skill")
			}
			if skill == "回复" {
				filters.setValue("Healer", forKey: "skill")
			}
		}

		if let idolYear = filters["idol_year"] as? String {
			if idolYear == "一年级" {
				filters.setValue("First", forKey: "idol_year")
			}
			if idolYear == "二年级" {
				filters.setValue("Second", forKey: "idol_year")
			}
			if idolYear == "三年级" {
				filters.setValue("Three", forKey: "idol_year")
			}
		}

		if let isEvent = filters["is_event"] as? String {
			if isEvent == "是" {
				filters.setValue("True", forKey: "is_event")
			}
			if isEvent == "否" {
				filters.setValue("False", forKey: "is_event")
			}
		}

		if let isPromo = filters["is_promo"] as? String {
			if isPromo == "是" {
				filters.setValue("True", forKey: "is_promo")
			}
			if isPromo == "否" {
				filters.setValue("False", forKey: "is_promo")
			}
		}

		return filters
	}
}
