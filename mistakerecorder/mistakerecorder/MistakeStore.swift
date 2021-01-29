//
//  MistakeStore.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/29.
//

import Foundation

class MistakeStore: ObservableObject {
    @Published var mistakeList: [Mistake] = mistakeListExample
}
