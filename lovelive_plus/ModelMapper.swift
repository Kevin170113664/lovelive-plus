import Foundation

public class ModelMapper {

    func mapCard(card: Card, dictionary: [String:AnyObject]) -> Card {
        card.attribute = toString(dictionary["attribute"])
        card.cardId = toString(dictionary["id"])
        card.cardIdolizedImage = toString(dictionary["card_idolized_image"])
        card.cardImage = toString(dictionary["card_image"])
        card.centerSkill = toString(dictionary["center_skill"])
        card.hp = toString(dictionary["hp"])
        card.idolizedMaximumStatisticsCool = toString(dictionary["idolized_maximum_statistics_cool"])
        card.idolizedMaximumStatisticsPure = toString(dictionary["idolized_maximum_statistics_pure"])
        card.idolizedMaximumStatisticsSmile = toString(dictionary["idolized_maximum_statistics_smile"])
        card.idolizedMaxLevel = toString(dictionary["idolized_max_level"])
        card.isPromo = dictionary["is_promo"] as? Bool
        card.isSpecial = dictionary["is_special"] as? Bool
        card.japaneseAttribute = toString(dictionary["japanese_attribute"])
        card.japaneseCenterSkill = toString(dictionary["japanese_center_skill"])
        card.japaneseCenterSkillDetails = toString(dictionary["japanese_center_skill_details"])
        card.japaneseCollection = toString(dictionary["japanese_collection"])
        card.japaneseName = toString(dictionary["japanese_name"])
        card.japaneseSkill = toString(dictionary["japanese_skill"])
        card.japaneseSkillDetails = toString(dictionary["japanese_skill_details"])
        card.japaneseVideoStory = toString(dictionary["japanese_video_story"])
        card.japanOnly = dictionary["japan_only"] as? Bool
        card.minimumStatisticsCool = toString(dictionary["minimum_statistics_cool"])
        card.minimumStatisticsPure = toString(dictionary["minimum_statistics_pure"])
        card.minimumStatisticsSmile = toString(dictionary["minimum_statistics_smile"])
        card.name = toString(dictionary["name"])
        card.nonIdolizedMaximumStatisticsCool = toString(dictionary["non_idolized_maximum_statistics_cool"])
        card.nonIdolizedMaximumStatisticsPure = toString(dictionary["non_idolized_maximum_statistics_pure"])
        card.nonIdolizedMaximumStatisticsSmile = toString(dictionary["non_idolized_maximum_statistics_smile"])
        card.nonIdolizedMaxLevel = toString(dictionary["non_idolized_max_level"])
        card.ownedCards = toString(dictionary["owned_cards"])
        card.promoItem = toString(dictionary["promo_item"])
        card.rarity = toString(dictionary["rarity"])
        card.releaseDate = toString(dictionary["release_date"])
        card.roundCardIdolizedImage = toString(dictionary["round_card_idolized_image"])
        card.roundCardImage = toString(dictionary["round_card_image"])
        card.skill = toString(dictionary["skill"])
        card.skillDetails = toString(dictionary["skill_details"])
        card.transparentIdolizedImage = toString(dictionary["transparent_idolized_image"])
        card.transparentIdolizedUrPair = toString(dictionary["transparent_idolized_ur_pair"])
        card.transparentImage = toString(dictionary["transparent_image"])
        card.transparentUrPair = toString(dictionary["transparent_ur_pair"])
        card.videoStory = toString(dictionary["video_story"])
        card.websiteUrl = toString(dictionary["website_url"])

        return card
    }

    func mapIdol(idol: Idol, dictionary: [String:AnyObject]) -> Idol {
        idol.age = dictionary["age"] as? Int
        idol.astrologicalSign = toString(dictionary["astrological_sign"])
        idol.attribute = toString(dictionary["attribute"])
        idol.birthday = toString(dictionary["birthday"])
        idol.blood = toString(dictionary["blood"])
        idol.chibi = toString(dictionary["chibi"])
        idol.chibiSmall = toString(dictionary["chibi_small"])
        idol.favoriteFood = toString(dictionary["favorite_food"])
        idol.height = dictionary["height"] as? Int
        idol.hobbies = toString(dictionary["hobbies"])
        idol.japaneseName = toString(dictionary["japanese_name"])
        idol.leastFavoriteFood = toString(dictionary["least_favorite_food"])
        idol.main = dictionary["main"] as? Bool
        idol.measurements = toString(dictionary["measurements"])
        idol.name = toString(dictionary["name"])
        idol.officialUrl = toString(dictionary["official_url"])
        idol.subUnit = toString(dictionary["sub_unit"])
        idol.summary = toString(dictionary["summary"])
        idol.websiteUrl = toString(dictionary["website_url"])
        idol.wikiaUrl = toString(dictionary["wikia_url"])
        idol.wikiUrl = toString(dictionary["wiki_url"])
        idol.year = toString(dictionary["year"])

        return idol
    }

    func mapEvent(event: Event, dictionary: [String:AnyObject]) -> Event {
        event.beginning = toString(dictionary["beginning"])
        event.cards = toString(dictionary["cards"])
        event.end = toString(dictionary["end"])
        event.englishBeginning = toString(dictionary["english_beginning"])
        event.englishEnd = toString(dictionary["english_end"])
        event.englishImage = toString(dictionary["english_image"])
        event.englishName = toString(dictionary["english_name"])
        event.englishT1Points = dictionary["english_t1_points"] as? Int
        event.englishT1Rank = dictionary["english_t1_rank"] as? Int
        event.englishT2Points = dictionary["english_t2_points"] as? Int
        event.englishT2Rank = dictionary["english_t2_rank"] as? Int
        event.image = toString(dictionary["image"])
        event.japanCurrent = dictionary["japan_current"] as? Bool
        event.japaneseName = toString(dictionary["japanese_name"])
        event.japaneseT1Points = dictionary["japanese_t1_points"] as? Int
        event.japaneseT1Rank = dictionary["japanese_t1_rank"] as? Int
        event.japaneseT2Points = dictionary["japanese_t2_points"] as? Int
        event.japaneseT2Rank = dictionary["japanese_t2_rank"] as? Int
        event.note = toString(dictionary["note"])
        event.romajiName = toString(dictionary["romaji_name"])
        event.song = toString(dictionary["song"])
        event.worldCurrent = dictionary["world_current"] as? Bool

        return event
    }

    func mapCv(cv: Cv, dictionary: [String:AnyObject]) -> Cv {
        cv.instagram = toString(dictionary["instagram"])
        cv.name = toString(dictionary["name"])
        cv.nickname = toString(dictionary["nickname"])
        cv.twitter = toString(dictionary["twitter"])
        cv.url = toString(dictionary["url"])
        
        return cv
    }
    
    func toString(value: AnyObject?) -> String {
        if let num: NSNumber = value as? NSNumber {
            return String(num)
        } else if let str: String = value as? String {
            return str
        } else {
            return ""
        }
    }
}