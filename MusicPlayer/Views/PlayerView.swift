import SwiftUI
import ActivityKit

struct PlayerView: View {
    @ObservedObject var songsViewModel: SongViewModel
    @StateObject private var audioPlayer = AudioPlayer()
    @Environment(\.presentationMode) var presentationMode
    @State var song: Song
    @State private var final: Float = 0
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: songsViewModel.findPreviousSong(for: song)?.albumCoverUrl ?? "background")) { image in
                    image
                        .resizable()
                        .frame(width: 177, height: 224)
                        .cornerRadius(20)
                        .padding(.all, 12)
                } placeholder: {
                    ProgressView()
                        .frame(width: 177, height: 224)
                        .padding(.all, 12)
                        .tint(.white)
                }
                
                AsyncImage(url: URL(string: song.albumCoverUrl)) { image in
                    image
                        .resizable()
                        .frame(width: 239, height: 274)
                        .cornerRadius(20)
                        .padding(.all, 12)
                } placeholder: {
                    ProgressView()
                        .frame(width: 239, height: 274)
                        .padding(.all, 12)
                        .tint(.white)
                }
                
                
                AsyncImage(url: URL(string: songsViewModel.findNextSong(for: song)?.albumCoverUrl ?? "background")) { image in
                    image
                        .resizable()
                        .frame(width: 177, height: 224)
                        .cornerRadius(20)
                        .padding(.all, 12)
                } placeholder: {
                    ProgressView()
                        .frame(width: 177, height: 224)
                        .padding(.all, 12)
                        .tint(.white)
                }
            }
            .padding(.bottom, 24)
            
            Text(song.title)
                .useAppStile(16)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Text(song.artist)
                .useAppStile(13)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.5))
                .padding(.bottom, 74)
            
            VStack {
                VStack {
                    Slider(value: Binding(
                        get: { audioPlayer.currentTime },
                        set: { newValue in
                            if !audioPlayer.totalTime.isNaN && newValue >= 0 && newValue <= audioPlayer.totalTime {
                                audioPlayer.currentTime = newValue
                            }
                        }
                    ), in: 0...(audioPlayer.totalTime.isNaN || audioPlayer.totalTime < 0 ? 0 : audioPlayer.totalTime))
                }
                .tint(.white)
                .frame(width: 239)
                
                HStack {
                    Text(audioPlayer.getCurrentTime())
                        .useAppStile(13)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.4))
                    
                    Spacer()
                    
                    Text(audioPlayer.getTotalTime())
                        .useAppStile(13)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.4))
                }
                .frame(width: 239)
            }
            
            HStack {
                Button {
                    song = songsViewModel.findPreviousSong(for: song) ?? Song(artist: "", title: "", previewUrl: "", albumCoverUrl: "")
                    audioPlayer.loadAudio(with: URL(string: song.previewUrl)!) { _ in
                        audioPlayer.play()
                    }
                } label: {
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    audioPlayer.isPlaying.toggle()
                    audioPlayer.isPlaying ? audioPlayer.play() : audioPlayer.pause()
                } label: {
                    if audioPlayer.isPlaying {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                    } else {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 78, height: 78)
                .background(.white)
                .cornerRadius(38)
                
                Spacer()
                
                Button {
                    audioPlayer.pause()
                    song = songsViewModel.findNextSong(for: song) ?? Song(artist: "", title: "", previewUrl: "", albumCoverUrl: "")
                    audioPlayer.loadAudio(with: URL(string: song.previewUrl)!) { _ in
                        audioPlayer.play()
                    }
                } label: {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 239)
            .onAppear {
                if let url = URL(string: song.previewUrl) {
                    audioPlayer.loadAudio(with: url) { result in
                        switch result {
                        case .success:
                            audioPlayer.play()
                        case .failure(let error):
                            print("Ошибка загрузки музыки: \(error)")
                        }
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Image("background").resizable().ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            VStack(alignment: .leading) {
                Image(systemName: "chevron.backward")
                    .frame(width: 24, height: 24)
                    .tint(.white)
            }
            .frame(width: 40, height: 40)
            .background(Color.white.opacity(0.2))
            .cornerRadius(20)
        }))
    }
}
