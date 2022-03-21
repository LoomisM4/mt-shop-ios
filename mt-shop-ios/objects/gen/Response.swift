// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct Response: Codable {
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}
