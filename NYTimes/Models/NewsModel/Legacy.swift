//  Legacy
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Legacy : Codable {
	let xlarge : String?
	let xlargewidth : Int?
	let xlargeheight : Int?

	enum CodingKeys: String, CodingKey {

		case xlarge = "xlarge"
		case xlargewidth = "xlargewidth"
		case xlargeheight = "xlargeheight"
	}
}
