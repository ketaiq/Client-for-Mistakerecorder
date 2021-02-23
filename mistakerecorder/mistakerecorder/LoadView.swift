//
//  LoadView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/23.
//

import SwiftUI

struct LoadView: View {
    var body: some View {
        VStack {
            LottieView(filename: "load", isLoop: true)
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
