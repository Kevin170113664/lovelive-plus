import Foundation
import RealmSwift

class EventModel: Object {

	var beginning: String?
	var cards: String?
	var end: String?
	var englishBeginning: String?
	var englishEnd: String?
	var englishImage: String?
	var englishName: String?
	var englishT1Points: NSNumber?
	var englishT1Rank: NSNumber?
	var englishT2Points: NSNumber?
	var englishT2Rank: NSNumber?
	var image: String?
	var japanCurrent: NSNumber?
	var japaneseName: String?
	var japaneseT1Points: NSNumber?
	var japaneseT1Rank: NSNumber?
	var japaneseT2Points: NSNumber?
	var japaneseT2Rank: NSNumber?
	var note: String?
	var romajiName: String?
	var song: String?
	var worldCurrent: NSNumber?

}
