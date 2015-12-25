import Foundation
import Alamofire

class CardService {

    let baseUrl = "http://schoolido.lu/api/"
    let cards = "cards/"

    init() {

    }

    func getCardList(page: Int) {
        let url = baseUrl + cards
        Alamofire.request(.GET, url, parameters: ["page": page])
        .responseJSON {
            response in

            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

}


