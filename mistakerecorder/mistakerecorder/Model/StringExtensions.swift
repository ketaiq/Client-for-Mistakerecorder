//
//  StringExtensions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/21.
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

extension String {
    func removePunctuations() -> String {
        var string = self
        let punctuations: Set<Character> = ["。", "，", "（", "）", "：", "；", "“", ".", ",", "(", ")", ":", ";", "_"]
        string.removeAll(where: { punctuations.contains($0) })
        return string
    }
}
