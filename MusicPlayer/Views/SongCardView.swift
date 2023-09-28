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
                        .tint(.white)
                        .frame(width: 64, height: 64)
                }
                .padding(.trailing, 23)
                
                VStack(alignment: .leading) {
                    Text(songTitle)
                        .useAppStile(16)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text(artist)
                        .useAppStile(13)
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                        Image(systemName: "play.fill")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
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
