//
//  OCR.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/31.
//

import Foundation

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

struct DocOCR: Codable {
    let results_num: Int
    let log_id: Int
    let results: [DocOCRresult]
}

struct DocOCRresult: Codable {
    let words_type: String
    let words: DocOCRwords
}

struct DocOCRwords: Codable {
    let words_location: OCRlocation
    let word: String
}
