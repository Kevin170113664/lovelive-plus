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
    
    func getPredicateByFilter(filterDictionary: NSMutableDictionary) -> NSPredicate {
        var predicateArray = [NSPredicate]()
        
        if filterDictionary["稀有度"] as! String != "稀有度" {
            let predicate = NSPredicate(format: "rarity = %@", filterDictionary["稀有度"] as! String)
            predicateArray.append(predicate)
        }
        
        if filterDictionary["角色"] as! String != "角色" {
            let predicate = NSPredicate(format: "japaneseName = %@", filterDictionary["角色"] as! String)
            predicateArray.append(predicate)
        }
        
        if filterDictionary["属性"] as! String != "属性" {
            let predicate = NSPredicate(format: "attribute = %@", filterDictionary["属性"] as! String)
            predicateArray.append(predicate)
        }
        
        if filterDictionary["年级"] as! String != "年级" {
            let nameArray = getGradeNameArray(filterDictionary["年级"] as! String)
            let predicate = NSPredicate(format: "japaneseName = %@ OR japaneseName = %@ OR japaneseName = %@", nameArray[0], nameArray[1], nameArray[2])
            predicateArray.append(predicate)
        }
        
        if filterDictionary["小组"] as! String != "小组" {
            let nameArray = getSubUnitNameArray(filterDictionary["小组"] as! String)
            let predicate = NSPredicate(format: "japaneseName = %@ OR japaneseName = %@ OR japaneseName = %@", nameArray[0], nameArray[1], nameArray[2])
            predicateArray.append(predicate)
        }
        
        if filterDictionary["技能类型"] as! String != "技能类型" {
            let skillTypeArray = getSkillTypeArray(filterDictionary["技能类型"] as! String)
            let predicate = NSPredicate(format: "skill IN %@", skillTypeArray)
            predicateArray.append(predicate)
        }
        
        if filterDictionary["活动卡"] as! String != "活动卡" {
            let predicate = NSPredicate(format: getEventCardFilterFormat(filterDictionary["活动卡"] as! String))
            predicateArray.append(predicate)
        }
        
        if filterDictionary["特典卡"] as! String != "特典卡" {
            let predicate = NSPredicate(format: getPromoCardFilterFormat(filterDictionary["特典卡"] as! String))
            predicateArray.append(predicate)
        }
        
        if filterDictionary["卡牌主题"] as! String != "卡牌主题" {
            let predicate = NSPredicate(format: "japaneseCollection = %@", filterDictionary["卡牌主题"] as! String)
            predicateArray.append(predicate)
        }
        
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
    }
    
    func cacheAllCards(callback: () -> Void) -> Void {
        cardService.getAllCardIds({
            (cardIdArray: NSArray) -> Void in
            self.maxPage = self.calculateMaxPage(cardIdArray.lastObject as! Int)

            for index in 1 ... self.maxPage {
                self.cardService.getCardList(index, callback: {
                    (onePageOfCards: NSArray) -> Void in
                    self.cacheOnePageOfCards(onePageOfCards)
                    if index >= self.maxPage - 1 {
                        callback()
                    }
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
        if #available(iOS 9.0, *) {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: cardFetch)
            do {
                try managedObjectContext.executeRequest(deleteRequest)
            } catch let error as NSError {
                print("Failed to delete card by id: \(cardId)")
                print(error)
            }
        } else {
            do {
                let results = try managedObjectContext.executeFetchRequest(cardFetch)
                if let managedObjects = results as? [NSManagedObject] {
                    for object in managedObjects {
                        managedObjectContext.deleteObject(object)
                    }
                }
            } catch let error as NSError {
                print("Failed to delete card by id: \(cardId)")
                print(error)
            }
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

        return ModelMapper().mapCard(card, dictionary: cardDictionary)
    }

    func newIdol(cardDictionary: [String:AnyObject]) -> Idol? {
        if let idolDictionary = cardDictionary["idol"] as? [String:AnyObject] {
            var idol = NSEntityDescription.insertNewObjectForEntityForName("Idol", inManagedObjectContext: self.managedObjectContext) as! Idol
            idol = ModelMapper().mapIdol(idol, dictionary: idolDictionary)

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
            return ModelMapper().mapEvent(event, dictionary: eventDictionary)
        } else {
            return nil
        }
    }

    func newCv(idolDictionary: [String:AnyObject]) -> Cv? {
        if let cvDictionary = idolDictionary["cv"] as? [String:AnyObject] {
            let cv = NSEntityDescription.insertNewObjectForEntityForName("Cv", inManagedObjectContext: self.managedObjectContext) as! Cv
            return ModelMapper().mapCv(cv, dictionary: cvDictionary)
        } else {
            return nil
        }
    }
    
    func getGradeNameArray(grade: String) -> [String] {
        let gradeDictionary = NSMutableDictionary()
        gradeDictionary.setValue(["小泉 花陽", "西木野 真姫", "星空 凛"], forKey: "一年级")
        gradeDictionary.setValue(["高坂 穂乃果", "南 ことり", "園田 海未"], forKey: "二年级")
        gradeDictionary.setValue(["東條 希", "矢澤 にこ", "絢瀬 絵里"], forKey: "三年级")
        
        return gradeDictionary[grade] as! [String]
    }
    
    func getSubUnitNameArray(subUnit: String) -> [String] {
        let subUnitDictionary = NSMutableDictionary()
        subUnitDictionary.setValue(["小泉 花陽", "高坂 穂乃果", "南 ことり"], forKey: "Printemps")
        subUnitDictionary.setValue(["矢澤 にこ", "絢瀬 絵里", "西木野 真姫"], forKey: "BiBi")
        subUnitDictionary.setValue(["東條 希", "星空 凛", "園田 海未"], forKey: "Lily White")
        
        return subUnitDictionary[subUnit] as! [String]
    }
    
    func getEventCardFilterFormat(isEventCard: String) -> String {
        return isEventCard == "是" ? "eventModel != Null" : "eventModel = Null"
    }
    
    func getPromoCardFilterFormat(isPromoCard: String) -> String {
        return isPromoCard == "是" ? "isPromo = 1" : "isPromo = 0"
    }
    
    func getSkillTypeArray(skillType: String) -> [String] {
        let skillTypeDictionary = NSMutableDictionary()
        skillTypeDictionary.setValue(["Score Up", "Total Charm", "Timer Charm", "Rhythmical Charm", "Perfect Charm"], forKey: "加分")
        skillTypeDictionary.setValue(["Perfect Lock", "Total Trick", "Timer Trick"], forKey: "判定")
        skillTypeDictionary.setValue(["Healer", "Total Yell", "Timer Yell", "Rhythmical Yell", "Perfect Yell"], forKey: "回复")
        
        return skillTypeDictionary[skillType] as! [String]
    }
}