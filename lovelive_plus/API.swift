import Foundation

class API {

	let baseUrl = "http://schoolido.lu/api/"
	let cards = "cards/"
	let cardIds = "cardids/"
	let songs = "songs/"
	let events = "events/"

	func getCards() -> String {
		return baseUrl + cards
	}

	func getCardIds() -> String {
		return baseUrl + cardIds
	}

	func getCardById(cardId: String) -> String {
		return baseUrl + cards + cardId
	}

	func getCardsByFilters(filters: NSDictionary) -> String {
		var query = "?"
		let avaiableFilters = [
			"japanese_name",
			"skill",
			"japanese_skill",
			"skill_details",
			"japanese_skill_details",
			"center_skill",
			"japanese_center_skill",
			"japanese_center_skill_details",
			"japanese_collection",
			"promo_item",
			"event__english_name",
			"event__japanese_name",
			"name",
			"rarity",
			"attribute",
			"idol_year",
			"japan_only",
			"is_promo",
			"is_special",
			"is_event",
			"page",
			"page_size"
		]

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

		for avaiableFilter in avaiableFilters {
			if let f: String = filters[avaiableFilter] as? String {
				query += avaiableFilter + "=" + f + "&"
			}
		}

		if let pageSize = filters["page_size"] {
			query += "page_size=" + String(pageSize)
		} else {
			query += "page_size=48"
		}

		print(baseUrl + cards + query)
		return (baseUrl + cards + query).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
	}

	func getSongsByAttribute(attibute: String!) -> String {
		return baseUrl + songs + "?attribute=" + attibute + "&page_size=100"
	}

	func getEvents() -> String {
		return baseUrl + events + "?ordering=-beginning&page_size=100"
	}

	func getLatestEvent() -> String {
		return baseUrl + events + "?ordering=-beginning&page_size=1"
	}
}
