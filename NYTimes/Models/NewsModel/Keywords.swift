//  Keywords
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Keywords : Codable {
	let name : String?
	let value : String?
	let rank : Int?
	let major : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case value = "value"
		case rank = "rank"
		case major = "major"
	}

}
