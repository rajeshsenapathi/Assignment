// ModelJsonObject.swift
//  iOSProficiencyExercise
//
//  Created by Senapathi Rajesh on 26/12/19.
//  Copyright © 2019 Senapathi Rajesh. All rights reserved.
//

import Foundation
struct ModelJsonObject: Codable {
	let title: String?
	let rows: [Rows]?

	enum CodingKeys: String, CodingKey {
        case title
		case rows
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
	}
}
