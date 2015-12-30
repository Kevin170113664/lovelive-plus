import Foundation

class PlistManager {

    let cachedFilePath: String = NSTemporaryDirectory() + "card.json"
    let maxPage = 77
    var cardArray: NSArray = NSArray()

    func queryAllCards() -> NSArray {
        cardArray = NSArray(contentsOfFile: cachedFilePath)!
        return cardArray
    }

    func cacheAllCards() -> Void {
        let cardService = CardService()

        for index in 1 ... maxPage {
            cardService.getCardList(index, callback: {
                (onePageOfCards: NSArray) -> Void in

            })
        }
    }
}