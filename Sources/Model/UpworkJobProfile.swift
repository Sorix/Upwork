//
//  UpworkJobProfile.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct UpworkJobProfile {
	public let ciphertext: String
	public let description: String
	public let title: String
	public let payTier: UpworkJobPayTier?
	public let attached: URL?
	
	public let buyer: UpworkBuyer
	
	public let assignments: [UpworkAssignment]
	
	public let json: JSON
	
	public init?(json: JSON) {
		guard let ciphertext = json["ciphertext"].string,
			let description = json["op_description"].string,
			let title = json["op_title"].string else { return nil }
		
		self.ciphertext = ciphertext; self.description = description; self.title = title
		
		payTier = UpworkJobPayTier(rawValue: json["op_contractor_tier"].intValue)
		
		if let attachText = json["op_attached_doc"].string , !attachText.isEmpty {
			// Fix Upwork's bug when attach URL start with relative path
			if !attachText.contains("://www.upwork.com/") {
				attached = NSURL(string: "https://www.upwork.com" + attachText) as URL?
			} else {
				attached = NSURL(string: attachText) as URL?
			}
		} else { attached = nil }
		
		buyer = UpworkBuyer(json: json["buyer"])
		
		// Assignements
		var assignements = [UpworkAssignment]()
		for (_, assignmentJSON) in json["assignments"]["assignment"] {
			if let assingnement = UpworkAssignment(json: assignmentJSON) {
				assignements.append(assingnement)
			}
		}
		
		self.assignments = assignements
		
		self.json = json
	}
	
	/**
		Get average hourly rate if buyer has completed hourly jobs
		- Returns: `Double` with average rate or `nil` if buyers hasn't completed hourly jobs
	*/
	public func getAverageHourlyRate() -> Double? {
		if self.assignments.isEmpty { return nil }
		
		var totalRate: Double = 0
		var totalFeedbacksWithRate: Double = 0
		
		for feedback in self.assignments {
			guard let rate = feedback.rate else { continue }
			totalRate += rate
			totalFeedbacksWithRate += 1
		}

		if totalFeedbacksWithRate == 0 { return nil }

		let average = totalRate / totalFeedbacksWithRate

		return average
	}
}

public enum UpworkJobPayTier: Int, CustomStringConvertible {
	case entry = 1
	case intermediate = 2
	case expert = 3
	
	public var description: String {
		switch self {
		case .entry: return "Entry level ($)"
		case .intermediate: return "Intermediate level ($$)"
		case .expert: return "Expert Level ($$$)"
		}
	}
}
