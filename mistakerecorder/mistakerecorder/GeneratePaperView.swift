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

struct GeneratePaperView: View {
    @ObservedObject var user: User
    @StateObject private var selectedMistakes = SelectedMistakes()
    @State private var isSelecting = false
    @State private var showPDF = false
    @State private var showActivityView = false
    
    func selectMistakesAutomatically() {
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectMistakesAutomatically()
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
                    $0.subject == mistake.subject &&
                    $0.category == mistake.category &&
                    $0.questionDescription == mistake.questionDescription &&
                    $0.createdDate == mistake.createdDate &&
                    $0.nextRevisionDate == mistake.nextRevisionDate &&
                    $0.revisionStatus == mistake.revisionStatus
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
