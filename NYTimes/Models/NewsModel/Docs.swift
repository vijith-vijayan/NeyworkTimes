//  Docs
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation
import UIKit

struct Docs: Codable, Hashable {
    
	let abstract : String?
	let webUrl : String?
	let snippet : String?
	let leadParagraph : String?
	let printSection : String?
	let printPage : String?
	let source : String?
	let multimedia : [Multimedia]?
	let headline : Headline?
	let keywords : [Keywords]?
	let pubDate : String?
	let documentType : String?
	let newsDesk : String?
	let sectionName : String?
	let byline : Byline?
	let typeofMaterial : String?
	let id : String?
	let wordCount : Int?
	let uri : String?

	enum CodingKeys: String, CodingKey {

		case abstract = "abstract"
		case webUrl = "web_url"
		case snippet = "snippet"
		case leadParagraph = "lead_paragraph"
		case printSection = "print_section"
		case printPage = "print_page"
		case source = "source"
		case multimedia = "multimedia"
		case headline = "headline"
		case keywords = "keywords"
		case pubDate = "pub_date"
		case documentType = "document_type"
		case newsDesk = "news_desk"
		case sectionName = "section_name"
		case byline = "byline"
		case typeofMaterial = "type_of_material"
		case id = "_id"
		case wordCount = "word_count"
		case uri = "uri"
	}
    
    static func == (lhs: Docs, rhs: Docs) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

extension Docs {
    
    //MARK: - GET URL FROM MULTIMEDIA SOURCE
    func getImageURL(type: MultimediaSubType) -> String {
        guard let multimedia = self.multimedia, !multimedia.isEmpty else {
            return ""
        }
        guard let baseURL = Endpoints.imageBaseUrl?.absoluteString else { return "" }
        guard let endpoint = multimedia.first(where: { $0.subtype == type.rawValue })?.url else {
            return ""
        }
        return "\(baseURL)\(endpoint)"
    }
    
    
    //MARK: - AUTHOR FULL NAME
    var authorFullName: String {
        guard let person = byline?.person, !person.isEmpty else { return "" }
        let firstName = person.first?.firstname
        let lastName = person.first?.lastname
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    //MARK: - MULTIMEDIA DIMENSIONS

    func getMutimediaDimensions(type: MultimediaSubType) -> CGSize {
        guard let multimedia = self.multimedia, !multimedia.isEmpty else {
            return .zero
        }
        guard let multimediaObject = multimedia.first(where: { $0.subtype == type.rawValue }) else {
            return .zero
        }
        return CGSize(width: multimediaObject.width ?? 0, height: multimediaObject.height ?? 0)
    }
}
