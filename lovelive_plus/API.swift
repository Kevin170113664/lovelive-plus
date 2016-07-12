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
}
