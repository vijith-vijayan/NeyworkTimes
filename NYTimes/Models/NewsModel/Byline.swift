// Byline
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//
import Foundation

struct Byline : Codable {
	let original : String?
	let person : [Person]?
	let organization : String?

	enum CodingKeys: String, CodingKey {

		case original = "original"
		case person = "person"
		case organization = "organization"
	}
}
