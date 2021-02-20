//
//  RevisedRecordsCalendarView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/20.
//

import SwiftUI

struct RevisedRecordsCalendarView: View {
    let dates: [Date]
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("\(DateFunctions.functions.getYearFromDate(givenDate: dates[10]).description)年\(DateFunctions.functions.getMonthFromDate(givenDate: dates[10]))月")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                LazyVGrid(columns: columns) {
                    Text("日").bold()
                    Text("一").bold()
                    Text("二").bold()
                    Text("三").bold()
                    Text("四").bold()
                    Text("五").bold()
                    Text("六").bold()
                }
                LazyVGrid(columns: columns) {
                    ForEach(dates, id: \.self) { date in
                        if DateFunctions.functions.isValidDate(givenDate: date) {
                            Text("\(DateFunctions.functions.getDayFromDate(givenDate: date))")
                                .frame(width: 40, height: 40)
                        } else {
                            Text("\(DateFunctions.functions.getDayFromDate(givenDate: date))")
                                .frame(width: 40, height: 40)
                                .hidden()
                        }
                    }
                }
            }
        }
        .padding()
        .frame(width: screen.width, height: 350)
        .background(Color.orange)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .shadow(color: Color.orange.opacity(0.8), radius: 20, x: 0, y: 20)
    }
}

struct RevisedRecordsCalendarView_Previews: PreviewProvider {
    static var mistake = Mistake(subject: "错题学科一", category: "错题类型一", questionDescription: "题干描述一",
        questionItems: [
          QuestionItem(question: "题目一", rightAnswer: "答案一"),
          QuestionItem(question: "题目二", rightAnswer: "答案二"),
          QuestionItem(question: "题目三", rightAnswer: "答案三")
        ])
    static var previews: some View {
        RevisedRecordsCalendarView(dates: DateFunctions.functions.generateDatesOfMonth(givenDate: mistake.createdDate))
    }
}
