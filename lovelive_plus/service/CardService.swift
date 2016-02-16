import Foundation
import Alamofire
import SwiftyJSON

class CardService {

    let baseUrl = "http://schoolido.lu/api/"
    let cards = "cards/"
    let cardIds = "cardids/"

    init() {
        Alamofire.Manager().session.configuration.timeoutIntervalForRequest = 30
        Alamofire.Manager().session.configuration.timeoutIntervalForResource = 30
    }

    func getCardList(page: Int, callback: (NSArray) -> Void) -> Void {
        let url = baseUrl + cards
        
        Alamofire.request(.GET, url, parameters: ["page": page])
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
        let url = baseUrl + cards + id
        Alamofire.request(.GET, url)
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
        let url = baseUrl + cardIds
        
        Alamofire.request(.GET, url)
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


