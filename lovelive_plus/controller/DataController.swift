import Foundation
import UIKit
import CoreData

class DataController: NSObject {
    var maxPage = 0
    var managedObjectContext: NSManagedObjectContext
    let cardService = CardService()

    override init() {
        guard let modelURL = NSBundle.mainBundle().URLForResource("CardModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex - 1]
            let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    func calculateMaxPage(maxCardId: Int) -> Int {
        return maxCardId / 10 + 1
    }

    func queryAllCards() -> [Card] {
        let cardFetch = NSFetchRequest(entityName: "Card")

        do {
            let fetchedCards = try self.managedObjectContext.executeFetchRequest(cardFetch) as! [Card]
            return fetchedCards
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }

        return []
    }

    func cacheAllCards() -> Void {
        cardService.getAllCardIds({
            (cardIdArray: NSArray) -> Void in
            self.maxPage = self.calculateMaxPage(cardIdArray.lastObject as! Int)
            
            for index in 1...self.maxPage {
                self.cardService.getCardList(index, callback: {
                    (onePageOfCards: NSArray) -> Void in
                    self.cacheOnePageOfCards(onePageOfCards)
                })
            }
        })
    }

    func cacheOnePageOfCards(onePageOfCards: NSArray) -> Void {
        for (_, cardObject) in onePageOfCards.enumerate() {
            let cardDictionary = cardObject as! [String: AnyObject]
            var card = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: self.managedObjectContext) as! Card
            card = self.mapDictionary(card, dictionary: cardDictionary)

            do {
                try self.managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func mapDictionary(card: Card, dictionary: [String: AnyObject]) -> Card {
        card.attribute = dictionary["attribute"] as? String
        card.cardId = String(dictionary["id"] as! Int)
        card.cardIdolizedImage = dictionary["card_idolized_image"] as? String
        card.cardImage = dictionary["card_image"] as? String
        card.centerSkill = dictionary["center_skill"] as? String
        card.hp = String(dictionary["hp"] as! Int)
        card.idolizedMaximumStatisticsCool = String(dictionary["idolized_maximum_statistics_cool"] as! Int)
        card.idolizedMaximumStatisticsPure = String(dictionary["idolized_maximum_statistics_pure"] as! Int)
        card.idolizedMaximumStatisticsSmile = String(dictionary["idolized_maximum_statistics_smile"] as! Int)
        card.idolizedMaxLevel = String(dictionary["idolized_max_level"] as! Int)
        card.isPromo = dictionary["is_promo"] as? Bool
        card.isSpecial = dictionary["is_special"] as? Bool
        card.japaneseAttribute = dictionary["japanese_attribute"] as? String
        card.japaneseCenterSkill = dictionary["japanese_center_skill"] as? String
        card.japaneseCenterSkillDetails = dictionary["japanese_center_skill_details"] as? String
        card.japaneseCollection = dictionary["japanese_collection"] as? String
        card.japaneseName = dictionary["japanese_name"] as? String
        card.japaneseSkill = dictionary["japanese_skill"] as? String
        card.japaneseSkillDetails = dictionary["japanese_skill_details"] as? String
        card.japaneseVideoStory = dictionary["japanese_video_story"] as? String
        card.japanOnly = dictionary["japan_only"] as? Bool
        card.minimumStatisticsCool = String(dictionary["minimum_statistics_cool"] as! Int)
        card.minimumStatisticsPure = String(dictionary["minimum_statistics_pure"] as! Int)
        card.minimumStatisticsSmile = String(dictionary["minimum_statistics_smile"] as! Int)
        card.name = dictionary["name"] as? String
        card.nonIdolizedMaximumStatisticsCool = String(dictionary["non_idolized_maximum_statistics_cool"] as! Int)
        card.nonIdolizedMaximumStatisticsPure = String(dictionary["non_idolized_maximum_statistics_pure"] as! Int)
        card.nonIdolizedMaximumStatisticsSmile = String(dictionary["non_idolized_maximum_statistics_smile"] as! Int)
        card.nonIdolizedMaxLevel = String(dictionary["non_idolized_max_level"] as! Int)
        card.ownedCards = dictionary["owned_cards"] as? String
        card.promoItem = dictionary["promo_item"] as? String
        card.rarity = dictionary["rarity"] as? String
        card.releaseDate = dictionary["release_date"] as? String
        card.roundCardIdolizedImage = dictionary["round_card_idolized_image"] as? String
        card.roundCardImage = dictionary["round_card_image"] as? String
        card.skill = dictionary["skill"] as? String
        card.skillDetails = dictionary["skill_details"] as? String
        card.transparentIdolizedImage = dictionary["transparent_idolized_image"] as? String
        card.transparentIdolizedUrPair = dictionary["transparent_idolized_ur_pair"] as? String
        card.transparentImage = dictionary["transparent_image"] as? String
        card.transparentUrPair = dictionary["transparent_ur_pair"] as? String
        card.videoStory = dictionary["video_story"] as? String
        card.websiteUrl = dictionary["website_url"] as? String
        card.eventModel = dictionary["event"] as? NSManagedObject
        card.idolModel = dictionary["idol"] as? NSManagedObject

        return card
    }

}