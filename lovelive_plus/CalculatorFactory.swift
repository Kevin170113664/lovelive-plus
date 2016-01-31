import Foundation

class CalculatorFactory {

    let MINUTES_FOR_ONE_SONG = 3
//var DateTime dateTimeNow = new DateTime: ?

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
}