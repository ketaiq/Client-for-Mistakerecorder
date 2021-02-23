//
//  WelcomeView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            Text("欢迎！")
                .font(.title).bold()
                .opacity(self.show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2))
            LottieView(filename: "welcome", isLoop: false)
                .frame(width: 300, height: 300)
                .opacity(self.show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.4))
        }
        .padding(.top, 30)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(self.show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.3 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
