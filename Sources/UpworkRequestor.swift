//
//  UpworkRequestor.swift
//  Upwork
//
//  Created by Vasily Ulianov on 29.11.16.
//
//

import Foundation
import SwiftyJSON

internal class UpworkRequestor {
	private let rootURL: URL
	private let delegate: UpworkDelegate
	
	init(delegate: UpworkDelegate, rootURL: URL) {
		self.delegate = delegate
		self.rootURL = rootURL
	}

	internal func get(_ suffixApiURL: String, parameters: [String: AnyObject]?) -> Result<JSON> {
		guard let url = URL(string: suffixApiURL, relativeTo: rootURL) else {
			return .error(.custom("Can't generate URL for root url: \(rootURL), suffixApiURL: \(suffixApiURL)"))
		}

		let resultData = delegate.upwork(signAndSendRequestTo: url, withParameters: parameters)
		
		switch resultData {
		case .success(let data):
			let json = JSON(data: data)
			
			if let error = json.error?.localizedDescription {
				return .error(.custom("Server reply is not in JSON format: " + error))
			} else {
				return .success(json)
			}
			
		case .error(let error): return .error(error)
		}
	}
}
