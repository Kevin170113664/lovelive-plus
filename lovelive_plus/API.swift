import Foundation

class API {

	let baseUrl = "http://schoolido.lu/api/"
	let cards = "cards/"
	let cardIds = "cardids/"

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
			"page"
		]

		for avaiableFilter in avaiableFilters {
			if let f: String = filters[avaiableFilter] as? String {
				query += avaiableFilter + "=" + f + "&"
			}
		}

		return (baseUrl + cards + query + "page_size=48").stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
	}
}
