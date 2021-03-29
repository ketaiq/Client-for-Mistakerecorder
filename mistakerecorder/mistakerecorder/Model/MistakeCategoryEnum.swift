//
//  MistakeCategoryEnum.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/28.
//

import Foundation

enum MistakeCategory {
    case PinYinXieCi // 拼音写词
    case ChengYuYiSi // 成语意思
    case JinYiCi // 近义词
    case FanYiCi // 反义词
    case MoXieGuShi // 默写古诗
    case ZuCi // 组词
    case DuoYinZi // 多音字
    case XiuGaiBingJu // 修改病句
    
    public func toString() -> String {
        if self == .PinYinXieCi {
            return "拼音写词"
        } else if self == .ChengYuYiSi {
            return "成语意思"
        } else if self == .JinYiCi {
            return "近义词"
        } else if self == .FanYiCi {
            return "反义词"
        } else if self == .MoXieGuShi {
            return "默写古诗"
        } else if self == .ZuCi {
            return "组词"
        } else if self == .DuoYinZi {
            return "多音字"
        } else if self == .XiuGaiBingJu {
            return "修改病句"
        } else {
            return ""
        }
    }
    
    public func generateDescription() -> String {
        if self == .PinYinXieCi {
            return "认真拼读音节，写出下列词语。"
        } else if self == .ChengYuYiSi {
            return "根据意思写成语。"
        } else if self == .JinYiCi {
            return "请写出下列词语的近义词。"
        } else if self == .FanYiCi {
            return "请写出下列词语的反义词。"
        } else if self == .MoXieGuShi {
            return "默写所学的古诗。"
        } else if self == .ZuCi {
            return "比较字形，然后组词。"
        } else if self == .DuoYinZi {
            return "给带点字选择正确的读音。"
        } else if self == .XiuGaiBingJu {
            return "修改下列病句。"
        } else {
            return ""
        }
    }
}
