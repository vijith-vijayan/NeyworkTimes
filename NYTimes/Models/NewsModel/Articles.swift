//  Articles
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Articles: Codable {
	let status: String?
	let copyright: String?
	let response: Response?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case copyright = "copyright"
		case response = "response"
	}

}
