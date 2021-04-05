//
//  NetworkAPIFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/6.
//

import Foundation
import Alamofire
import SwiftUI

class NetworkAPIFunctions {
    var delegate: DataDelegate?
    static let functions = NetworkAPIFunctions()
    
    func login(user: User, loginStatus: LoginStatus) {
        AF.request("http://47.100.54.54:8080/login",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)
                let userStr = String(data: response.data!, encoding: .utf8)!
                print(userStr)
                if userStr == "0" {
                    loginStatus.isLoading = false
                    loginStatus.wrongPasswordAlert = true // 账号密码不匹配
                } else if userStr == "-1" {
                    loginStatus.isLoading = false
                    loginStatus.inexistentUsernameAlert = true // 账号不存在
                } else {
                    self.delegate?.fetch(newData: userStr) // 登录成功
                    loginStatus.isLoading = false
                    loginStatus.isWelcoming = true
                }
        }
    }
    
    func register(user: User) {
        AF.request("http://47.100.54.54:8080/register",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in
                user.username = String(data: response.data!, encoding: .utf8)!
            }
    }
    
    func forgetPassword(user: User, forgetPasswordStatus: ForgetPasswordStatus) {
        AF.request("http://47.100.54.54:8080/forgetPassword",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in
                let userStr = String(data: response.data!, encoding: .utf8)!
                print(userStr)
                if userStr == "-1" {
                    forgetPasswordStatus.invalidInfoAlert = true // 用户提供的信息无效
                } else {
                    forgetPasswordStatus.findPasswordSuccessfully = true // 找回密码成功
                }
            }
    }
    
    func updateMistakeList(user: User) {
        AF.request("http://47.100.54.54:8080/updateMistakeList",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in }
    }
    
    func updateNickname(user: User) {
        AF.request("http://47.100.54.54:8080/updateNickname",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in }
    }
    
    func updatePassword(user: User) {
        AF.request("http://47.100.54.54:8080/updatePassword",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in }
    }
    
    func updateAvatar(user: User) {
        AF.request("http://47.100.54.54:8080/updateAvatar",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in }
    }
    
    func updateEmailaddress(user: User) {
        AF.request("http://47.100.54.54:8080/updateEmailaddress",
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default).response { response in }
    }
    
    func baiduOCR(ocr_result: ObservableString, croppedImage: UIImage) {
        let access_token_url = "https://aip.baidubce.com/oauth/2.0/token"
        let access_token_url_parameters = [
            "grant_type": "client_credentials",
            "client_id": "sv9WXhUIaScOkQL9NAqfZ7HD",
            "client_secret": "jy8rqIM7VbUn6n7OjKvNCnOaH7r83Gmk"
        ]
        var ocr_url = "https://aip.baidubce.com/rest/2.0/ocr/v1/handwriting" + "?access_token="
        let imgStr = croppedImage.pngData()!.base64EncodedString()
        let ocr_headers: HTTPHeaders = [
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        AF.request(access_token_url, method: .get, parameters: access_token_url_parameters).response { access_token_response in
            debugPrint(access_token_response)
            let access_token_response_str = String(data: access_token_response.data!, encoding: .utf8)!
            do {
                let access_token_json = try JSONDecoder().decode(AccessToken.self, from: access_token_response_str.data(using: .utf8)!)
                ocr_url += access_token_json.access_token
                AF.request(ocr_url,
                           method: .post,
                           parameters: ["image": imgStr],
                           encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
                           headers: ocr_headers).response { OCRresponse in
                    debugPrint(OCRresponse)
                    let OCRstr = String(data: OCRresponse.data!, encoding: .utf8)!
                    do {
                        let OCRjson = try JSONDecoder().decode(OCRresult.self, from: OCRstr.data(using: .utf8)!)
                        var i = 0
                        ocr_result.content = ""
                        while i < OCRjson.words_result_num { // 得到识别结果
                            ocr_result.content.append(OCRjson.words_result[i].words)
                            i += 1
                        }
                    } catch {
                        print("OCR解码失败")
                    }
                }
            } catch {
                print("AccessToken解码失败！")
            }
        }
    }
    
    func jinFanYiCiSearch(word: String, type: String, questionItem: QuestionItem) { // 查询近义词或反义词
        let url = "https://api.jisuapi.com/jinyifanyi/word"
        let parameters = [
            "appkey": "d480f86c0a83176d",
            "word": word
        ]
        AF.request(url, method: .get, parameters: parameters).response { response in
            questionItem.rightAnswer = ""
            debugPrint(response)
            let responseStr = String(data: response.data!, encoding: .utf8)!
            do {
                let json = try JSONDecoder().decode(JinFanYiCi.self, from: responseStr.data(using: .utf8)!)
                if json.status == 0 {
                    questionItem.question = json.result.toJsonString()
                    if type == MistakeCategory.JinYiCi.toString() {
                        for item in json.result.jin {
                            questionItem.rightAnswer.append(item + "/")
                        }
                        if questionItem.rightAnswer.last == "/" {
                            questionItem.rightAnswer.removeLast()
                        }
                    } else if type == MistakeCategory.FanYiCi.toString() {
                        for item in json.result.fan {
                            questionItem.rightAnswer.append(item + "/")
                        }
                        if questionItem.rightAnswer.last == "/" {
                            questionItem.rightAnswer.removeLast()
                        }
                    }
                } else {
                    print(json.msg)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func removeHtmlLabels(str: String) -> String { // 修饰获取的数据，删除自带的HTML标签
        let pattern = "[A-Za-z\\s<>/\\=\"]"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return regex.stringByReplacingMatches(in: str, options: [], range: NSMakeRange(0, str.count), withTemplate: "")
    }
    
    private func guShiDetailSearch(detailid: Int, questionItem: QuestionItem) {
        let url = "https://api.jisuapi.com/tangshi/detail"
        let parameters = [
            "appkey": "d480f86c0a83176d",
            "detailid": detailid
        ] as [String : Any]
        AF.request(url, method: .get, parameters: parameters).response { response in
            debugPrint(response)
            let responseStr = String(data: response.data!, encoding: .utf8)!
            do {
                let json = try JSONDecoder().decode(PoemDetail.self, from: responseStr.data(using: .utf8)!)
                if json.status == 0 {
                    let title = self.removeHtmlLabels(str: json.result.title)
                    let type = self.removeHtmlLabels(str: json.result.type)
                    let content = self.removeHtmlLabels(str: json.result.content)
                    let explanation = self.removeHtmlLabels(str: json.result.explanation)
                    let appreciation = self.removeHtmlLabels(str: json.result.appreciation)
                    let author = self.removeHtmlLabels(str: json.result.author)
                    let poem = Poem(detailid: json.result.detailid, title: title, type: type, content: content, explanation: explanation, appreciation: appreciation, author: author)
                    questionItem.question = poem.toJsonString()
                    questionItem.rightAnswer = content
                } else {
                    print(json.msg)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func guShiSearch(title: String, author: String, questionItem: QuestionItem) {
        let url = "https://api.jisuapi.com/tangshi/chapter"
        let parameters = [
            "appkey": "d480f86c0a83176d"
        ]
        AF.request(url, method: .get, parameters: parameters).response { response in
            debugPrint(response)
            let responseStr = String(data: response.data!, encoding: .utf8)!
            do {
                let json = try JSONDecoder().decode(PoemChapter.self, from: responseStr.data(using: .utf8)!)
                if json.status == 0 {
                    for item in json.result {
                        if item.name.contains(title) && item.author == author {
                            self.guShiDetailSearch(detailid: item.detailid, questionItem: questionItem)
                        }
                    }
                } else {
                    print(json.msg)
                }
            } catch {
                print(error)
            }
        }
    }
}

