import Foundation
import Alamofire
import SwiftyJSON

class CardService {

	var api = API()

	init() {
		Alamofire.Manager().session.configuration.timeoutIntervalForRequest = 30
		Alamofire.Manager().session.configuration.timeoutIntervalForResource = 30
	}

	func getCardList(page: Int, callback: (NSArray) -> Void) -> Void {
		Alamofire.request(.GET, api.getCards(), parameters: ["page": page])
		.responseJSON {
			response in
			guard response.result.error == nil else {
				print(response.result.error!)
				return
			}
			if let value: AnyObject = response.result.value {
				if JSON(value)["results"] != nil {
					callback(JSON(value)["results"].arrayObject!)
				}
			}
		}
	}

	func getCardById(id: String, callback: (NSDictionary) -> Void) -> Void {
		Alamofire.request(.GET, api.getCardById(id))
		.responseJSON {
			response in
			guard response.result.error == nil else {
				print(response.result.error!)
				return
			}
			if let value: AnyObject = response.result.value {
				callback(JSON(value).dictionaryObject!)
			}
		}
	}

	func getAllCardIds(callback: (NSArray) -> Void) -> Void {
		Alamofire.request(.GET, api.getCardIds())
		.responseJSON {
			response in
			guard response.result.error == nil else {
				print(response.result.error!)
				return
			}
			if let value: AnyObject = response.result.value {
				callback(JSON(value).arrayObject!)
			}
		}
	}
}


