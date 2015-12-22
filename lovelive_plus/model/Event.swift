import Foundation

class Event {
    var japaneseName: String
    var romajiName: String
    var englishName: String
    var image: String
    var englishImage: String
    var beginning: String
    var end: String
    var englishBeginning: String
    var englishEnd: String
    var japanCurrent: Bool
    var worldCurrent: Bool
    var cards: [Int]
    var song: String
    var japaneseT1Points: Int
    var japaneseT1Rank: Int
    var japaneseT2Points: Int
    var japaneseT2Rank: Int
    var englishT1Points: Int
    var englishT1Rank: Int
    var englishT2Points: Int
    var englishT2Rank: Int
    var note: String

    init(japaneseName: String, romajiName: String, englishName: String, image: String, englishImage: String,
         beginning: String, end: String, englishBeginning: String, englishEnd: String, japanCurrent: Bool,
         worldCurrent: Bool, cards: [Int], song: String, japaneseT1Points: Int, japaneseT1Rank: Int,
         japaneseT2Points: Int, japaneseT2Rank: Int, englishT1Points: Int, englishT1Rank: Int, englishT2Points: Int,
         englishT2Rank: Int, note: String) {
        self.japaneseName = japaneseName
        self.romajiName = romajiName
        self.englishName = englishName
        self.image = image
        self.englishImage = englishImage
        self.beginning = beginning
        self.end = end
        self.englishBeginning = englishBeginning
        self.englishEnd = englishEnd
        self.japanCurrent = japanCurrent
        self.worldCurrent = worldCurrent
        self.cards = cards
        self.song = song
        self.japaneseT1Points = japaneseT1Points
        self.japaneseT1Rank = japaneseT1Rank
        self.japaneseT2Points = japaneseT2Points
        self.japaneseT2Rank = japaneseT2Rank
        self.englishT1Points = englishT1Points
        self.englishT1Rank = englishT1Rank
        self.englishT2Points = englishT2Points
        self.englishT2Rank = englishT2Rank
        self.note = note
    }
}
