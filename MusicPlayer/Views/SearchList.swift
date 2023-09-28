import SwiftUI
import ActivityKit

struct SearchList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var songsViewModel = SongViewModel()
    @State var show = false
    @State var search = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if !show {
                        Text("MusicPlayer")
                            .useAppStile(30)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack {
                        if show {
                            Button {
                                songsViewModel.fetchSongListWith(track: search.replacingOccurrences(of: " ", with: ""))
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                            
                            TextField("Search music", text: $search)
                                .foregroundColor(.white)
                            
                            Button {
                                withAnimation {
                                    show.toggle()
                                    search = ""
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        } else {
                            Button {
                                withAnimation {
                                    show.toggle()
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    .padding(show ? 11 : 0)
                    .background(.white.opacity(0.2))
                    .cornerRadius(20)
                }
                .padding(.horizontal)
                
                if songsViewModel.songsList.results.isEmpty {
                    VStack {
                        Spacer()
                        
                        Text("There is no result for your request, please try again")
                            .font(Font.custom("Montserrat", size: 20)
                                .weight(.black))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                } else {
                ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem.init()]) {
                            ForEach(songsViewModel.songsList.results, id: \.id) { song in
                                NavigationLink(destination: PlayerView(songsViewModel: songsViewModel, song: song)) {
                                    SongCardView(imageUrl: song.albumCoverUrl,
                                                 songTitle: song.title,
                                                 artist: song.artist)
                                }
                            }
                        }
                    }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
                }
                
            }
            .padding(.all)
            .background(Image("background").resizable().ignoresSafeArea())
        }
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList()
    }
}
