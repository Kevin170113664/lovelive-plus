import RealmSwift

class CardModel: Object {
	var id: Int32?
	var idol_model: IdolModel?
	var japanese_collection: String?
	var translated_collection: String?
	var rarity: String?
	var attribute: String?
	var japanese_attribute: String?
	var is_promo: Bool?
	var promo_item: String?
	var promo_link: String?
	var release_date: String?
	var japan_only: Bool?
	var event: EventModel?
	var is_special: Bool?
	var hp: Int32?
	var minimum_statistics_smile: Int32?
	var minimum_statistics_pure: Int32?
	var minimum_statistics_cool: Int32?
	var non_idolized_maximum_statistics_smile: Int32?
	var non_idolized_maximum_statistics_pure: Int32?
	var non_idolized_maximum_statistics_cool: Int32?
	var idolized_maximum_statistics_smile: Int32?
	var idolized_maximum_statistics_pure: Int32?
	var idolized_maximum_statistics_cool: Int32?
	var skill: String?
	var japanese_skill: String?
	var skill_details: String?
	var japanese_skill_details: String?
	var center_skill: String?
	var center_skill_details: String?
	var japanese_center_skill: String?
	var japanese_center_skill_details: String?
	var card_image: String?
	var card_idolized_image: String?
	var round_card_image: String?
	var round_card_idolized_image: String?
	var video_story: String?
	var japanese_video_story: String?
	var website_url: String?
	var non_idolized_max_level: Int32?
	var idolized_max_level: Int32?
	var transparent_image: String?
	var transparent_idolized_image: String?
	var clean_ur: String?
	var clean_ur_idolized: String?
// var skill_up_cards: []
	var ur_pair: String?
	var total_owners: Int32?
	var total_wishlist: Int32?
	var ranking_attribute: Int32?
	var ranking_rarity: Int32?
	var ranking_special: Int32?
}
