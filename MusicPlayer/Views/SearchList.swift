import SwiftUI

struct SearchList: View {
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
                        ForEach(0..<15) { _ in
                            SongCardView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                                          songTitle: "BORN TO DIE",
                                          artist: "Lana Del Rey")
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.all)
        }
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList()
    }
}
