//
//  UWResult
//  UpworkFramework
//
//  Created by Vasily Ulianov on 01.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation

public enum UWError: Error, CustomStringConvertible {
	/// Data parsing error, in general argument have function name where error was catched
    case parse(function: String)

	/// Error was sent by Upwork API
    case api(status: Int, code: Int, message: String)
	
	/// Basic error with custom text
    case custom(String)
	
	case database(Error)
    
    public var description: String {
        switch self {
        case .parse: return "Unexpected response from Upwork servers"
        case .api(let status, let code, let message): return "API Error. Status: \(status), code: \(code), message: \(message)"
        case .custom(let message): return message
		case .database(let error): return "\(error)"
        }
    }
}

/**
	Resulting enum allowing you to carefully parse an error
*/
public enum UWResult<T> {
	
	/// request was successfull return data here
    case success(T)
	
	/// error wrapped in `UWError` enum
    case error(UWError)
	
	/// Returns data if result is `.Success`
    public var valid: T? {
        switch self {
        case .success(let data): return data
        case .error: return nil
        }
    }
	
	/// Used to get error, if result is `.Success` (not `.Error`) returns error with text *No error*
    public var error: UWError {
        switch self {
        case .error(let error): return error
        default: return .custom("No error")
        }
    }
}
