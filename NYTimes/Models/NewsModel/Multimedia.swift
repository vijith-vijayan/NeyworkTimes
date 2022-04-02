//  Multimedia
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//
import Foundation

struct Multimedia : Codable {
	let rank : Int?
	let subtype : String?
	let caption : String?
	let credit : String?
	let type : String?
	let url : String?
	let height : Int?
	let width : Int?
	let legacy : Legacy?
	let subType : String?
	let cropName : String?

	enum CodingKeys: String, CodingKey {

		case rank = "rank"
		case subtype = "subtype"
		case caption = "caption"
		case credit = "credit"
		case type = "type"
		case url = "url"
		case height = "height"
		case width = "width"
		case legacy = "legacy"
		case subType = "subType"
		case cropName = "crop_name"
	}
}


enum MultimediaSubType: String {
    case xLarge = "xlarge"
    case popup = "popup"
    case blog480 = "blog480"
    case tmagSF = "tmagSF"
    case tmagArticle = "tmagArticle"
    case slide = "slide"
    case jumbo = "jumbo"
    case largeHorizontal375 = "largeHorizontal375"
}
