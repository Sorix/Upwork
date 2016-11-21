//
//  UWJobProfile+Assignment.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

extension UWJobProfile {
	public struct Assignment {
		public let rate: Double?
		public let dateCompleted: CompletedDate
		public let totalCharged: Double
		public let ciphertext: String
		public let title: String
		
		public let feedbackScore: Double
		public let feedbackComment: String
		
		internal init?(json: JSON) {
			guard let ciphertext = json["as_ciphertext"].string,
				let title = json["as_opening_title"].string else { return nil }
			
			self.ciphertext = ciphertext; self.title = title
			totalCharged = json["as_total_charge"].doubleValue
			
			rate = Assignment.getRate(json["as_rate"].stringValue)
			dateCompleted = Assignment.getDateCompleted(json["as_to"].stringValue)
			
			feedbackScore = json["feedback"]["score"].doubleValue
			feedbackComment = json["feedback"]["comment"].stringValue
		}
		
		public enum CompletedDate {
			case inProgress
			case completed(Date)
		}
		
		/// Convert $3.00 -> Double
		fileprivate static func getRate(_ as_rate: String) -> Double? {
			let withoutFirstSymbol = String(as_rate.characters.dropFirst()) // remove $
			if let rate = Double(withoutFirstSymbol) , rate != 0 {
				return rate
			} else { return nil }
		}
		
		fileprivate static func getDateCompleted(_ as_to_string: String) -> CompletedDate {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/yyyy"
			if let date = dateFormatter.date(from: as_to_string) {
				return .completed(date)
			} else {
				// If we can't get date we assume that there written "Present"
				return .inProgress
			}
		}

	}
}
