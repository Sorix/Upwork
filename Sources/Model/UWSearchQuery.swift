//
//  UWSearchQuerySave.swift
//  Upwork Monitor
//
//  Created by Vasily Ulianov on 15.10.15.
//  Copyright © 2015 Vasily Ulianov. All rights reserved.
//

import Foundation

open class UWSearchQuery: Equatable, Hashable, CustomStringConvertible {
	open var query = String()
	open var skills = [String]() // conditionally required (one of this)
	open var jobStatus = "open"
	open var category: String?
	open var subcategory: String?
	open var notifications: Bool = true
	
	var dictionaryValue: Dictionary<String, AnyObject> {
		var dictionary = Dictionary<String, AnyObject>()
		
		dictionary["q"] = query as AnyObject?
		dictionary["skills"] = skills.joined(separator: " OR ") as AnyObject?
		dictionary["jobStatus"] = jobStatus as AnyObject?
		dictionary["category2"] = category as AnyObject?
		dictionary["subcategory2"] = subcategory as AnyObject?
		
		return dictionary
	}
	
	open var isEmpty: Bool {
		return(query.isEmpty && skills.isEmpty)
	}
	
	public init(query: String) {
		self.query = query
	}
	
	public init(skills: [String]) {
		self.skills = skills
	}
	
	open var description: String {
		var outputText = [String]()
		
		if !query.isEmpty && query != "*" {	outputText = [query] }
		
		if skills.count > 0 {
			outputText += [skills.map({ "[" + $0 + "]"}).joined(separator: " ")]
		}

		if let subcategory = self.subcategory {
			outputText.append(subcategory)
		} else if let category = self.category {
			outputText.append(category)
		}
		
		let readyText = outputText.joined(separator: "; ")
		
		return readyText
	}
	
	open var hashValue: Int {
		let mainHash = query.hashValue ^ skills.joined(separator: ",").hashValue
		if let category = category, let subcat = subcategory {
			return mainHash ^ category.hashValue ^ subcat.hashValue
		} else {
			return mainHash
		}

	}

}

// MARK: Equatable

public func == (lhs: UWSearchQuery, rhs: UWSearchQuery) -> Bool {
	if (lhs.query == rhs.query &&
		lhs.skills == rhs.skills &&
		lhs.category == rhs.category &&
		lhs.subcategory == rhs.subcategory) {
		return true
	} else {
		return false
	}
}

public func == (lhs: [UWSearchQuery], rhs: [UWSearchQuery]) -> Bool {
	guard lhs.count == rhs.count else { return false }
	var i1 = lhs.makeIterator()
	var i2 = rhs.makeIterator()
	var isEqual = true
	while let e1 = i1.next(), let e2 = i2.next() , isEqual
	{
		isEqual = e1 == e2
	}
	return isEqual
}


