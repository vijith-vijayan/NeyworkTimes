//  Headlines
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Headline : Codable {
	let main : String?
	let kicker : String?
	let contentKicker : String?
	let printHeadline : String?
	let name : String?
	let seo : String?
	let sub : String?

	enum CodingKeys: String, CodingKey {

		case main = "main"
		case kicker = "kicker"
		case contentKicker = "content_kicker"
		case printHeadline = "print_headline"
		case name = "name"
		case seo = "seo"
		case sub = "sub"
	}

}
