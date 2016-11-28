//
//  Upwork.swift
//  Upwork
//
//  Created by Vasily Ulianov on 02.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import OAuthSwift

open class Upwork {
	internal let rootURL = URL(string: "https://www.upwork.com/")!
	
	/// This class used to manage jobs and job-related activities. You can use these resources to search for jobs, post new jobs, list posted jobs, update jobs and delete them. You can also invite freelancers to a job interview.
	public let jobs: UpworkJobsAPI
	
	/// This class helps to get resources that list different “static” data used in Upwork profiles. These resources help you avoid hardcoded data in your applications and keep the apps up to date with Upwork’s future changes.
	public let metadata: UpworkMetadataAPI
	
	public init(delegate: UpworkDelegate) {
		let upworkRequest = UpworkRequestor(delegate: delegate, rootURL: rootURL)
		
		self.jobs = UpworkJobsAPI(request: upworkRequest)
		self.metadata = UpworkMetadataAPI(request: upworkRequest)
    }
	

	
}
