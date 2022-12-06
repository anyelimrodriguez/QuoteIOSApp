//
//  AdviceResult.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 11/21/22.
//

import Foundation

/*class AdviceResult {
  var advice = ""
}*/

class ResultSlip: Codable {
    var slip : AdviceResult
}
class AdviceResult: Codable {
    var id: Int?
    var advice: String? = ""
}
