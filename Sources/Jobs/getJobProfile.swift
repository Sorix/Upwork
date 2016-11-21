//
//  getJobProfile.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UWRequestJobs {
	public typealias JobID = String
	
	/**
		This call takes a job key or recno and returns detailed profile information about the job. This method returns an exhaustive list of attributes associated with the job.
	
		- Parameter jobsKeys: the list of jobs to fill it with profile information. Number of jobs per request is limited to 20.
	*/
	public func getJobProfile(_ jobsKeys: [JobID]) -> UWResult<[JobID: UWJobProfile]> {
		if jobsKeys.count > 20 {
			NSLog("getJobProfile() keys count is more than 20, that's not recommended by Upwork API, unexpected results may be returned")
		}
		
		let result = request.get("api/profiles/v1/jobs/" + jobsKeys.joined(separator: ";") + ".json", parameters: nil)

		guard let json = result.valid else { return .error(result.error) }
		
		var jobsProfiles = [JobID: UWJobProfile]()
		
		if json["profile"].exists() {
			guard let profile = UWJobProfile(json: json["profile"]),
				let ciphertext = json["profile"]["ciphertext"].string else { return .error(.parse(function: #function)) }
			
			jobsProfiles = [ciphertext: profile]
		} else if let jsonProfiles = json["profiles"]["profile"].array {
			for jsonJobProfile in jsonProfiles {
				if let profile = UWJobProfile(json: jsonJobProfile), let ciphertext = jsonJobProfile["ciphertext"].string {
					jobsProfiles[ciphertext] = profile
				}
			}
		} else {
			return .error(.parse(function: #function))
		}
		
		return .success(jobsProfiles)
	}

	
}
