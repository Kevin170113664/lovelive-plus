import Foundation
import CoreData

extension Event {

    @NSManaged var beginning: String?
    @NSManaged var cards: String?
    @NSManaged var end: String?
    @NSManaged var englishBeginning: String?
    @NSManaged var englishEnd: String?
    @NSManaged var englishImage: String?
    @NSManaged var englishName: String?
    @NSManaged var englishT1Points: NSNumber?
    @NSManaged var englishT1Rank: NSNumber?
    @NSManaged var englishT2Points: NSNumber?
    @NSManaged var englishT2Rank: NSNumber?
    @NSManaged var image: String?
    @NSManaged var japanCurrent: NSNumber?
    @NSManaged var japaneseName: String?
    @NSManaged var japaneseT1Points: NSNumber?
    @NSManaged var japaneseT1Rank: NSNumber?
    @NSManaged var japaneseT2Points: NSNumber?
    @NSManaged var japaneseT2Rank: NSNumber?
    @NSManaged var note: String?
    @NSManaged var romajiName: String?
    @NSManaged var song: String?
    @NSManaged var worldCurrent: NSNumber?

}
