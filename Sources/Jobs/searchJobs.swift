//
//  UJobs.swift
//  Upwork Monitor
//
//  Created by Vasily Ulianov on 11.09.15.
//  Copyright © 2015 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UpworkJobsAPI {
	/// Get jobs list for specified search query
	open func searchJobs(_ searchQuery: UpworkSearchQuery) -> Result<[UpworkJob]> {
		if (searchQuery.isEmpty) {
			return .error(.custom("Search query is empty"))
		}
		
		let result = request.get("api/profiles/v2/search/jobs.json", parameters: searchQuery.dictionaryValue)
		
		guard let json = result.valid else {
			return .error(result.error)
		}
		
		var jobs = [UpworkJob]()
		for (_, jsonJob) in json["jobs"] {
			if var job = UpworkJob(json: jsonJob) {
				job.searchQueries = [searchQuery]
				jobs.append(job)
			}
		}
		
		return .success(jobs)
	}
}
