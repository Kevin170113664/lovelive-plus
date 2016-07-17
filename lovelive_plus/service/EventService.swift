import Foundation
import Alamofire
import SwiftyJSON

class EventService {

	var api = API()

	init() {
		Alamofire.Manager().session.configuration.timeoutIntervalForRequest = 30
		Alamofire.Manager().session.configuration.timeoutIntervalForResource = 30
	}

	func getLatestEvent(pageSize: Int, callback: (NSArray) -> Void) -> Void {
		Alamofire.request(.GET, api.getLatestEvent())
		.responseJSON {
			response in
			guard response.result.error == nil else {
				print(response.result.error!)
				return
			}
			if let value: AnyObject = response.result.value {
				let json = JSON(value)
				callback(json["results"].arrayObject!)
			}
		}
	}

	func getEvents(callback: (NSArray) -> Void) -> Void {
		Alamofire.request(.GET, api.getEvents())
		.responseJSON {
			response in
			guard response.result.error == nil else {
				print(response.result.error!)
				return
			}
			if let value: AnyObject = response.result.value {
				callback(JSON(value)["results"].arrayObject!)
			}
		}
	}
}


