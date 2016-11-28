//
//  UpworkJobsAPI
//  Upwork
//
//  Created by Vasily Ulianov on 03.04.16.
//  Copyright © 2016 Vasily Ulianov. All rights reserved.
//

import Foundation

public class UpworkJobsAPI {
	internal let request: UpworkRequestor
	
	internal init(request: UpworkRequestor) {
		self.request = request
	}
}
