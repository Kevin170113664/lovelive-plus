import Foundation
import UIKit
import CoreData

class DataController: NSObject {
    let numberOfCardInOnePage = 10
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

        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docURL = urls[urls.endIndex - 1]
        let storeURL = docURL.URLByAppendingPathComponent("DataModel.sqlite")

        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }

    func calculateMaxPage(maxCardId: Int) -> Int {
        return maxCardId / numberOfCardInOnePage + 1
    }

    func queryAllCards() -> [Card] {
        let cardFetch = NSFetchRequest(entityName: "Card")

        do {
            if let cardList = try self.managedObjectContext.executeFetchRequest(cardFetch) as? [Card] {
                return cardList
            } else {
                return []
            }
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }
    }
    
    func queryCardsByFilterDictionary(filterDictionary: NSMutableDictionary) -> [Card] {
        let cardFetch = NSFetchRequest(entityName: "Card")
        cardFetch.predicate = getPredicateByFilter(filterDictionary)
        
        do {
            if let cardList = try self.managedObjectContext.executeFetchRequest(cardFetch) as? [Card] {
                return cardList
            } else {
                return []
            }
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }
    }
    
    func getPredicateByFilter(filterDictionary: NSMutableDictionary) -> NSPredicate {
        var predicateArray = [NSPredicate]()
        
        if filterDictionary["稀有度"] as! String != "稀有度" {
            let rarityPredicate = NSPredicate(format: "rarity = %@", filterDictionary["稀有度"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["角色"] as! String != "角色" {
            let rarityPredicate = NSPredicate(format: "japaneseName = %@", filterDictionary["角色"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["属性"] as! String != "属性" {
            let rarityPredicate = NSPredicate(format: "attribute = %@", filterDictionary["属性"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["年级"] as! String != "年级" {
            let gradeDictionary = NSMutableDictionary()
            gradeDictionary.setValue(["小泉 花陽", "西木野 真姫", "星空 凛"], forKey: "一年级")
            gradeDictionary.setValue(["高坂 穂乃果", "南 ことり", "園田 海未"], forKey: "二年级")
            gradeDictionary.setValue(["東條 希", "矢澤 にこ", "絢瀬 絵里"], forKey: "三年级")
            
            let nameArray = gradeDictionary[filterDictionary["年级"] as! String] as! [String]
            
            let rarityPredicate = NSPredicate(format: "japaneseName = %@ OR japaneseName = %@ OR japaneseName = %@", nameArray[0], nameArray[1], nameArray[2])
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["小组"] as! String != "小组" {
            let rarityPredicate = NSPredicate(format: "rarity = %@", filterDictionary["小组"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["技能类型"] as! String != "技能类型" {
            let rarityPredicate = NSPredicate(format: "rarity = %@", filterDictionary["技能类型"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["活动卡"] as! String != "活动卡" {
            let rarityPredicate = NSPredicate(format: "eventModel != Null")
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["特典卡"] as! String != "特典卡" {
            let rarityPredicate = NSPredicate(format: "isPromo = %@", filterDictionary["特典卡"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        if filterDictionary["卡牌主题"] as! String != "卡牌主题" {
            let rarityPredicate = NSPredicate(format: "japaneseCollection = %@", filterDictionary["卡牌主题"] as! String)
            predicateArray.append(rarityPredicate)
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
    }

    func queryCardById(cardId: String) -> Card? {
        let cardFetch = NSFetchRequest(entityName: "Card")
        cardFetch.predicate = NSPredicate(format: "cardId = %@", cardId)

        do {
            let cardList = try self.managedObjectContext.executeFetchRequest(cardFetch) as? [Card]
            if (cardList?.count > 0) {
                return cardList![0]
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch cards: \(error)")
        }
    }

    func cacheAllCards(callback: () -> Void) -> Void {
        cardService.getAllCardIds({
            (cardIdArray: NSArray) -> Void in
            self.maxPage = self.calculateMaxPage(cardIdArray.lastObject as! Int)

            for index in 1 ... self.maxPage {
                self.cardService.getCardList(index, callback: {
                    (onePageOfCards: NSArray) -> Void in
                    self.cacheOnePageOfCards(onePageOfCards)
                    callback()
                })
            }
        })
    }

    func cacheOnePageOfCards(onePageOfCards: NSArray) -> Void {
        for (_, cardObject) in onePageOfCards.enumerate() {
            let cardDictionary = cardObject as! [String:AnyObject]
            if (queryCardById(String(cardDictionary["id"] as! Int)) != nil) {
                continue
            } else {
                self.cacheCard(cardObject)
            }
        }
    }
    
    func updateLatest20Cards(maxCardId: Int) {
        if maxCardId > 20 {
            for var cardId = maxCardId; cardId >= maxCardId - 19; cardId-- {
                self.cardService.getCardById(String(cardId), callback: {
                    (card: NSDictionary) -> Void in
                    self.updateCard(card)
                })
            }
        }
    }
    
    func updateCard(card: NSDictionary) {
        deleteCardById(String(card["id"] as! Int))
        cacheCard(card)
    }
    
    func deleteCardById(cardId: String) {
        let cardFetch = NSFetchRequest(entityName: "Card")
        cardFetch.predicate = NSPredicate(format: "cardId = %@", cardId)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: cardFetch)
        
        do {
            try managedObjectContext.executeRequest(deleteRequest)
        } catch let error as NSError {
            print("Failed to delete card by id: \(cardId)")
            fatalError("Failed to delete card: \(error)")
        }
    }

    func cacheCard(cardObject: AnyObject) -> Void {
        let card = newCard(cardObject)

        if let idol = newIdol(cardObject as! [String:AnyObject]) {
            card.setValue(idol, forKey: "idolModel")
        }

        if let event = newEvent(cardObject as! [String:AnyObject]) {
            card.setValue(event, forKey: "eventModel")
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func newCard(cardObject: AnyObject) -> Card {
        let cardDictionary = cardObject as! [String:AnyObject]
        let card = NSEntityDescription.insertNewObjectForEntityForName("Card", inManagedObjectContext: self.managedObjectContext) as! Card

        return self.mapCard(card, dictionary: cardDictionary)
    }

    func newIdol(cardDictionary: [String:AnyObject]) -> Idol? {
        if let idolDictionary = cardDictionary["idol"] as? [String:AnyObject] {
            var idol = NSEntityDescription.insertNewObjectForEntityForName("Idol", inManagedObjectContext: self.managedObjectContext) as! Idol
            idol = self.mapIdol(idol, dictionary: idolDictionary)

            if let cv = newCv(idolDictionary) {
                idol.setValue(cv, forKey: "cvModel")
            }

            return idol
        } else {
            return nil
        }
    }

    func newEvent(cardDictionary: [String:AnyObject]) -> Event? {
        if let eventDictionary = cardDictionary["event"] as? [String:AnyObject] {
            let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: self.managedObjectContext) as! Event
            return self.mapEvent(event, dictionary: eventDictionary)
        } else {
            return nil
        }
    }

    func newCv(idolDictionary: [String:AnyObject]) -> Cv? {
        if let cvDictionary = idolDictionary["cv"] as? [String:AnyObject] {
            let cv = NSEntityDescription.insertNewObjectForEntityForName("Cv", inManagedObjectContext: self.managedObjectContext) as! Cv
            return self.mapCv(cv, dictionary: cvDictionary)
        } else {
            return nil
        }
    }

    func mapCard(card: Card, dictionary: [String:AnyObject]) -> Card {
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

        return card
    }

    func mapIdol(idol: Idol, dictionary: [String:AnyObject]) -> Idol {
        idol.age = dictionary["age"] as? Int
        idol.astrologicalSign = dictionary["astrological_sign"] as? String
        idol.attribute = dictionary["attribute"] as? String
        idol.birthday = dictionary["birthday"] as? String
        idol.blood = dictionary["blood"] as? String
        idol.chibi = dictionary["chibi"] as? String
        idol.chibiSmall = dictionary["chibi_small"] as? String
        idol.favoriteFood = dictionary["favorite_food"] as? String
        idol.height = dictionary["height"] as? Int
        idol.hobbies = dictionary["hobbies"] as? String
        idol.japaneseName = dictionary["japanese_name"] as? String
        idol.leastFavoriteFood = dictionary["least_favorite_food"] as? String
        idol.main = dictionary["main"] as? Bool
        idol.measurements = dictionary["measurements"] as? String
        idol.name = dictionary["name"] as? String
        idol.officialUrl = dictionary["official_url"] as? String
        idol.subUnit = dictionary["sub_unit"] as? String
        idol.summary = dictionary["summary"] as? String
        idol.websiteUrl = dictionary["website_url"] as? String
        idol.wikiaUrl = dictionary["wikia_url"] as? String
        idol.wikiUrl = dictionary["wiki_url"] as? String
        idol.year = dictionary["year"] as? String

        return idol
    }

    func mapEvent(event: Event, dictionary: [String:AnyObject]) -> Event {
        event.beginning = dictionary["beginning"] as? String
        event.cards = dictionary["cards"] as? String
        event.end = dictionary["end"] as? String
        event.englishBeginning = dictionary["english_beginning"] as? String
        event.englishEnd = dictionary["english_end"] as? String
        event.englishImage = dictionary["english_image"] as? String
        event.englishName = dictionary["english_name"] as? String
        event.englishT1Points = dictionary["english_t1_points"] as? Int
        event.englishT1Rank = dictionary["english_t1_rank"] as? Int
        event.englishT2Points = dictionary["english_t2_points"] as? Int
        event.englishT2Rank = dictionary["english_t2_rank"] as? Int
        event.image = dictionary["image"] as? String
        event.japanCurrent = dictionary["japan_current"] as? Bool
        event.japaneseName = dictionary["japanese_name"] as? String
        event.japaneseT1Points = dictionary["japanese_t1_points"] as? Int
        event.japaneseT1Rank = dictionary["japanese_t1_rank"] as? Int
        event.japaneseT2Points = dictionary["japanese_t2_points"] as? Int
        event.japaneseT2Rank = dictionary["japanese_t2_rank"] as? Int
        event.note = dictionary["note"] as? String
        event.romajiName = dictionary["romaji_name"] as? String
        event.song = dictionary["song"] as? String
        event.worldCurrent = dictionary["world_current"] as? Bool

        return event
    }

    func mapCv(cv: Cv, dictionary: [String:AnyObject]) -> Cv {
        cv.instagram = dictionary["instagram"] as? String
        cv.name = dictionary["name"] as? String
        cv.nickname = dictionary["nickname"] as? String
        cv.twitter = dictionary["twitter"] as? String
        cv.url = dictionary["url"] as? String

        return cv
    }
}