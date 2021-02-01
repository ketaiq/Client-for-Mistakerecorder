//
//  RevisingMistake.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/1.
//

import Foundation

struct RevisingMistake: Identifiable {
    var id = UUID()
    var mistake: Mistake
    var occupyFullScreen: Bool
}

var revisingMistakeListExample = [revisingMistakeExample1, revisingMistakeExample2, revisingMistakeExample3, revisingMistakeExample4]

var revisingMistakeExample1 = RevisingMistake(mistake: mistakeExample1, occupyFullScreen: false)
var revisingMistakeExample2 = RevisingMistake(mistake: mistakeExample2, occupyFullScreen: false)
var revisingMistakeExample3 = RevisingMistake(mistake: mistakeExample3, occupyFullScreen: false)
var revisingMistakeExample4 = RevisingMistake(mistake: mistakeExample4, occupyFullScreen: false)
