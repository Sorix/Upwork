//
//  UWClient.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UWJob {
	public struct Client {
		public let jobsPosted: Int
		public let country: String?
		public let reviewsCount: Int
		public let pastHires: Int
		public let feedback: Double
		public let isVerifiedStatus: Bool
		
		internal init(json: JSON) {
			jobsPosted = json["jobs_posted"].intValue
			reviewsCount = json["reviews_count"].intValue
			pastHires = json["past_hires"].intValue
			feedback = json["feedback"].doubleValue
			
			// Set country only if not empty
			let possibleCountry = json["country"].stringValue
			if !possibleCountry.isEmpty { self.country = possibleCountry } else { self.country = nil }
			
			if let verifiedStatus = json["payment_verification_status"].string , verifiedStatus == "VERIFIED" {
				isVerifiedStatus = true
			} else {
				isVerifiedStatus = false
			}
		}
	}
}
