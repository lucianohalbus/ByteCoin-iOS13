//

import Foundation


struct CoinModel: Codable {
    let time: String
    let assetIDBase: String
    let assetIDQuote: String
    let rate: Double
}
