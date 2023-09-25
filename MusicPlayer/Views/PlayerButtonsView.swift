//
//  PlayerButtonsView.swift
//  MusicPlayer
//
//  Created by Kolya Gribok on 25.09.23.
//

import SwiftUI

struct PlayerButtonsView: View {
    var body: some View {
        HStack {
            Image(systemName: "backward.end.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.black)
            }
            .frame(width: 78, height: 78)
            .background(.white)
            .cornerRadius(38)
            
            Spacer()
            
            Image(systemName: "forward.end.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
        }
        .frame(width: 239)
    }
}

struct PlayerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerButtonsView()
    }
}
