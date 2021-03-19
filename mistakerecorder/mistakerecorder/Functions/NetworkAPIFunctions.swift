//
//  NetworkAPIFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/6.
//

import Foundation
import Alamofire
import SwiftUI

struct AccessToken: Codable {
    let expires_in: Int // Access Token的有效期(秒为单位，一般为1个月)
    let access_token: String
}

struct OCRresult: Codable {
    let log_id: Int
    let words_result: [OCRwords_result]
    let words_result_num: Int
}

struct OCRwords_result: Codable {
    let location: OCRlocation
    let words: String // 识别结果
}

struct OCRlocation: Codable {
    let left: Int
    let top: Int
    let width: Int
    let height: Int
}

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
    
    func baiduOCR(croppedImage: UIImage) {
        var accessToken = ""
        let accessTokenUrl = "https://aip.baidubce.com/oauth/2.0/token"
        let parameters = [
            "grant_type": "client_credentials",
            "client_id": "sv9WXhUIaScOkQL9NAqfZ7HD",
            "client_secret": "jy8rqIM7VbUn6n7OjKvNCnOaH7r83Gmk"
        ]
        AF.request(accessTokenUrl,
                   method: .get,
                   parameters: parameters).response { accessTokenResponse in
            debugPrint(accessTokenResponse)
            let accessTokenResponseStr = String(data: accessTokenResponse.data!, encoding: .utf8)!
            do {
                let accessTokenJson = try JSONDecoder().decode(AccessToken.self, from: accessTokenResponseStr.data(using: .utf8)!)
                accessToken = accessTokenJson.access_token
                
                let OCRurl = "https://aip.baidubce.com/rest/2.0/ocr/v1/handwriting" + "?access_token=" + accessToken
                let imgStr = croppedImage.pngData()!.base64EncodedString()
                let headers: HTTPHeaders = [
                    "content-type": "application/x-www-form-urlencoded"
                ]
                AF.request(OCRurl,
                           method: .post,
                           parameters: ["image": imgStr],
                           encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
                           headers: headers).response { OCRresponse in
                    debugPrint(OCRresponse)
                    let OCRstr = String(data: OCRresponse.data!, encoding: .utf8)!
                    do {
                        let OCRjson = try JSONDecoder().decode(OCRresult.self, from: OCRstr.data(using: .utf8)!)
                        for item in OCRjson.words_result {
                            print(item.words) // 输出识别结果
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
}

