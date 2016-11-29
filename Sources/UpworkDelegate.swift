//
//  UpworkDelegate.swift
//  Upwork
//
//  Created by Vasily Ulianov on 29.11.16.
//
//

import Foundation

public protocol UpworkDelegate {
	func upwork(signAndSendRequestTo url: URL, withParameters parameters: [String: AnyObject]?) -> Result<Data>
}
