//
//  UpworkError.swift
//  Upwork
//
//  Created by Vasily Ulianov on 29.11.16.
//
//

import Foundation

public enum UpworkError: Error, CustomStringConvertible {
	/// Data parsing error, in general argument have function name where error was catched
	case parse(function: String)
	
	/// Error was sent by Upwork API
	case api(status: Int, code: Int, message: String)
	
	/// Basic error with custom text
	case custom(String)
	
	public var description: String {
		switch self {
		case .parse: return "Unexpected response from Upwork servers"
		case .api(let status, let code, let message): return "API Error. Status: \(status), code: \(code), message: \(message)"
		case .custom(let message): return message
		}
	}
	
	public static func makeParseError(inFunction function: String = #function) -> UpworkError {
		return UpworkError.parse(function: function)
	}
}
