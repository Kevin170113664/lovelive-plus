import Foundation
import Alamofire
import SwiftyJSON

class EventService {

    let baseUrl = "http://schoolido.lu/api/"
    let events = "events/"

    init() {
        Alamofire.Manager().session.configuration.timeoutIntervalForRequest = 30
        Alamofire.Manager().session.configuration.timeoutIntervalForResource = 30
    }

    func getLatestEvent(pageSize: Int, callback: (NSArray) -> Void) -> Void {
        let url = baseUrl + events
        
        Alamofire.request(.GET, url, parameters: ["ordering": "-beginning", "page_size": pageSize])
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


