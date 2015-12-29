import Foundation

class DatabaseManager {

    func initDatabase() -> Void {
        let db: FMDatabase = FMDatabase.init(path: NSTemporaryDirectory() + "lovelive+.db")

        if !db.open() {
            print("Unable to open database")
            return
        }

        db.executeStatements(createCvTable())
        db.executeStatements(createIdolTable())
        db.executeStatements(createEventTable())
        db.executeStatements(createCardTable())

        db.close()
    }

    func createCardTable() -> String {
        return "CREATE TABLE Card (id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "card_id TEXT NOT NULL, " +
                "name TEXT, " +
                "japanese_name TEXT, " +
                "idol INTEGER, " +
                "japanese_collection TEXT, " +
                "rarity TEXT, " +
                "attribute TEXT, " +
                "japanese_attribute TEXT, " +
                "is_promo BOOLEAN, " +
                "promo_item TEXT, " +
                "release_date TEXT, " +
                "japan_only BOOLEAN, " +
                "event INTEGER, " +
                "is_special BOOLEAN, " +
                "hp TEXT, " +
                "minimum_statistics_smile TEXT, " +
                "minimum_statistics_pure TEXT, " +
                "minimum_statistics_cool TEXT, " +
                "nonidolized_maximum_statistics_smile TEXT, " +
                "nonidolized_maximum_statistics_pure TEXT, " +
                "nonidolized_maximum_statistics_cool TEXT, " +
                "idolized_maximum_statistics_smile TEXT, " +
                "idolized_maximum_statistics_pure TEXT, " +
                "idolized_maximum_statistics_cool TEXT, " +
                "skill TEXT, " +
                "japanese_skill TEXT, " +
                "skill_details TEXT, " +
                "japanese_skill_details TEXT, " +
                "center_skill TEXT, " +
                "japanese_center_skill TEXT, " +
                "japanese_center_skill_details TEXT, " +
                "card_image TEXT, " +
                "card_idolized_image TEXT, " +
                "round_card_image TEXT, " +
                "round_card_idolized_image TEXT, " +
                "video_story TEXT, " +
                "japanese_video_story TEXT, " +
                "website_url TEXT, " +
                "non_idolized_max_level TEXT, " +
                "idolized_max_level TEXT, " +
                "owned_cards TEXT, " +
                "transparent_image TEXT, " +
                "transparent_idolized_image TEXT, " +
                "transparent_ur_pair TEXT, " +
                "transparent_idolized_ur_pair TEXT);"
    }

    func createEventTable() -> String {
        return "CREATE TABLE Event (id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "japanese_name TEXT, " +
                "romaji_name TEXT, " +
                "english_name TEXT, " +
                "image TEXT, " +
                "english_image TEXT, " +
                "beginning TEXT, " +
                "end TEXT, " +
                "english_beginning TEXT, " +
                "english_end TEXT, " +
                "japan_current BOOLEAN, " +
                "world_current BOOLEAN, " +
                "cards TEXT, " +
                "song TEXT, " +
                "japanese_t1_points BIGINT, " +
                "japanese_t1_rank BIGINT, " +
                "japanese_t2_points BIGINT, " +
                "japanese_t2_rank BIGINT, " +
                "english_t1_points BIGINT, " +
                "english_t1_rank BIGINT, " +
                "english_t2_points BIGINT, " +
                "english_t2_rank BIGINT, " +
                "note TEXT);"
    }

    func createIdolTable() -> String {
        return "CREATE TABLE Idol (id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "name TEXT, " +
                "japanese_name TEXT, " +
                "main BOOLEAN, " +
                "age TEXT, " +
                "birthday TEXT, " +
                "astrological_sign TEXT, " +
                "blood TEXT, " +
                "height INTEGER, " +
                "measurements TEXT, " +
                "favorite_food TEXT, " +
                "least_favorite_food TEXT, " +
                "hobbies TEXT, " +
                "attribute TEXT, " +
                "year TEXT, " +
                "sub_unit TEXT, " +
                "cv INTEGER, " +
                "summary TEXT, " +
                "website_url TEXT, " +
                "wiki_url TEXT, " +
                "wikia_url TEXT, " +
                "official_url TEXT, " +
                "chibi TEXT, " +
                "chibi_small TEXT);"
    }

    func createCvTable() -> String {
        return "CREATE TABLE Cv (id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "url TEXT, " +
                "twitter TEXT, " +
                "nickname TEXT, " +
                "name TEXT, " +
                "instagram TEXT)";
    }
}
