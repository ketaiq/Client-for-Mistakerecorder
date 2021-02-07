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
    
    func fetchMistakes() {
        AF.request("http://127.0.0.1:8080/fetch").response { response in
            let mistakeStr = String(data: response.data!, encoding: .utf8)
            self.delegate?.updateList(newData: mistakeStr!)}
    }
    func createMistake(mistake: Mistake) {
        AF.request("http://127.0.0.1:8080/create",
            method: .post,
            parameters: mistake,
            encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)}
    }
}

