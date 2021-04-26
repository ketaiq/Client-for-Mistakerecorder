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
                    return Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                } else if record.revisedPerformance == "模糊" {
                    return Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
                } else if record.revisedPerformance == "忘记" {
                    return Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
                }
            }
        }
        return Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("\(DateFunctions.functions.getYearFromDate(givenDate: dateArray.dates[10]).description)年\(DateFunctions.functions.getMonthFromDate(givenDate: dateArray.dates[10]))月")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Text("月份切换")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .bold()
                HStack(spacing: 30) {
                    Button(action: {
                        DateFunctions.functions.replaceDatesWithLastMonth(givenDateArray: dateArray)
                    }, label: {
                        Image(systemName: "arrow.left")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.black)
                    })
                    Button(action: {
                        DateFunctions.functions.replaceDatesWithNextMonth(givenDateArray: dateArray)
                    }, label: {
                        Image(systemName: "arrow.right")
                            .font(Font.system(size: 20).bold())
                            .foregroundColor(.black)
                    })
                }
                
            }
            .padding(.top)
            Spacer()
            LazyVGrid(columns: columns) {
                Text("日").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("一").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("二").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("三").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("四").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("五").bold()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("六").bold()
                    .font(.system(size: 20))
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
                        .frame(width: 30, height: 30)
                    } else {
                        Text("")
                            .frame(width: 30, height: 30)
                            .hidden()
                    }
                }
            }
            Spacer()
            HStack() {
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                Text("掌握")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                Text("模糊")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Spacer()
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
                Text("忘记")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: 350, height: 400)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
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
