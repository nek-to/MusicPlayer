import Foundation

class Song: Codable, Identifiable {
    var id = UUID()
    let artist: String
    let title: String
    let previewUrl: String
    let albumCoverUrl: String
    
    init(id: UUID = UUID(), artist: String, title: String, previewUrl: String, albumCoverUrl: String) {
        self.id = id
        self.artist = artist
        self.title = title
        self.previewUrl = previewUrl
        self.albumCoverUrl = albumCoverUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case title = "trackName"
        case previewUrl
        case albumCoverUrl = "artworkUrl100"
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id &&
               lhs.artist == rhs.artist &&
               lhs.title == rhs.title &&
               lhs.previewUrl == rhs.previewUrl &&
               lhs.albumCoverUrl == rhs.albumCoverUrl
    }
}
