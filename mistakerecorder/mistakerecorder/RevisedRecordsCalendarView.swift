//
//  RevisedRecordsCalendarView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/20.
//

import SwiftUI

struct RevisedRecordsCalendarView: View {
    @ObservedObject var mistake: Mistake
    @ObservedObject var dateArray: DateArray
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    func dateColor(date: Date) -> Color {
        for record in mistake.revisedRecords {
            let revisedDay = DateFunctions.functions.getDayFromDate(givenDate: record.revisedDate)
            let revisedMonth = DateFunctions.functions.getMonthFromDate(givenDate: record.revisedDate)
            let revisedYear = DateFunctions.functions.getYearFromDate(givenDate: record.revisedDate)
            let thisDay = DateFunctions.functions.getDayFromDate(givenDate: date)
            let thisMonth = DateFunctions.functions.getMonthFromDate(givenDate: date)
            let thisYear = DateFunctions.functions.getYearFromDate(givenDate: date)
            if revisedDay == thisDay && revisedMonth == thisMonth && revisedYear == thisYear {
                if record.revisedPerformance == "掌握" {
                    return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
                } else if record.revisedPerformance == "模糊" {
                    return Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
                } else if record.revisedPerformance == "忘记" {
                    return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
                }
            }
        }
        return Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("\(DateFunctions.functions.getYearFromDate(givenDate: dateArray.dates[10]).description)年\(DateFunctions.functions.getMonthFromDate(givenDate: dateArray.dates[10]))月")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    DateFunctions.functions.replaceDatesWithNextMonth(givenDateArray: dateArray)
                }, label: {
                    HStack {
                        Text("下个月")
                            .foregroundColor(.black)
                            .font(.title2)
                            .bold()
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.black)
                    }
                })
            }
            .padding(.top)
            Spacer()
            LazyVGrid(columns: columns) {
                Text("日").bold()
                    .foregroundColor(.black)
                Text("一").bold()
                    .foregroundColor(.black)
                Text("二").bold()
                    .foregroundColor(.black)
                Text("三").bold()
                    .foregroundColor(.black)
                Text("四").bold()
                    .foregroundColor(.black)
                Text("五").bold()
                    .foregroundColor(.black)
                Text("六").bold()
                    .foregroundColor(.black)
            }
            LazyVGrid(columns: columns) {
                ForEach(dateArray.dates, id: \.self) { date in
                    if DateFunctions.functions.isValidDate(givenDate: date) {
                        ZStack {
                            Circle()
                                .foregroundColor(dateColor(date: date))
                            Text("\(DateFunctions.functions.getDayFromDate(givenDate: date))")
                                .foregroundColor(.black)
                        }
                        .frame(width: 40, height: 40)
                    } else {
                        Text("")
                            .frame(width: 40, height: 40)
                            .hidden()
                    }
                }
            }
            Spacer()
            HStack() {
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                Text("掌握")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                Text("模糊")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                Text("忘记")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: screen.width, height: 450)
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
        RevisedRecordsCalendarView(mistake: mistake, dateArray: DateArray(dates: DateFunctions.functions.generateDatesOfMonth(givenDate: mistake.createdDate)))
    }
}
