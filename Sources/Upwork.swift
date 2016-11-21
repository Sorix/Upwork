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
//	public typealias OAuthCredentials = 
	
	internal let oauth: OAuth1Swift
	internal let kRootURL = URL(string: "https://www.upwork.com/")!
	
	/// This class used to manage jobs and job-related activities. You can use these resources to search for jobs, post new jobs, list posted jobs, update jobs and delete them. You can also invite freelancers to a job interview.
	open let jobs: UWRequestJobs
	open let auth: UWAuth
	
	/// This class helps to get resources that list different “static” data used in Upwork profiles. These resources help you avoid hardcoded data in your applications and keep the apps up to date with Upwork’s future changes.
	open let metadata: UWMetadata
	
	public init(consumerKey: String, consumerSecret: String) {
		oauth = OAuth1Swift(
			consumerKey:    consumerKey,
			consumerSecret: consumerSecret,
			requestTokenUrl: "https://www.upwork.com/api/auth/v1/oauth/token/request",
			authorizeUrl:    "https://www.upwork.com/services/api/auth",
			accessTokenUrl:  "https://www.upwork.com/api/auth/v1/oauth/token/access"
		)
		
		let request = UWRequest(oauth: oauth, rootURL: kRootURL)
		
		jobs = UWRequestJobs(request: request)
		auth = UWAuth(oauth: oauth)
		metadata = UWMetadata(request: request)
    }
	
	
}
