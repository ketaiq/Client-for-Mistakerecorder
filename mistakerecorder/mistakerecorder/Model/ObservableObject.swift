//
//  ObservableObject.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/3.
//

import Foundation

class ObservableString: ObservableObject {
    @Published var content: String
    
    init(_ content: String) {
        self.content = content
    }
}

class ObservableStringArray: ObservableObject {
    @Published var list: [ObservableString]
    
    init(_ num: Int) {
        self.list = [ObservableString]()
        for _ in 1...num {
            self.list.append(ObservableString(""))
        }
    }
}
