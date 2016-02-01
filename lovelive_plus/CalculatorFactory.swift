import Foundation
import Darwin

class CalculatorFactory {

    let MINUTES_FOR_ONE_SONG = 3
    let dateTimeNow = NSDate()

    var objectivePoints: CLong?
    var currentPoints: CLong?
    var currentRank: CLong?
    var songAmount: CLong?
    var difficulty: String?
    var wastedLpEveryDay: CLong?
    var pointAddition: Bool?
    var experienceAddition: Bool?
    var songRankRatio: Double?
    var comboRankRatio: Double?
    var currentLp: CLong?
    var currentExperience: CLong?
    var eventEndDay: CLong?
    var eventEndHour: CLong?
    var eventLastTime: Double?
    var eventEndTime: String?

    var currentItem: CLong?
    var eventDifficulty: String?
    var eventRank: String?
    var eventCombo: String?
    var oncePoints: CLong?
    var consumeLp: CLong?
    var expRatio: Int?

    var playRank: String?
    var songRank: String?

    var lovecaAmount: CLong?
    var finalPoints: CLong?
    var finalRank: CLong?
    var finalExperience: CLong?
    var finalLp: CLong?
    var timesNeedToPlay: CLong?
    var totalPlayTime: CLong?
    var playTimeRatio: Double?
    var finalItem: CLong?
    var eventTimesNeedToPlay: CLong?

    init(objectivePoints: String!, currentPoints: String!, currentRank: String!,
         wastedLpEveryDay: String!, currentLp: String!, currentExperience: String!,
         eventEndDay: String!, eventLastTime: String!, currentItem: String!,
         eventDifficulty: String!, eventRank: String!, eventCombo: String!,
         oncePoints: String!, consumeLp: String!, isChineseExp: Bool) {
        self.objectivePoints = parseLongField(objectivePoints)
        self.currentPoints = parseLongField(currentPoints)
        self.currentRank = parseLongField(currentRank)
        self.wastedLpEveryDay = parseLongField(wastedLpEveryDay)
        self.currentLp = parseLongField(currentLp)
        self.currentExperience = parseLongField(currentExperience)
        self.eventEndDay = parseLongField(eventEndDay)
        self.eventLastTime = parseDoubleField(eventLastTime)
        self.currentItem = parseLongField(currentItem)
        self.eventDifficulty = eventDifficulty
        self.eventRank = eventRank
        self.eventCombo = eventCombo
        self.oncePoints = parseLongField(oncePoints)
        self.consumeLp = parseLongField(consumeLp)
        self.expRatio = isChineseExp ? 1 : 2
    }

    func parseDoubleField(value: String?) -> Double {
        return isStringValid(value) ? Double(value!)! : 0.0
    }

    func parseLongField(value: String?) -> CLong {
        return isStringValid(value) ? CLong(value!)! : 0
    }

    func isStringValid(value: String!) -> Bool {
        return value != nil && value != ""
    }

    func calculateNormalProcess() {
        initialisePredictFields()
        if (getBiggestLp() == 0) {
            return
        }
        normalPlayWithFreeLp()
        normalPlayWithLoveca()
        calculateNormalResultAfterPlay()
    }

    func getBiggestLp() -> CLong {
        if (currentRank < 1) {
            return 0
        }
        return currentRank! >= 300 ?
                lround(175.0 + (Double(currentRank!) - 300) / 3) :
                lround(25.0 + Double(currentRank!) / 2.0)
    }

    func initialisePredictFields() {
        lovecaAmount = 0
        finalPoints = currentPoints
        finalRank = 0
        finalExperience = currentExperience
        finalLp = currentLp! + lround(getRecoveryLp())
        finalItem = currentItem
        timesNeedToPlay = 0
        eventTimesNeedToPlay = 0
        totalPlayTime = 0
        playTimeRatio = 0
    }

    func getRecoveryLp() -> Double {
        return eventLastTime! * 10 - Double(getTotalWastedLp())
    }

    func getTotalWastedLp() -> CLong {
        return wastedLpEveryDay! * (eventEndDay! - getDayOfMonth(dateTimeNow))
    }

    func getDayOfMonth(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: date)

        return components.day
    }

    func normalPlayWithFreeLp() {
        while (finalLp >= consumeLp) {
            normalPlayOnceWithEnoughLp()
            while (finalItem >= getConsumeItemWithinOncePlay()) {
                normalPlayOnceWithEnoughItem()
            }
        }
    }

    func normalPlayWithLoveca() {
        while (finalPoints < objectivePoints) {
            consumeOneLoveca()
            while (finalLp >= consumeLp) {
                normalPlayOnceWithEnoughLp()
                while (finalItem >= getConsumeItemWithinOncePlay()) {
                    normalPlayOnceWithEnoughItem()
                }
            }
        }
    }

    func calculateNormalResultAfterPlay() {
        finalRank = currentRank!
        totalPlayTime = (eventTimesNeedToPlay! + timesNeedToPlay!) * MINUTES_FOR_ONE_SONG
        playTimeRatio = Double(totalPlayTime!) / (eventLastTime! * 60.0)
    }

    func consumeOneLoveca() {
        lovecaAmount! += 1
        finalLp! += getBiggestLp()
    }

    func normalPlayOnceWithEnoughLp() {
        finalLp! -= consumeLp!
        timesNeedToPlay! += 1
        finalItem! += getNormalBasicPointsWithinOncePlay()
        finalPoints! += getNormalBasicPointsWithinOncePlay()
        finalExperience! += getNormalExpWithinOncePlay(consumeLp!)
        while (finalExperience >= getCurrentRankUpExp()) {
            upgradeOneRankWithEnoughExp()
        }
    }

    func getConsumeItemWithinOncePlay() -> CLong {
        var isFourMultiply = false
        var difficulty = eventDifficulty!
        if (difficulty.substringToIndex(difficulty.startIndex.advancedBy(1)) == "4") {
            isFourMultiply = true
            difficulty = difficulty.substringFromIndex(difficulty.startIndex.advancedBy(2))
        }
        let consumeItemArray = ["Expert": 75, "Hard": 45, "Normal": 30, "Easy": 15]

        return isFourMultiply ? consumeItemArray[difficulty]! * 4 : consumeItemArray[difficulty]!
    }

    func normalPlayOnceWithEnoughItem() {
        finalItem! -= getConsumeItemWithinOncePlay()
        eventTimesNeedToPlay! += 1
        finalPoints! += oncePoints!
        finalExperience! += getNormalExpWithinOncePlay(eventDifficulty!)
        while (finalExperience >= getCurrentRankUpExp()) {
            upgradeOneRankWithEnoughExp()
        }
    }

    func getNormalExpWithinOncePlay(eventDifficulty: String) -> CLong {
        var difficulty = eventDifficulty
        if (difficulty.substringToIndex(difficulty.startIndex.advancedBy(1)) == "4") {
            difficulty = difficulty.substringFromIndex(difficulty.startIndex.advancedBy(2))
        }

        let normalExpArray = ["Expert": 83, "Hard": 46, "Normal": 26, "Easy": 12]

        return normalExpArray[difficulty]!
    }

    func getCurrentRankUpExp() -> CLong {
        return getRankUpExpByRank(currentRank)
    }

    func getRankUpExpByRank(rank: CLong!) -> CLong {
        if rank < 1 {
            return 0
        }
        if rank < 34 {
            return lround(Double(rank) * Double(rank) * 0.56 / Double(expRatio!))
        }
        if rank < 100 {
            return lround((34.45 * Double(rank) - 551) / Double(expRatio!))
        }
        if rank >= 100 {
            return lround(34.45 * Double(rank) - 551)
        }
        return 0
    }

    func upgradeOneRankWithEnoughExp() {
        finalExperience! -= getCurrentRankUpExp()
        currentRank! += 1
        finalLp! += getBiggestLp()
    }

    func getFinalRankUpExp() -> CLong {
        return getRankUpExpByRank(CLong(getFinalRank()))
    }

    func getNormalBasicPointsWithinOncePlay() -> CLong {
        let normalBasicPointsArray = [25: 27, 15: 16, 10: 10, 5: 5]

        return normalBasicPointsArray[consumeLp!]!
    }

    func getNormalExpWithinOncePlay(consumeLP: CLong) -> CLong {
        let normalExpArray = [25: 83, 15: 46, 10: 26, 5: 12]

        return normalExpArray[consumeLP]!
    }

    func getLovecaAmount() -> String {
        return lovecaAmount! < 0 ? "0" : String(lovecaAmount!)
    }

    func getFinalPoints() -> String {
        return String(finalPoints!)
    }

    func getFinalRank() -> String {
        return String(finalRank!)
    }

    func getFinalExp() -> String {
        return String(finalExperience!)
    }

    func getFinalLp() -> String {
        return String(finalLp!)
    }

    func getFinalItem() -> String {
        return String(finalItem!)
    }

    func getTimesNeedToPlay() -> String {
        return String(timesNeedToPlay!)
    }

    func getEventTimesNeedToPlay() -> String {
        return String(eventTimesNeedToPlay!)
    }

    func getTotalPlayTime() -> String {
        return String(format: "\(totalPlayTime! / 60)时\(totalPlayTime! % 60)分")
    }

    func getPlayTimeRatio() -> String {
        let playTimeRatioFormat = NSNumberFormatter()
        playTimeRatioFormat.maximumIntegerDigits = 5
        playTimeRatioFormat.minimumIntegerDigits = 1
        playTimeRatioFormat.maximumFractionDigits = 2
        playTimeRatioFormat.minimumFractionDigits = 0

        return "\(playTimeRatioFormat.stringFromNumber(playTimeRatio! * 100)!)%"
    }
}