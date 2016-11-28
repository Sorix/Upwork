//
//  listSkills.swift
//  Pods
//
//  Created by Vasily Ulianov on 25.04.16.
//
//

import Foundation

extension UpworkMetadataAPI {
	/// Returns a list of skills available in a freelancer's profile
	open func listSkills() -> Result<[String]> {
		let result = request.get("api/profiles/v1/metadata/skills.json", parameters: nil)
		
		guard let json = result.valid else { return .error(result.error) }
		
		var skills = [String]()
		
		for skillJSON in json["skills"].arrayValue {
			skills.append(skillJSON.stringValue)
		}
		
		return .success(skills)
	}
}
