//
//  UWRequest.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import OAuthSwift
import SwiftyJSON

internal class UWRequest {
	fileprivate let oauth: OAuth1Swift
	fileprivate let rootURL: URL
	
	init(oauth: OAuth1Swift, rootURL: URL) {
		self.oauth = oauth
		self.rootURL = rootURL
	}
	
	internal func get(_ suffixApiURL: String, parameters: [String: AnyObject]?) -> UWResult<JSON> {
		print("API request: \(suffixApiURL)")
		let url = URL(string: suffixApiURL, relativeTo: rootURL)!
		var result: UWResult<JSON>?
		let sem = DispatchSemaphore(value: 0)
		
		let _ = oauth.client.get(url.absoluteString, parameters: (parameters ?? [:]), headers: nil, success: { response in
			let json = JSON(data: response.data)
			if let error = json.error?.localizedDescription {
				result = .error(.parse(function: error))
			} else {
				result = .success(json)
			}
			sem.signal()
		}) { (error) in
			result = .error(.custom(error.localizedDescription))
			
//			if	let message = error.userInfo["Response-Headers"]?["x-upwork-error-message"] as? String,
//				let upworkCodeString = error.userInfo["Response-Headers"]?["x-upwork-error-code"] as? String,
//				let upworkCodeInt = Int(upworkCodeString) {
//				let error = UWError.API(status: error.code, code: upworkCodeInt, message: message)
//				result = .error(error)
//			} else {
//				result = .error(.Custom(error.localizedDescription))
//			}
			sem.signal()
		}
		
		sem.wait()
		
		// That will never happen
		guard let resultSafe = result else { return UWResult.error(UWError.custom("Result is null at " + #function)) }
		
		return resultSafe
	}
}
