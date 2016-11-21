//
//  Extensions.swift
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation

extension String {
	internal var rfc3339DateStringToNSDate: Date? {
		let en_US_POSIX = Locale(identifier: "en_US_POSIX")
		let rfc3339DateFormatter = DateFormatter()
		rfc3339DateFormatter.locale = en_US_POSIX
		rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssXXX"
		rfc3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
		
		return(rfc3339DateFormatter.date(from: self))
	}
}
