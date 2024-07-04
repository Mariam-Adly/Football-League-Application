
import Foundation

struct Teams: Codable {

  var count       : Int?
  var filters     : FiltersT?
  var competition : CompetitionT?
  var season      : SeasonT?
  var teams       : [Team]?


}

struct FiltersT: Codable {

  var season : String?

}

struct Team: Codable {
    
    var area                : AreaT?
    var id                  : Int?
    var name                : String?
    var shortName           : String?
    var tla                 : String?
    var crest               : String?
    var address             : String?
    var website             : String?
    var founded             : Int?
    var clubColors          : String?
    var venue               : String?
    var runningCompetitions : [RunningCompetitions]?
    var coach               : Coach?
    var squad               : [Squad]?
    var staff               : [String]?
    var lastUpdated         : String?                
}

struct Coach: Codable {
    
    var id          : Int?      = nil
    var firstName   : String?   = nil
    var lastName    : String?   = nil
    var name        : String?   = nil
    var dateOfBirth : String?   = nil
    var nationality : String?   = nil
    var contract    : Contract? = Contract()
}

struct AreaT: Codable {
    
    var id   : Int?    = nil
    var name : String? = nil
    var code : String? = nil
    var flag : String? = nil
}

struct Squad: Codable {
    
    var id          : Int?    = nil
    var name        : String? = nil
    var position    : String? = nil
    var dateOfBirth : String? = nil
    var nationality : String? = nil
}

struct RunningCompetitions: Codable {
    
    var id     : Int?    = nil
    var name   : String? = nil
    var code   : String? = nil
    var type   : String? = nil
    var emblem : String? = nil
}

struct SeasonT: Codable {
    
    var id              : Int?    = nil
    var startDate       : String? = nil
    var endDate         : String? = nil
    var currentMatchday : Int?    = nil
    var winner          : String? = nil
}

struct CompetitionT: Codable {
    
    var id     : Int?    = nil
    var name   : String? = nil
    var code   : String? = nil
    var type   : String? = nil
    var emblem : String? = nil
}

struct Contract: Codable {
    
    var start : String? = nil
    var until : String? = nil
}
