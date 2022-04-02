//  Person
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Person : Codable {
	let firstname : String?
	let middlename : String?
	let lastname : String?
	let qualifier : String?
	let title : String?
	let role : String?
	let organization : String?
	let rank : Int?

	enum CodingKeys: String, CodingKey {

		case firstname = "firstname"
		case middlename = "middlename"
		case lastname = "lastname"
		case qualifier = "qualifier"
		case title = "title"
		case role = "role"
		case organization = "organization"
		case rank = "rank"
	}
}
