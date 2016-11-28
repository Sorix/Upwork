//
//  UpworkDelegate.swift
//  Upwork
//
//  Created by Vasily Ulianov on 29.11.16.
//
//

import Foundation

public protocol UpworkDelegate {
	func signAndSendRequest(toURL url: URL, parameters: [String: AnyObject]?) -> Result<Data>
}
