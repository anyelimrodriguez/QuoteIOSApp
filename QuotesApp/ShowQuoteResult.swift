//
//  File.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 12/5/22.
//

import Foundation

/*class AdviceResult {
  var advice = ""
}*/

//class ResultSlip: Codable {
  //  var slip : AdviceResult
//}
class ShowQuoteResult: Codable {
    var id: Int?
    var author: String? = ""
    var quote: String? = ""
    var series: String? = ""
}
