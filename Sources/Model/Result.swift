//
//  Result
//  UpworkFramework
//
//  Created by Vasily Ulianov on 01.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation

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
