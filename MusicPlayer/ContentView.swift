import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var search = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                HStack {
                    if !show {
                        Text("MusicPlayer")
                            .font(Font.custom("Montserrat", size: 30)
                                .weight(.black))
                            .foregroundColor(.white)
//                            .padding(.all)
                    }
                    
                    Spacer()
                    
                    HStack {
                        if show {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                            
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
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem.init()]) {
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                        
                        ExtractedView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                                                    songTitle: "BORN TO DIE",
                                                                    artist: "Lana Del Rey")
                    }
                }
            }
            .padding(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    let imageUrl: String
    let songTitle: String
    let artist: String
    
    var body: some View {
            HStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 64, height: 64)
                        .cornerRadius(15)
                } placeholder: {
                    ProgressView()
                        .foregroundColor(.white)
                        .frame(width: 64, height: 64)
                }
                .padding(.trailing, 23)
                
                VStack {
                    Text(songTitle)
                        .font(
                            Font.custom("Montserrat", size: 16)
                                .weight(.semibold)
                        )
                        .foregroundColor(.white)
                    
                    Text(artist)
                        .font(
                            Font.custom("Montserrat", size: 13)
                                .weight(.medium)
                        )
                        .foregroundColor(.white.opacity(0.5))
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(systemName: "play.fill")
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
            }
            .padding(.vertical, 8)
        }
}
