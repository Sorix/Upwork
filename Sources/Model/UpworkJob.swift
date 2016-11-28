//
//  Model.swift
//  Upwork Monitor
//
//  Created by Vasily Ulianov on 14.09.15.
//  Copyright © 2015 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct UpworkJob: Equatable, Hashable {
	public let id: String
	public let category: String
	public let url: URL
	public let title: String
	public let snippet: String
	public let subcategory: String
	public let workload: UpworkJobWorkload?
	public let budget: Int?
	public let dateCreated: Date
	public let jobType: UpworkJobType
	public let skills: [String]?
	
	public let client: UpworkJobClient
	public var profile: UpworkJobProfile?
	
	public let json: JSON

	public var isRead: Bool = false
	
	public var searchQueries = [UpworkSearchQuery]()

	public init?(json: JSON) {
		guard let id = json["id"].string,
			let url = json["url"].URL,
			let title = json["title"].string,
			let snippet = json["snippet"].string,
			let dateCreated = json["date_created"].string?.rfc3339DateStringToNSDate,
			let jobType = UpworkJobType(rawValue: json["job_type"].stringValue) else { return nil }
		
		self.id = id; self.url = url; self.title = title; self.snippet = snippet; self.dateCreated = dateCreated; self.jobType = jobType
		
		self.json = json
		
		budget = json["budget"].int
		category = json["category2"].stringValue
		subcategory = json["subcategory2"].stringValue
		workload = UpworkJobWorkload(rawValue: json["workload"].stringValue)
		
		// Skills
		if let skillsJSON = json["skills"].array {
			var parsedSkills = [String]()
			for skillJSON in skillsJSON {
				parsedSkills.append(skillJSON.stringValue)
			}
			self.skills = parsedSkills
		} else { self.skills = nil }
		
		client = UpworkJobClient(json: json["client"])
	}
	
	public var hashValue: Int {
		return id.hashValue
	}
}

public enum UpworkJobType: String {
	case Hourly = "Hourly"
	case Fixed = "Fixed"
}


public enum UpworkJobWorkload: String {
	case AsNeeded = "as_needed"
	case Partial = "part_time"
	case FullTime = "full_time"
}

public func == (lhs: UpworkJob, rhs: UpworkJob) -> Bool {
	return (lhs.id == rhs.id)
}

extension Sequence where Iterator.Element == UpworkJob {
	public func find(withID id: String) -> UpworkJob? {
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
