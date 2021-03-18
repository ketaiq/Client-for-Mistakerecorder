//
//  NetworkAPIFunctions.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/6.
//

import Foundation
import Alamofire

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
}

