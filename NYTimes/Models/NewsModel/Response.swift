//  Response
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//
import Foundation

struct Response : Codable {
	let docs : [Docs]?

	enum CodingKeys: String, CodingKey {
		case docs = "docs"
	}

}
