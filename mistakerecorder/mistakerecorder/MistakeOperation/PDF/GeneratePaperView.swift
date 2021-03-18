//
//  GeneratePaperView.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/5.
//

import SwiftUI

class SelectedMistakes: ObservableObject {
    @Published var list: [Mistake]
    
    init() {
        self.list = [Mistake]()
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter {
                $0.isNumber
            }
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct GeneratePaperView: View {
    @ObservedObject var user: User
    @StateObject private var selectedMistakes = SelectedMistakes()
    @State private var isSelecting = false
    @State private var showAutoSelectSubview = false
    @State private var showPDF = false
    @State private var showActivityView = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.selectedMistakes.list.removeAll()
                        showAutoSelectSubview = true
                    }, label: {
                        Text("自动挑选错题")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                            .padding(.horizontal, 10)
                            .padding(10)
                            .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                            .cornerRadius(10)
                            .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                            .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                    })
                    .padding()
                    Spacer()
                    Button(action: {
                        self.showPDF = true
                    }, label: {
                        Text("生成PDF")
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                            .padding(.horizontal, 10)
                            .padding(10)
                            .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                            .cornerRadius(10)
                            .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                            .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                    })
                    .padding()
                    .sheet(isPresented: self.$showPDF) {
                        VStack {
                            HStack {
                                Button(action: {
                                    self.showActivityView = true
                                }, label: {
                                    HStack {
                                        Text("导出")
                                            .bold()
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                    .padding(.horizontal, 10)
                                    .padding(10)
                                    .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                                    .cornerRadius(10)
                                    .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                                    .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                                })
                                .padding()
                                .sheet(isPresented: self.$showActivityView) {
                                    PDFActivityViewController(pdfData: PDFCreator(user: user, mistakes: self.selectedMistakes.list).createPDF())
                                }
                                Spacer()
                            }
                            PDFReaderView(pdfData: PDFCreator(user: user, mistakes: self.selectedMistakes.list).createPDF())
                        }
                    }
                }
                List {
                    ForEach(user.mistakeList) { mistake in
                        HStack {
                            SelectMistakeSubview(mistake: mistake, selectedMistakes: self.selectedMistakes)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(mistake.subject)
                                    .font(.system(size: 25, weight: .bold))
                                Text(mistake.questionDescription)
                                    .lineLimit(2)
                                    .font(.system(size: 16))
                                Text(mistake.category)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(5)
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            AutoSelectSubview(user: user, selectedMistakes: self.selectedMistakes, showAutoSelectSubview: self.$showAutoSelectSubview, showPDF: self.$showPDF)
        }
    }
}

struct GeneratePaperView_Previews: PreviewProvider {
    @StateObject static var user = User(username: "00000000", nickname: "abc", realname: "qiu", idcard: "111111111111111111", emailaddress: "1111@qq.com", password: "a88888888", avatar: "")
    static var previews: some View {
        GeneratePaperView(user: user)
    }
}

struct SelectMistakeSubview: View {
    @ObservedObject var mistake: Mistake
    @ObservedObject var selectedMistakes: SelectedMistakes
    @State private var isSelected = false
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
            if self.isSelected {
                selectedMistakes.list.append(mistake)
            } else {
                selectedMistakes.list.removeAll(where: {
                    $0.equals(mistake: mistake)
                })
            }
        }, label: {
            Image(systemName: self.isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(self.isSelected ? Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)) : Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
        })
    }
}

struct AutoSelectSubview: View {
    @ObservedObject var user: User
    @ObservedObject var selectedMistakes: SelectedMistakes
    @Binding var showAutoSelectSubview: Bool
    @Binding var showPDF: Bool
    @StateObject var mistakesNum = NumbersOnly()
    @State var emptySelectedMistakesAlert = false
    
    func selectMistakesAutomatically(_ num: Int) {
        if num == 0 {
            return
        }
        if user.mistakeList.count <= num { // 共挑选num道错题，如果不足，则全部选中
            for i in 1...user.mistakeList.count {
                self.selectedMistakes.list.append(user.mistakeList[i - 1])
            }
        } else { // 如果足够，则挑选复习记录最差的前num道题
            var selectedNum = 0 // 已经选中的错题数
            var evaluationArray = [Double]() // 排序数组
            for i in 1...user.mistakeList.count {
                evaluationArray.append(user.mistakeList[i - 1].totalRevisionEvaluation())
            }
            evaluationArray.sort() // 按从小到大排序
            for value in evaluationArray {
                for i in 1...user.mistakeList.count {
                    if user.mistakeList[i - 1].totalRevisionEvaluation() == value {
                        self.selectedMistakes.list.append(user.mistakeList[i - 1])
                        selectedNum += 1
                        break
                    }
                }
                if selectedNum == num { // 选前num个
                    break
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 30))
                    .padding()
                    .onTapGesture {
                        showAutoSelectSubview = false
                    }
            }
            Spacer()
            Text("请输入挑选的错题数目。")
                .font(.system(size: 20))
            TextField("", text: self.$mistakesNum.value)
                .font(.system(size: 20))
                .keyboardType(.decimalPad)
                .padding()
                .foregroundColor(Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255))
                .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                .cornerRadius(6)
                .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                .padding()
            Button(action: {
                selectMistakesAutomatically(Int(self.mistakesNum.value) ?? 0)
                if selectedMistakes.list.count > 0 {
                    showPDF = true
                    showAutoSelectSubview = false
                } else {
                    self.emptySelectedMistakesAlert = true
                }
            }, label: {
                Text("完成")
                    .bold()
                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                    .padding(.horizontal, 30)
                    .padding(10)
                    .background(Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255))
                    .cornerRadius(10)
                    .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 3, x: 2, y: 2)
                    .shadow(color: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255), radius: 3, x: -2, y: -2)
                    .padding()
            })
            .alert(isPresented: self.$emptySelectedMistakesAlert) {
                return Alert(
                    title: Text("警告"),
                    message: Text("错题数目不能为0！"),
                    dismissButton: .default(Text("确认"))
                )
            }
            Spacer()
        }
        .frame(width: 300, height: 350)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(showAutoSelectSubview ? 1 : 0.5)
        .opacity(showAutoSelectSubview ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(showAutoSelectSubview ? 0.3 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
    }
}
