import Foundation

class Idol {
    var name: String
    var japaneseName: String
    var main: Bool
    var age: Int
    var birthday: String
    var astrologicalSign: String
    var blood: String
    var height: Integer
    var measurements: String
    var favoriteFood: String
    var leastFavoriteFood: String
    var hobbies: String
    var attribute: String
    var year: String
    var subUnit: String
    var cvModel: Cv
    var summary: String
    var websiteUrl: String
    var wikiUrl: String
    var wikiaUrl: String
    var officialUrl: String
    var chibi: String
    var chibiSmall: String

    init(name: String, japaneseName: String, main: Bool, age: Int, birthday: String, astrologicalSign: String,
         blood: String, height: Integer, measurements: String, favoriteFood: String, leastFavoriteFood: String,
         hobbies: String, attribute: String, year: String, subUnit: String, cvModel: Cv, summary: String,
         websiteUrl: String, wikiUrl: String, wikiaUrl: String, officialUrl: String, chibi: String, chibiSmall: String) {
        self.name = name
        self.japaneseName = japaneseName
        self.main = main
        self.age = age
        self.birthday = birthday
        self.astrologicalSign = astrologicalSign
        self.blood = blood
        self.height = height
        self.measurements = measurements
        self.favoriteFood = favoriteFood
        self.leastFavoriteFood = leastFavoriteFood
        self.hobbies = hobbies
        self.attribute = attribute
        self.year = year
        self.subUnit = subUnit
        self.cvModel = cvModel
        self.summary = summary
        self.websiteUrl = websiteUrl
        self.wikiUrl = wikiUrl
        self.wikiaUrl = wikiaUrl
        self.officialUrl = officialUrl
        self.chibi = chibi
        self.chibiSmall = chibiSmall
    }
}
