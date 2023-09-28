import Combine

final class SongViewModel: ObservableObject {
    @Published var songsList = SongList(results: [Song]())
    @Published var error: Error?
    @Published var song: Song?
    
    private  var cancelable = Set<AnyCancellable>()
    
    func fetchSongListWith(track: String) {
        NetworkManager.shared.getSongsListBy(track)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] songs in
                self?.songsList = songs
                print(songs)
            }
            .store(in: &cancelable)
    }
    
    func findPreviousSong(for song: Song) -> Song? {
        guard let currentIndex = songsList.results.firstIndex(of: song), currentIndex > 0 else {
            return nil
        }
        return songsList.results[currentIndex - 1]
    }

    func findNextSong(for song: Song) -> Song? {
        guard let currentIndex = songsList.results.firstIndex(of: song), currentIndex < songsList.results.count - 1 else {
            return nil
        }
        return songsList.results[currentIndex + 1]
    }
    
    func reset() {
        songsList = SongList(results: [Song]())
    }
}
