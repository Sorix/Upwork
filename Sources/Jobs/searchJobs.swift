//
//  UJobs.swift
//  Upwork Monitor
//
//  Created by Vasily Ulianov on 11.09.15.
//  Copyright © 2015 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UWRequestJobs {
	/// Get jobs list for specified search query
	public func searchJobs(_ searchQuery: UWSearchQuery) -> UWResult<[UWJob]> {
		if (searchQuery.isEmpty) {
			return .error(.custom("Search query is empty"))
		}
		
		let result = request.get("api/profiles/v2/search/jobs.json", parameters: searchQuery.dictionaryValue)
		
		guard let json = result.valid else {
			return .error(result.error)
		}
		
		var jobs = [UWJob]()
		for (_, jsonJob) in json["jobs"] {
			if let job = UWJob(json: jsonJob) {
				job.searchQueries = [searchQuery]
				jobs.append(job)
			}
		}
		
		return .success(jobs)
	}
}
