import Foundation
import Alamofire
import SwiftyJSON

class EventService {

    let baseUrl = "http://schoolido.lu/api/"
    let cards = "events/"

    init() {

    }

    func getLatestEvent(callback: (NSArray) -> Void) -> Void {
        let url = baseUrl + cards
        Alamofire.request(.GET, url, parameters: ["ordering": "-beginning", "page_size": 1])
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
}


