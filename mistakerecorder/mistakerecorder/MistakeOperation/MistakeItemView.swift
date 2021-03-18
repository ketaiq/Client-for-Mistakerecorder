//
//  MistakeItemView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/1/29.
//

import SwiftUI

struct MistakeItemView: View {
    @ObservedObject var user: User
    @ObservedObject var mistake: Mistake
    @State private var showRevisedRecordsCalendar = false
    @State private var revisedRecordsCalendarViewDragPosition = CGSize.zero
    
    var body: some View {
        ZStack {
            VStack {
                ItemButtonsSubview(user: user, mistake: mistake)
                List {
                    ItemCreatedDateSubview(createdDate: $mistake.createdDate)
                    ItemNextRevisionDateSubview(mistake: mistake)
                    ItemRevisedRecordsSubview(showRevisedRecordsCalendar: self.$showRevisedRecordsCalendar)
                    ItemSubjectSubview(subject: $mistake.subject)
                    ItemCategorySubview(category: $mistake.category)
                    ItemQuestionDescriptionSubview(questionDescription: $mistake.questionDescription)
                    ForEach(mistake.questionItems) { item in
                        ItemQuestionAndAnswerSubview(questionItem: item)
                    }
                }
            }
            
            RevisedRecordsCalendarView(mistake: mistake, dateArray: DateArray(dates: DateFunctions.functions.generateDatesOfMonth(givenDate: mistake.createdDate)))
                .offset(y: self.showRevisedRecordsCalendar ? 0 : 1000)
                .offset(y: self.revisedRecordsCalendarViewDragPosition.height)
                .opacity(self.showRevisedRecordsCalendar ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged() { value in
                            self.revisedRecordsCalendarViewDragPosition = value.translation
                        }
                        .onEnded() { value in
                            if self.revisedRecordsCalendarViewDragPosition.height > 50 {
                                self.showRevisedRecordsCalendar = false
                            }
                            revisedRecordsCalendarViewDragPosition = .zero
                        }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(self.showRevisedRecordsCalendar ? 0.3 : 0))
                .animation(.linear(duration: 0.5))
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MistakeItemView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: UIImage(systemName: "person.circle")!.pngData()!.base64EncodedString())
    static var previews: some View {
        MistakeItemView(user: user, mistake: user.mistakeList[0])
    }
}

struct ItemCreatedDateSubview: View {
    @Binding var createdDate: String
    @State private var showInfo = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("创建时间")
                    .font(.system(size: 20))
                Spacer()
                Text("\(DateFunctions.functions.getYearFromDate(givenDate: createdDate).description)年\(DateFunctions.functions.getMonthFromDate(givenDate: createdDate))月\(DateFunctions.functions.getDayFromDate(givenDate: createdDate))日")
                    .font(.system(size: 20))
                Image(systemName: "info.circle")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.showInfo = true
            }
            .offset(x: self.showInfo ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            
            HStack {
                Text("创建时间不可更改。")
                    .font(.system(size: 20))
                Spacer()
                Text("返回")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 30)
                    .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .onTapGesture {
                        self.showInfo = false
                }
            }
            .offset(x: self.showInfo ? 0 : 500)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
        }
    }
}

struct ItemNextRevisionDateSubview: View {
    @ObservedObject var mistake: Mistake
    @State private var editStatus = false
    @State private var date = Date()
    @State private var wrongFormatAlert = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("下一次复习时间")
                    .font(.system(size: 20))
                Spacer()
                Text("\(DateFunctions.functions.getYearFromDate(givenDate: mistake.nextRevisionDate).description)年\(DateFunctions.functions.getMonthFromDate(givenDate: mistake.nextRevisionDate))月\(DateFunctions.functions.getDayFromDate(givenDate: mistake.nextRevisionDate))日")
                    .font(.system(size: 20))
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.editStatus = true
            }
            .offset(x: self.editStatus ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            .sheet(isPresented: self.$editStatus) {
                VStack {
                    HStack {
                        Text("请选择下一次复习时间")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            self.wrongFormatAlert = !DateFunctions.functions.changeNextRevisionDate(mistake: mistake, date: date)
                            if !self.wrongFormatAlert {
                                self.editStatus = false
                            }
                        }, label: {
                            Text("完成")
                                .bold()
                                .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                .padding(.horizontal, 20)
                                .padding(10)
                                .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                                .cornerRadius(10)
                                .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                                .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                                .padding()
                        })
                        .alert(isPresented: self.$wrongFormatAlert) {
                            return Alert(
                                title: Text("警告"),
                                message: Text("日期不能早于今天！"),
                                dismissButton: .default(Text("确认"))
                            )
                        }
                    }
                    .padding()
                    DatePicker("日期选择", selection: self.$date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

struct ItemRevisedRecordsSubview: View {
    @Binding var showRevisedRecordsCalendar: Bool
    @State private var showInfo = false
    var body: some View {
        ZStack {
            HStack {
                Text("复习记录")
                    .font(.system(size: 20))
                Spacer()
                Image(systemName: "calendar")
                    .font(.system(size: 40))
                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                Image(systemName: "info.circle")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .onTapGesture {
                        self.showInfo = true
                    }
            }
            .onTapGesture {
                self.showRevisedRecordsCalendar = true
            }
            .offset(x: self.showInfo ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            
            HStack {
                Text("复习记录不可更改。")
                    .font(.system(size: 20))
                Spacer()
                Text("返回")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 30)
                    .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    .onTapGesture {
                        self.showInfo = false
                }
            }
            .offset(x: self.showInfo ? 0 : 500)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
        }
    }
}

struct ItemSubjectSubview: View {
    @Binding var subject: String
    @State var text = ""
    @State private var editStatus = false
    @State private var emptyAlert = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("所属学科")
                    .font(.system(size: 20))
                Spacer()
                Text("\(subject)")
                    .font(.system(size: 20))
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.editStatus = true
            }
            .offset(x: self.editStatus ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            
            ZStack {
                TextField("\(subject)", text: $text)
                    .font(.system(size: 20))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                HStack {
                    Spacer()
                    Text("返回")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            self.editStatus = false
                        }
                    Text("清空")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(.red))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            text = ""
                        }
                    Text("保存")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            if self.text != "" {
                                subject = self.text
                            } else {
                                self.emptyAlert = true
                            }
                        }
                        .alert(isPresented: self.$emptyAlert, content: {
                            return Alert(title: Text("警告！"),
                                message: Text("所属学科不能为空！"),
                                dismissButton: .default(Text("确认"))
                            )
                        })
                }
            }
            .offset(x: self.editStatus ? 0 : 500)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
        }
    }
}

struct ItemCategorySubview: View {
    @Binding var category: String
    @State var text = ""
    @State private var editStatus = false
    @State private var emptyAlert = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("题型")
                    .font(.system(size: 20))
                Spacer()
                Text("\(category)")
                    .font(.system(size: 20))
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.editStatus = true
            }
            .offset(x: self.editStatus ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            
            ZStack {
                TextField("\(category)", text: $text)
                    .font(.system(size: 20))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                HStack {
                    Spacer()
                    Text("返回")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            self.editStatus = false
                        }
                    Text("清空")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(.red))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            text = ""
                        }
                    Text("保存")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 30)
                        .background(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .onTapGesture {
                            if self.text != "" {
                                category = self.text
                            } else {
                                self.emptyAlert = true
                            }
                        }
                        .alert(isPresented: self.$emptyAlert, content: {
                            return Alert(title: Text("警告！"),
                                message: Text("题型不能为空！"),
                                dismissButton: .default(Text("确认"))
                            )
                        })
                }
            }
            .offset(x: self.editStatus ? 0 : 500)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
        }
    }
}

struct ItemQuestionDescriptionSubview: View {
    @Binding var questionDescription: String
    @State private var text = "请在此输入题干描述..."
    @State private var editStatus = false
    @State private var emptyAlert = false
    @State private var showOCRView = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("题干描述")
                    .font(.system(size: 20))
                Spacer()
                Text("\(questionDescription)")
                    .font(.system(size: 20))
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.editStatus = true
            }
            .offset(x: self.editStatus ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            .sheet(isPresented: self.$editStatus, onDismiss: {
                self.text = "请在此输入题干描述..."
            }) {
                VStack {
                    HStack {
                        Text("请输入题干描述")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            if self.text != "" {
                                if self.text != "请在此输入题干描述..." {
                                    questionDescription = self.text
                                }
                                self.editStatus = false
                            } else {
                                self.emptyAlert = true
                            }
                        }, label: {
                            Text("完成")
                                .bold()
                                .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                .padding(.horizontal, 20)
                                .padding(10)
                                .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                                .cornerRadius(10)
                                .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                                .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                        })
                        .alert(isPresented: self.$emptyAlert) {
                            return Alert(
                                title: Text("警告"),
                                message: Text("题干描述不能为空！"),
                                dismissButton: .default(Text("确认"))
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    HStack {
                        Text("题干描述：\(questionDescription)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            self.showOCRView = true
                        }, label: {
                            Image(systemName: "camera")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Button(action: {
                            self.text = ""
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Spacer()
                    }
                    TextEditor(text: self.$text)
                        .lineSpacing(5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                        .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 100, endRadius: 500))
                        .onTapGesture {
                            if self.text == "请在此输入题干描述..." {
                                self.text = ""
                            }
                        }
                }
                .sheet(isPresented: self.$showOCRView) {
                    MistakeOCRView(text: self.$text)
                }
            }
        }
    }
}

struct ItemQuestionAndAnswerSubview: View {
    @ObservedObject var questionItem: QuestionItem
    @State private var questionText = "请在此输入题目..."
    @State private var answerText = "请在此输入答案..."
    @State private var editStatus = false
    @State private var emptyAlert = false
    @State private var showOCRView = false
    
    var body: some View {
        ZStack {
            HStack {
                Text("题目项")
                    .font(.system(size: 20))
                Spacer()
                Text("\(questionItem.question)：\(questionItem.rightAnswer)")
                    .font(.system(size: 20))
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            .onTapGesture {
                self.editStatus = true
            }
            .offset(x: self.editStatus ? -500 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .padding(.vertical)
            .sheet(isPresented: self.$editStatus, onDismiss: {
                self.questionText = "请在此输入题目..."
                self.answerText = "请在此输入答案..."
            }) {
                VStack {
                    HStack {
                        Text("请输入题目和答案")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            if self.questionText != "" && self.answerText != "" {
                                if self.questionText != "请在此输入题目..." {
                                    questionItem.question = self.questionText
                                }
                                if self.answerText != "请在此输入答案..." {
                                    questionItem.rightAnswer = self.answerText
                                }
                                self.editStatus = false
                            } else {
                                self.emptyAlert = true
                            }
                        }, label: {
                            Text("完成")
                                .bold()
                                .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                .padding(.horizontal, 20)
                                .padding(10)
                                .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                                .cornerRadius(10)
                                .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                                .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                        })
                        .alert(isPresented: self.$emptyAlert) {
                            return Alert(
                                title: Text("警告"),
                                message: Text("题目或答案不能为空！"),
                                dismissButton: .default(Text("确认"))
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    HStack {
                        Text("题目：\(questionItem.question)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            self.showOCRView = true
                        }, label: {
                            Image(systemName: "camera")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Button(action: {
                            self.questionText = ""
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Spacer()
                    }
                    TextEditor(text: self.$questionText)
                        .lineSpacing(5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                        .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 10, endRadius: 400))
                        .onTapGesture {
                            if self.questionText == "请在此输入题目..." {
                                self.questionText = ""
                            }
                        }
                    HStack {
                        Text("答案：\(questionItem.rightAnswer)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Button(action: {
                            self.showOCRView = true
                        }, label: {
                            Image(systemName: "camera")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Button(action: {
                            self.answerText = ""
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Spacer()
                    }
                    TextEditor(text: self.$answerText)
                        .lineSpacing(5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                        .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 10, endRadius: 400))
                        .onTapGesture {
                            if self.answerText == "请在此输入答案..." {
                                self.answerText = ""
                            }
                        }
                }
                .sheet(isPresented: self.$showOCRView) {
                    MistakeOCRView(text: self.$answerText)
                }
            }
        }
    }
}

struct ItemButtonsSubview: View {
    @ObservedObject var user: User
    @ObservedObject var mistake: Mistake
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var saveButtonPressed = false
    
    var body: some View {
        HStack {
            Button(action: {
                mistake.questionItems.append(
                    QuestionItem(question: "题目项题目",
                                 rightAnswer: "题目项答案"))
            }, label: {
                HStack {
                    Text("增加题目项")
                    Image(systemName: "plus.circle")
                }
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                .padding(.horizontal, 10)
                .padding(10)
                .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                .cornerRadius(10)
                .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
            })
            
            Spacer()
            
            Button(action: {
                NetworkAPIFunctions.functions.updateMistakeList(user: user)
                self.saveButtonPressed = true
            }, label: {
                Text("同步")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                    .padding(.horizontal, 10)
                    .padding(10)
                    .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                    .cornerRadius(10)
                    .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                    .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
            })
            .alert(isPresented: self.$saveButtonPressed, content: {
                return Alert(title: Text("提醒"),
                             message: Text("同步成功！"),
                             dismissButton: .default(Text("确认")) {
                                self.presentationMode.wrappedValue.dismiss()
                             }
                )
            })
        }
        .padding()
    }
}