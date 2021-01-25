//
//  RegisterTextField.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/23.
//

import SwiftUI

struct RegisterTextField: View {
    var textType: String
    @Binding var textContent: String
    @Binding var textWarningOpacity: Double
    var formatRequirement: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                Text("\(textType)：")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                TextField(
                    "",
                    text: $textContent,
                    onEditingChanged: { (isBegin) in
                        if isBegin {
                            textWarningOpacity = 0
                        }
                        if !isBegin {
                            if !confirmTextTypeMatch(textType: textType, textContent: textContent) {
                                textWarningOpacity = 1
                            } else {
                                textWarningOpacity = 0
                            }
                        }
                    })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 16))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(
                        Label("", systemImage: "exclamationmark.triangle")
                            .offset(x: 50)
                            .opacity(textWarningOpacity)
                            .foregroundColor(.red))
            })
            
            HStack {
                Text("\(formatRequirement)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                Spacer()
            }
            
        })
    }
}

