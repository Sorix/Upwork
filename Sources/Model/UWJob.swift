//
//  Model.swift
//  Upwork Monitor
//
//  Created by Vasily Ulianov on 14.09.15.
//  Copyright © 2015 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

open class UWJob: Equatable, Hashable {
	open let id: String
	open let category: String
	open let url: URL
	open let title: String
	open let snippet: String
	open let subcategory: String
	open let workload: UWJobWorkload?
	open let budget: Int?
	open let dateCreated: Date
	open let jobType: UWJobType
	open let skills: [String]?
	
	open let client: Client
	open var profile: UWJobProfile?
	
	open let json: JSON

	open var isRead: Bool = false
	
	open var searchQueries = [UWSearchQuery]()

	public init?(json: JSON) {
		guard let id = json["id"].string,
			let url = json["url"].URL,
			let title = json["title"].string,
			let snippet = json["snippet"].string,
			let dateCreated = json["date_created"].string?.rfc3339DateStringToNSDate,
			let jobType = UWJobType(rawValue: json["job_type"].stringValue) else { return nil }
		
		self.id = id; self.url = url; self.title = title; self.snippet = snippet; self.dateCreated = dateCreated; self.jobType = jobType
		
		self.json = json
		
		budget = json["budget"].int
		category = json["category2"].stringValue
		subcategory = json["subcategory2"].stringValue
		workload = UWJobWorkload(rawValue: json["workload"].stringValue)
		
		// Skills
		if let skillsJSON = json["skills"].array {
			var parsedSkills = [String]()
			for skillJSON in skillsJSON {
				parsedSkills.append(skillJSON.stringValue)
			}
			self.skills = parsedSkills
		} else { self.skills = nil }
		
		client = Client(json: json["client"])
	}
	
	open var hashValue: Int {
		return id.hashValue
	}
}

public enum UWJobType: String {
	case Hourly = "Hourly"
	case Fixed = "Fixed"
}


public enum UWJobWorkload: String {
	case AsNeeded = "as_needed"
	case Partial = "part_time"
	case FullTime = "full_time"
}

public func == (lhs: UWJob, rhs: UWJob) -> Bool {
	return (lhs.id == rhs.id)
}

extension Sequence where Iterator.Element == UWJob {
	public func find(withID id: String) -> UWJob? {
		for element in self {
			if element.id == id { return element }
		}
		
		return nil
	}
	
	public func indexOf(jobID id: String) -> Int? {
		for (index, element) in self.enumerated() {
			if element.id == id { return index }
		}
		
		return nil
	}
}
