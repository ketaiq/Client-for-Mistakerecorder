//
//  Test.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/3/3.
//

import SwiftUI

struct Test: View {
    func decode() {
        let a = """
        {
            "_id": "603f345edc50b86e79275845",
            "username": "32767102",
            "nickname": "test1",
            "realname": "Qiu Ketai",
            "idcard": "111111111111111111",
            "emailaddress": "1111@qq.com",
            "password": "test123456",
            "avatar": "ac84bcb7d0a20cf4800d77cc74094b36acaf990f",
            "mistakeList": [
                {
                    "_id": "603f345edc50b86e79275846",
                    "category": "错题类型一",
                    "questionDescription": "题干描述一",
                    "createdDate": "3/3/21",
                    "questionItems": [
                        {
                            "_id": "603f345edc50b86e79275847",
                            "rightAnswer": "答案一",
                            "question": "题目一"
                        },
                        {
                            "_id": "603f345edc50b86e79275848",
                            "rightAnswer": "答案二",
                            "question": "题目二"
                        },
                        {
                            "_id": "603f345edc50b86e79275849",
                            "rightAnswer": "答案三",
                            "question": "题目三"
                        }
                    ],
                    "subject": "错题学科一",
                    "revisedRecords": [
                        {
                            "_id": "603f345edc50b86e7927584a",
                            "revisedDate": "3/3/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e7927584b",
                            "revisedDate": "3/8/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e7927584c",
                            "revisedDate": "3/13/21",
                            "revisedPerformance": "忘记"
                        },
                        {
                            "_id": "603f345edc50b86e7927584d",
                            "revisedDate": "3/15/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e7927584e",
                            "revisedDate": "3/17/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e7927584f",
                            "revisedDate": "3/23/21",
                            "revisedPerformance": "模糊"
                        }
                    ],
                    "nextRevisionDate": "3/3/21"
                },
                {
                    "_id": "603f345edc50b86e79275850",
                    "category": "错题类型二",
                    "questionDescription": "题干描述二",
                    "createdDate": "3/3/21",
                    "questionItems": [
                        {
                            "_id": "603f345edc50b86e79275851",
                            "rightAnswer": "答案一",
                            "question": "题目一"
                        },
                        {
                            "_id": "603f345edc50b86e79275852",
                            "rightAnswer": "答案二",
                            "question": "题目二"
                        },
                        {
                            "_id": "603f345edc50b86e79275853",
                            "rightAnswer": "答案三",
                            "question": "题目三"
                        }
                    ],
                    "subject": "错题学科二",
                    "revisedRecords": [
                        {
                            "_id": "603f345edc50b86e79275854",
                            "revisedDate": "3/3/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e79275855",
                            "revisedDate": "3/8/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275856",
                            "revisedDate": "3/13/21",
                            "revisedPerformance": "忘记"
                        },
                        {
                            "_id": "603f345edc50b86e79275857",
                            "revisedDate": "3/15/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275858",
                            "revisedDate": "3/17/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e79275859",
                            "revisedDate": "3/23/21",
                            "revisedPerformance": "模糊"
                        }
                    ],
                    "nextRevisionDate": "3/3/21"
                },
                {
                    "_id": "603f345edc50b86e7927585a",
                    "category": "错题类型三",
                    "questionDescription": "题干描述三",
                    "createdDate": "3/3/21",
                    "questionItems": [
                        {
                            "_id": "603f345edc50b86e7927585b",
                            "rightAnswer": "答案一",
                            "question": "题目一"
                        },
                        {
                            "_id": "603f345edc50b86e7927585c",
                            "rightAnswer": "答案二",
                            "question": "题目二"
                        },
                        {
                            "_id": "603f345edc50b86e7927585d",
                            "rightAnswer": "答案三",
                            "question": "题目三"
                        }
                    ],
                    "subject": "错题学科三",
                    "revisedRecords": [
                        {
                            "_id": "603f345edc50b86e7927585e",
                            "revisedDate": "3/3/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e7927585f",
                            "revisedDate": "3/8/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275860",
                            "revisedDate": "3/13/21",
                            "revisedPerformance": "忘记"
                        },
                        {
                            "_id": "603f345edc50b86e79275861",
                            "revisedDate": "3/15/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275862",
                            "revisedDate": "3/17/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e79275863",
                            "revisedDate": "3/23/21",
                            "revisedPerformance": "模糊"
                        }
                    ],
                    "nextRevisionDate": "3/3/21"
                }
            ],
            "__v": 0
        }
        """
        
        let b = """
        {
            "_id": "603f345edc50b86e79275846",
            "category": "错题类型一",
            "questionDescription": "题干描述一",
            "createdDate": "3/3/21",
            "questionItems": [],
            "subject": "错题学科一",
            "revisedRecords": [
                        {
                            "_id": "603f345edc50b86e7927585e",
                            "revisedDate": "3/3/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e7927585f",
                            "revisedDate": "3/8/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275860",
                            "revisedDate": "3/13/21",
                            "revisedPerformance": "忘记"
                        },
                        {
                            "_id": "603f345edc50b86e79275861",
                            "revisedDate": "3/15/21",
                            "revisedPerformance": "模糊"
                        },
                        {
                            "_id": "603f345edc50b86e79275862",
                            "revisedDate": "3/17/21",
                            "revisedPerformance": "掌握"
                        },
                        {
                            "_id": "603f345edc50b86e79275863",
                            "revisedDate": "3/23/21",
                            "revisedPerformance": "模糊"
                        }
                    ],
            "nextRevisionDate": "3/3/21",
            "revisionStatus": "true"
        }
        """
        do {
            let m = try JSONDecoder().decode(Mistake.self, from: b.data(using: .utf8)!)
            print(m.category)
        } catch {
            print("err")
        }
        
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear {
            decode()
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
