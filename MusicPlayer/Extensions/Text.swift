import SwiftUI

extension Text {
    func useAppStile(_ size: CGFloat) -> some View {
        self.font(Font.custom("Montserrat", size: size)
                .weight(.black))
    }
}
