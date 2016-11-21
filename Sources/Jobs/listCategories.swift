//
//  listCategories
//  Pods
//
//  Created by Vasily Ulianov on 25.04.16.
//
//

import Foundation

public typealias UWCategory = String
public typealias UWSubCategory = String

extension UWMetadata {
	/// This call returns the ID and title of the topics within the Category 2.0.
	public func listCategories() -> UWResult<Dictionary<UWCategory, [UWSubCategory]>> {
		let result = request.get("api/profiles/v2/metadata/categories.json", parameters: nil)
		
		guard let json = result.valid else { return .error(result.error) }
		
		var outputCategories = Dictionary<UWCategory, [UWSubCategory]>()
		
		for categoryJson in json["categories"].arrayValue {
			let title = categoryJson["title"].stringValue
			
			var subcategories = [UWSubCategory]()
			for subcategoryJson in categoryJson["topics"].arrayValue {
				subcategories.append(subcategoryJson["title"].stringValue)
			}
			
			outputCategories[title] = subcategories
		}
		
		return .success(outputCategories)
	}
}
