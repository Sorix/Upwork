//
//  UWJobProfile+Buyer.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UWJobProfile {
	public struct Buyer {
		public let city: String?
		public let timezone: TimeZone?
		public let totalMoneyCharged: Int
		public let totalHired: Int
		public let totalJobsPosted: Int
		public let totalHours: Double
		
		internal init(json: JSON) {
			city = json["op_city"].string
			totalMoneyCharged = json["op_tot_charge"].intValue
			totalHired = json["op_tot_asgs"].intValue
			totalJobsPosted = json["op_tot_jobs_posted"].intValue
			totalHours = json["op_tot_hours"].doubleValue
			
			timezone = Buyer.getTimeZone(json["op_timezone"].stringValue)
		}
		
		/// Get current time of buyer
		/// - Returns: locale formatted time (e.g.: 01:05 AM)
		public func getLocalTime() -> String? {
			guard let timezone = self.timezone else { return nil }
			let formatter = DateFormatter()
			formatter.timeStyle = DateFormatter.Style.short
			formatter.dateStyle = DateFormatter.Style.none
			formatter.locale = Locale.current
			formatter.timeZone = timezone
			return formatter.string(from: Date())
		}
		
		fileprivate static func getTimeZone(_ op_timezone: String) -> TimeZone? {
			let stringArray = op_timezone.components(separatedBy: " ")
			if stringArray.count > 0 {
				return TimeZone(identifier: stringArray[0])
			} else { return nil }
		}
	}
}
