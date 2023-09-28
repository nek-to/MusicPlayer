import SwiftUI
import AVKit
import Combine

class AudioPlayer: ObservableObject {
    private var player: AVPlayer?
    private var cancellable: AnyCancellable?
    private var timer: Timer?
    
    @Published var isPlaying = false
    @Published var currentTime: Float = 0
    var totalTime: Float = 1 {
        willSet {
            objectWillChange.send()
        }
    }
    
    func loadAudio(with url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            let tempURL = self?.createTemporaryFileURL()
            
            do {
                if let tempURL {
                    try data.write(to: tempURL)
                    
                    DispatchQueue.main.async {
                        self?.setup(url: tempURL)
                        completion(.success(()))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    
    func getCurrentTime() -> String {
        formatTime(currentTime)
    }
    
    func getTotalTime() -> String {
        formatTime(totalTime)
    }
    
    private func setup(url: URL) {
        let asset = AVURLAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        
        cancellable = player?.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                self?.isPlaying = (status == .playing)
            }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let currentItem = self?.player?.currentItem else { return }
            let currentTime = currentItem.currentTime().seconds
            let totalTime = currentItem.duration.seconds
            
            self?.currentTime = Float(currentTime)
            self?.totalTime = Float(totalTime)
        }
    }
    
    private func formatTime(_ time: Float) -> String {
        if time.isFinite {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return "--:--"
        }
    }
    
    private func createTemporaryFileURL() -> URL? {
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        let fileName = UUID().uuidString + ".m4a"
        return temporaryDirectoryURL.appendingPathComponent(fileName)
    }
}
