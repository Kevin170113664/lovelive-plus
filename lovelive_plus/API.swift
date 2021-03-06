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

		let translatedFilters = FilterTranslation().translate(filters)

		for avaiableFilter in avaiableFilters {
			if let f: String = translatedFilters[avaiableFilter] as? String {
				query += avaiableFilter + "=" + f + "&"
			}
		}

		if translatedFilters["page_size"] == nil {
			query += "page_size=100"
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
