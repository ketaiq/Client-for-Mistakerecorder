//
//  MistakeCollectionView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/28.
//

import SwiftUI

struct MistakeListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MistakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MistakeListView()
    }
}

struct Mistake: Identifiable { // 错题
    var id = UUID() // 自动生成的ID
    var subject: String // 错题所属学科：语文、数学、英语等
    var category: String // 错题类型：近义词、反义词等
    var questionDescription: String // 题干描述："写出下列词语的反义词。"
    var questionItems: [QuestionItem] // 题目项数组
}

struct QuestionItem: Identifiable { // 题目项
    var id = UUID() // 自动生成的ID
    var question: String // 题目
    var rightAnswer: String // 正确答案
}
