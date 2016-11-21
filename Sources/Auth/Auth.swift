//
//  Auth.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation
import OAuthSwift
import SwiftyJSON

public typealias OAuthCredentials = (token: String, tokenSecret: String)

open class UWAuth {
	fileprivate let oauth: OAuth1Swift
	
	internal init(oauth: OAuth1Swift) {
		self.oauth = oauth
	}
	
    open func authorize(_ handler: OAuthSwiftURLHandlerType?, completion: @escaping (UWResult<OAuthCredentials>) -> ()) {

        if let handler = handler { oauth.authorizeURLHandler = handler }
		
		oauth.authorize(withCallbackURL: "oauth-swift://oauth-callback/upwork", success: { (credential, response, parameters) in
			let credentials = (token: credential.oauthToken, tokenSecret: credential.oauthTokenSecret)
			completion(.success(credentials))
			}) { (error) in
				completion(.error(.custom(error.localizedDescription)))
		}
    }

	open func setSavedCredentials(_ credentials: OAuthCredentials) {
		oauth.client.credential.oauthToken = credentials.token
		oauth.client.credential.oauthTokenSecret = credentials.tokenSecret
	}
	
	open func unsaveCredentials() {
		oauth.client.credential.oauthToken = String()
		oauth.client.credential.oauthTokenSecret = String()
	}
	
	open var isAuthed: Bool {
		return !(oauth.client.credential.oauthToken.isEmpty || oauth.client.credential.oauthTokenSecret.isEmpty)
	}
	
}
