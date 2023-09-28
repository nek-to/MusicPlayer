import Foundation
import Combine

private enum Urls {
    static let songList = "https://itunes.apple.com/search?term="
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    func getSongsListBy(_ track: String) -> AnyPublisher<SongList, Error> {
        let buildedUrl = Urls.songList + track
        guard let url = URL(string: buildedUrl) else {
            return Fail(error: NSError(domain: "Error", code: -1)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                $0.data
            }
            .decode(type: SongList.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
