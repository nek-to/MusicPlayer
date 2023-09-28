import Foundation
import ActivityKit

public struct SongAttributes: ActivityAttributes {
    public typealias TimeState = ContentState
    
    public struct ContentState: Codable, Hashable {
        var timeLeft: String
    }
    
    var songTitle: String
    var artist : String
}
