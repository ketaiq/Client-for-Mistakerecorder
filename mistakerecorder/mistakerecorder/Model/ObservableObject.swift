//
//  ObservableObject.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/4/3.
//

import Foundation

class ObservableString: ObservableObject {
    @Published var content: String
    
    init(content: String) {
        self.content = content
    }
}

class ObservableBool: ObservableObject {
    @Published var value: Bool
    
    init(_ value: Bool) {
        self.value = value
    }
}
