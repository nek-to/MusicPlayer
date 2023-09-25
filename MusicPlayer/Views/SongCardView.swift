import SwiftUI

struct SongCardView: View {
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

struct SongCardView_Previews: PreviewProvider {
    static var previews: some View {
        SongCardView(imageUrl: "https://is1-ssl.mzstatic.com/image/thumb/Music/y2005/m03/d30/h08/s05.atlqsocy.jpg/100x100bb.jpg",
                      songTitle: "BORN TO DIE",
                      artist: "Lana Del Rey")
    }
}
