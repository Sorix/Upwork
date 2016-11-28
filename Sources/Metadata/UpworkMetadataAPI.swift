//
//  UpworkMetadataAPI
//
//  Created by Vasily Ulianov on 25.04.16.
//
//

import Foundation

open class UpworkMetadataAPI {
	internal let request: UpworkRequestor
	
	internal init(request: UpworkRequestor) {
		self.request = request
	}
}
