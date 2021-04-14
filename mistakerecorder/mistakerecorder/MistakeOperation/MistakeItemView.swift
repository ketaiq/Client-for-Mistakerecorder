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
    @State private var subjectEditStatus = false
    @State private var categoryEditStatus = false
    
    var body: some View {
        ZStack {
            VStack {
                ItemButtonsSubview(user: user, mistake: mistake)
                List {
                    ItemCreatedDateSubview(createdDate: $mistake.createdDate)
                    ItemNextRevisionDateSubview(mistake: mistake)
                    ItemRevisedRecordsSubview(showRevisedRecordsCalendar: self.$showRevisedRecordsCalendar)
                    ItemSubjectSubview(subject: $mistake.subject, subjectEditStatu: self.$subjectEditStatus)
                    ItemCategorySubview(category: $mistake.category, categoryEditStatus: self.$categoryEditStatus)
                    ItemQuestionDescriptionSubview(questionDescription: $mistake.questionDescription)
                    ForEach(mistake.questionItems) { item in
                        if MistakeCategory.isPresetCategory(category: mistake.category) {
                            ItemMistakeCategoryItemSubview(type: mistake.category, questionItem: item)
                        } else {
                            ItemQuestionAndAnswerSubview(questionItem: item)
                        }
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
            
            MistakeSubjectEditView(show: self.$subjectEditStatus, subject: $mistake.subject)
            MistakeCategoryEditView(show: self.$categoryEditStatus, category: $mistake.category, questionDescription: $mistake.questionDescription)
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
    @Binding var subjectEditStatu: Bool
    
    var body: some View {
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
            self.subjectEditStatu = true
        }
        .padding(.vertical)
    }
}

struct ItemCategorySubview: View {
    @Binding var category: String
    @Binding var categoryEditStatus: Bool
    
    var body: some View {
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
            self.categoryEditStatus = true
        }
        .padding(.vertical)
    }
}

struct ItemQuestionDescriptionSubview: View {
    @Binding var questionDescription: String
    @StateObject private var text = ObservableString("请在此输入题干描述...")
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
                self.text.content = "请在此输入题干描述..."
            }) {
                VStack {
                    HStack {
                        Text("编辑题干描述")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            if self.text.content != "" {
                                if self.text.content != "请在此输入题干描述..." {
                                    questionDescription = self.text.content
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
                            self.text.content = ""
                        }, label: {
                            Image(systemName: "clear")
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                .font(.system(size: 30))
                                .padding(.horizontal)
                        })
                        Spacer()
                    }
                    TextEditor(text: self.$text.content)
                        .lineSpacing(5)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                        .background(RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), center: .center, startRadius: 100, endRadius: 500))
                        .onTapGesture {
                            if self.text.content == "请在此输入题干描述..." {
                                self.text.content = ""
                            }
                        }
                }
                .sheet(isPresented: self.$showOCRView) {
                    MistakeOCRView(text: self.text, showMistakeOCRView: self.$showOCRView)
                }
            }
        }
    }
}

struct ItemQuestionAndAnswerSubview: View {
    @ObservedObject var questionItem: QuestionItem
    @StateObject private var questionText = ObservableString("请在此输入题目...")
    @StateObject private var answerText = ObservableString("请在此输入答案...")
    @State private var editStatus = false
    
    var body: some View {
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
            self.questionText.content = "请在此输入题目..."
            self.answerText.content = "请在此输入答案..."
        }) {
            MistakeStandardEditView(questionItem: questionItem, questionText: questionText, answerText: answerText, editStatus: self.$editStatus)
        }
    }
}

struct ItemMistakeCategoryItemSubview: View {
    let type: String
    @ObservedObject var questionItem: QuestionItem
    @State private var editStatus = false
    
    var body: some View {
        HStack {
            Text("题目项")
                .font(.system(size: 20))
            Spacer()
            Text(self.type)
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
            if self.type == MistakeCategory.PinYinXieCi.toString() {
                MistakePinYinXieCiEditView(questionItem: questionItem)
            } else if self.type == MistakeCategory.ChengYuYiSi.toString() {
                MistakeChengYuYiSiEditView(questionItem: questionItem)
            } else if self.type == MistakeCategory.JinYiCi.toString() {
                MistakeJinFanYiCiEditView(type: self.type, questionItem: questionItem)
            } else if self.type == MistakeCategory.FanYiCi.toString() {
                MistakeJinFanYiCiEditView(type: self.type, questionItem: questionItem)
            } else if self.type == MistakeCategory.MoXieGuShi.toString() {
                MistakeMoXieGuShiEditView(questionItem: questionItem)
            } else if self.type == MistakeCategory.ZuCi.toString() {
                MistakeZuCiEditView(questionItem: questionItem)
            } else if self.type == MistakeCategory.XiuGaiBingJu.toString() {
                MistakeXiuGaiBingJuEditView(questionItem: questionItem)
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
