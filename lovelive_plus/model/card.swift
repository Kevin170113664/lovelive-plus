import Foundation

class Card {

    var cardId: String
    var name: String
    var japaneseName: String
    var idolModel: Idol
    var japaneseCollection: String
    var rarity: String
    var attribute: String
    var japaneseAttribute: String
    var isPromo: Bool
    var promoItem: String
    var releaseDate: String
    var japanOnly: Bool
    var eventModel: Event
    var isSpecial: Bool
    var hp: String
    var minimumStatisticsSmile: String
    var minimumStatisticsPure: String
    var minimumStatisticsCool: String
    var nonIdolizedMaximumStatisticsSmile: String
    var nonIdolizedMaximumStatisticsPure: String
    var nonIdolizedMaximumStatisticsCool: String
    var idolizedMaximumStatisticsSmile: String
    var idolizedMaximumStatisticsPure: String
    var idolizedMaximumStatisticsCool: String
    var skill: String
    var japaneseSkill: String
    var skillDetails: String
    var japaneseSkillDetails: String
    var centerSkill: String
    var japaneseCenterSkill: String
    var japaneseCenterSkillDetails: String
    var cardImage: String
    var cardIdolizedImage: String
    var roundCardImage: String
    var roundCardIdolizedImage: String
    var videoStory: String
    var japaneseVideoStory: String
    var websiteUrl: String
    var nonIdolizedMaxLevel: String
    var idolizedMaxLevel: String
    var ownedCards: String
    var transparentImage: String
    var transparentIdolizedImage: String
    var transparentUrPair: String
    var transparentIdolizedUrPair: String

    init(cardId: String, name: String, japaneseName: String, idolModel: Idol, japaneseCollection: String, rarity: String,
         attribute: String, japaneseAttribute: String, isPromo: Bool, promoItem: String, releaseDate: String, japanOnly: Bool,
         eventModel: Event, isSpecial: Bool, hp: String, minimumStatisticsSmile: String, minimumStatisticsPure: String,
         minimumStatisticsCool: String, nonIdolizedMaximumStatisticsSmile: String, nonIdolizedMaximumStatisticsPure: String,
         nonIdolizedMaximumStatisticsCool: String, idolizedMaximumStatisticsSmile: String, idolizedMaximumStatisticsPure: String,
         idolizedMaximumStatisticsCool: String, skill: String, japaneseSkill: String, skillDetails: String, japaneseSkillDetails: String,
         centerSkill: String, japaneseCenterSkill: String, japaneseCenterSkillDetails: String, cardImage: String,
         cardIdolizedImage: String, roundCardImage: String, roundCardIdolizedImage: String, videoStory: String,
         japaneseVideoStory: String, websiteUrl: String, nonIdolizedMaxLevel: String, idolizedMaxLevel: String,
         ownedCards: String, transparentImage: String, transparentIdolizedImage: String, transparentUrPair: String,
         transparentIdolizedUrPair: String) {
        self.cardId = cardId
        self.name = name
        self.japaneseName = japaneseName
        self.idolModel = idolModel
        self.japaneseCollection = japaneseCollection
        self.rarity = rarity
        self.attribute = attribute
        self.japaneseAttribute = japaneseAttribute
        self.isPromo = isPromo
        self.promoItem = promoItem
        self.releaseDate = releaseDate
        self.japanOnly = japanOnly
        self.eventModel = eventModel
        self.isSpecial = isSpecial
        self.hp = hp
        self.minimumStatisticsSmile = minimumStatisticsSmile
        self.minimumStatisticsPure = minimumStatisticsPure
        self.minimumStatisticsCool = minimumStatisticsCool
        self.nonIdolizedMaximumStatisticsSmile = nonIdolizedMaximumStatisticsSmile
        self.nonIdolizedMaximumStatisticsPure = nonIdolizedMaximumStatisticsPure
        self.nonIdolizedMaximumStatisticsCool = nonIdolizedMaximumStatisticsCool
        self.idolizedMaximumStatisticsSmile = idolizedMaximumStatisticsSmile
        self.idolizedMaximumStatisticsPure = idolizedMaximumStatisticsPure
        self.idolizedMaximumStatisticsCool = idolizedMaximumStatisticsCool
        self.skill = skill
        self.japaneseSkill = japaneseSkill
        self.skillDetails = skillDetails
        self.japaneseSkillDetails = japaneseSkillDetails
        self.centerSkill = centerSkill
        self.japaneseCenterSkill = japaneseCenterSkill
        self.japaneseCenterSkillDetails = japaneseCenterSkillDetails
        self.cardImage = cardImage
        self.cardIdolizedImage = cardIdolizedImage
        self.roundCardImage = roundCardImage
        self.roundCardIdolizedImage = roundCardIdolizedImage
        self.videoStory = videoStory
        self.japaneseVideoStory = japaneseVideoStory
        self.websiteUrl = websiteUrl
        self.nonIdolizedMaxLevel = nonIdolizedMaxLevel
        self.idolizedMaxLevel = idolizedMaxLevel
        self.ownedCards = ownedCards
        self.transparentImage = transparentImage
        self.transparentIdolizedImage = transparentIdolizedImage
        self.transparentUrPair = transparentUrPair
        self.transparentIdolizedUrPair = transparentIdolizedUrPair
    }
}



