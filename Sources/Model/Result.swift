//
//  Result
//  UpworkFramework
//
//  Created by Vasily Ulianov on 01.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
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

/**
	Resulting enum allowing you to carefully parse an error
*/
public enum Result<T> {
	
	/// request was successfull return data here
    case success(T)
	
	/// error wrapped in `UpworkError` enum
    case error(UpworkError)
	
	/// Returns data if result is `.Success`
    public var valid: T? {
        switch self {
        case .success(let data): return data
        case .error: return nil
        }
    }
	
	/// Used to get error, if result is `.Success` (not `.Error`) returns error with text *No error*
    public var error: UpworkError {
        switch self {
        case .error(let error): return error
        default: return .custom("No error")
        }
    }
}
