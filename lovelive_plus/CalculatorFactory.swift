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
    var consumeLP: CLong?
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

    func calculatorFactory(objectivePoints: String, currentPoints: String, currentRank: String,
                           wastedLpEveryDay: String, currentLp: String, currentExperience: String,
                           eventEndDay: String, eventLastTime: String, currentItem: String,
                           eventDifficulty: String, eventRank: String, eventCombo: String,
                           oncePoints: String, consumeLP: String, isChineseExp: Bool) {
        self.objectivePoints = parseLongField(objectivePoints);
        self.currentPoints = parseLongField(currentPoints);
        self.currentRank = parseLongField(currentRank);
        self.wastedLpEveryDay = parseLongField(wastedLpEveryDay);
        self.currentLp = parseLongField(currentLp);
        self.currentExperience = parseLongField(currentExperience);
        self.eventEndDay = parseLongField(eventEndDay);
        self.eventLastTime = parseDoubleField(eventLastTime);
        self.currentItem = parseLongField(currentItem);
        self.eventDifficulty = eventDifficulty;
        self.eventRank = eventRank;
        self.eventCombo = eventCombo;
        self.oncePoints = parseLongField(oncePoints);
        self.consumeLP = parseLongField(consumeLP);
        self.expRatio = isChineseExp ? 1 : 2;
    }

    func parseDoubleField(value: String?) -> Double {
        return isStringValid(value) ? Double(value!)! : 0.0;
    }

    func parseLongField(value: String?) -> CLong {
        return isStringValid(value) ? CLong(value!)! : 0;
    }

    func isStringValid(value: String!) -> Bool {
        return value != nil && value != ""
    }

    func calculateNormalProcess() {
        if (getBiggestLp() == 0) {
            return;
        }
        initialisePredictFields();
        normalPlayWithFreeLp();
        normalPlayWithLoveca();
        calculateNormalResultAfterPlay();
    }

    private func getBiggestLp() -> CLong {
        if (currentRank < 1) {
            return 0;
        }
        return currentRank! >= 300 ?
                lround(175.0 + (Double(currentRank!) - 300) / 3) :
                lround(25.0 + Double(currentRank!) / 2.0);
    }

    private func initialisePredictFields() {
        lovecaAmount = 0
        finalPoints = currentPoints
        finalExperience = currentExperience
        finalLp = currentLp! + lround(getRecoveryLp())
        finalItem = currentItem
        timesNeedToPlay = 0
        eventTimesNeedToPlay = 0
    }

    private func getRecoveryLp() -> Double {
        return eventLastTime! * 10 - Double(getTotalWastedLp())
    }

    private func getTotalWastedLp() -> CLong {
        return wastedLpEveryDay! * (eventEndDay! - getDayOfMonth(dateTimeNow));
    }

    private func getDayOfMonth(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: date)

        return components.day
    }

    private func normalPlayWithFreeLp() {
        while (finalLp >= consumeLP) {
            normalPlayOnceWithEnoughLp();
            while (finalItem >= getConsumeItemWithinOncePlay()) {
                normalPlayOnceWithEnoughItem();
            }
        }
    }

    private func normalPlayWithLoveca() {
        while (finalPoints < objectivePoints) {
            consumeOneLoveca();
            while (finalLp >= consumeLP) {
                normalPlayOnceWithEnoughLp();
                while (finalItem >= getConsumeItemWithinOncePlay()) {
                    normalPlayOnceWithEnoughItem();
                }
            }
        }
    }

    private func calculateNormalResultAfterPlay() {
        finalRank! = currentRank!;
        totalPlayTime! = (eventTimesNeedToPlay! + timesNeedToPlay!) * MINUTES_FOR_ONE_SONG;
        playTimeRatio! = Double(totalPlayTime!) / (eventLastTime! * 60.0);
    }

    private func consumeOneLoveca() {
        lovecaAmount! += 1;
        finalLp! += getBiggestLp();
    }

    private func normalPlayOnceWithEnoughLp() {
        finalLp! -= consumeLP!
        timesNeedToPlay! += 1;
        finalItem! += getNormalBasicPointsWithinOncePlay();
        finalPoints! += getNormalBasicPointsWithinOncePlay();
        finalExperience! += getNormalExpWithinOncePlay(consumeLP!);
        while (finalExperience >= getCurrentRankUpExp()) {
            upgradeOneRankWithEnoughExp();
        }
    }

    private func getConsumeItemWithinOncePlay() -> CLong {
        var isFourMultiply = false;
        var difficulty = eventDifficulty!;
        if (difficulty.substringToIndex(difficulty.startIndex) == "4") {
            isFourMultiply = true
            difficulty = difficulty.substringFromIndex(difficulty.startIndex.advancedBy(2))
        }
        let consumeItemArray = ["Expert": 75, "Hard": 45, "Normal": 30, "Easy": 15]

        return isFourMultiply ? consumeItemArray[difficulty]! * 4 : consumeItemArray[difficulty]!;
    }

    private func normalPlayOnceWithEnoughItem() {
        finalItem! -= getConsumeItemWithinOncePlay();
        eventTimesNeedToPlay! += 1;
        finalPoints! += oncePoints!;
        finalExperience! += getNormalExpWithinOncePlay(eventDifficulty!);
        while (finalExperience >= getCurrentRankUpExp()) {
            upgradeOneRankWithEnoughExp();
        }
    }

    private func getNormalExpWithinOncePlay(eventDifficulty: String) -> CLong {
        var difficulty = eventDifficulty;
        if (difficulty.substringToIndex(difficulty.startIndex) == "4") {
            difficulty = difficulty.substringFromIndex(difficulty.startIndex.advancedBy(2))
        }

        let normalExpArray = ["Expert": 83, "Hard": 46, "Normal": 26, "Easy": 12]

        return normalExpArray[difficulty]!
    }

    private func getCurrentRankUpExp() -> CLong {
        return getRankUpExpByRank(currentRank);
    }

    private func getRankUpExpByRank(rank: CLong!) -> CLong {
        if rank < 1 {
            return 0;
        }
        if rank < 34 {
            return lround(Double(rank) * Double(rank) * 0.56 / Double(expRatio!))
        }
        if rank < 100 {
            return lround((34.45 * Double(rank) - 551) / Double(expRatio!))
        }
        if rank >= 100 {
            return lround(34.45 * Double(rank) - 551);
        }
        return 0;
    }

    private func upgradeOneRankWithEnoughExp() {
        finalExperience! -= getCurrentRankUpExp();
        currentRank! += 1;
        finalLp! += getBiggestLp();
    }

    private func getNormalBasicPointsWithinOncePlay() -> CLong {
        let normalBasicPointsArray = [25: 27, 15: 16, 10: 10, 5: 5]

        return normalBasicPointsArray[consumeLP!]!
    }

    private func getNormalExpWithinOncePlay(consumeLP: CLong) -> CLong {
        let normalExpArray = [25: 83, 15: 46, 10: 26, 5: 12]

        return normalExpArray[consumeLP]!
    }
}