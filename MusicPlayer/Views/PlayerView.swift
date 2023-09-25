import SwiftUI

struct PlayerView: View {
    @State private var progress = 0.5

    var body: some View {
            VStack {
                HStack {
                    Image("background")
                        .resizable()
                        .frame(width: 177, height: 224)
                        .cornerRadius(20)
                        .padding(.all, 12)
                    
                    Image("background")
                        .resizable()
                        .frame(width: 239, height: 274)
                        .cornerRadius(20)
                        .padding(.all, 12)
                        
                    
                    Image("background")
                        .resizable()
                        .frame(width: 177, height: 224)
                        .cornerRadius(20)
                        .padding(.all, 12)
                }
                .padding(.bottom, 24)
                
                Text("Peaceful Piano Music")
                  .font(
                    Font.custom("Montserrat", size: 16)
                      .weight(.semibold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                
                Text("relaxing piano music")
                  .font(
                    Font.custom("Montserrat", size: 13)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white.opacity(0.5))
                  .padding(.bottom, 74)
                
                VStack {
                    Slider(value: $progress, in: 0...1)
                        .tint(.white)
                        .frame(width: 239)
                    
                    HStack {
                        Text("01:06")
                            .font(
                                Font.custom("Montserrat", size: 13)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.4))
                        
                        Spacer()
                        
                        Text("03:16")
                            .font(
                                Font.custom("Montserrat", size: 13)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(width: 239)
                }
                
                PlayerButtonsView()
            }
            .frame(maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Image("background").resizable().ignoresSafeArea())
                
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
