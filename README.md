# Client-for-Mistakerecorder
![GitHub](https://img.shields.io/badge/part-client-orange)
![GitHub](https://img.shields.io/github/license/casdm/Client-for-Mistakerecorder)
![GitHub](https://img.shields.io/badge/version-v1.0-blue)
![GitHub](https://img.shields.io/badge/platform-ios-lightgrey)

2021年南京农业大学本科生毕业设计：错题拍拍手机APP客户端

## 论文节选

**摘要**

本文基于汉字OCR技术针对小低年级语文的课后辅导需求，设计了一款错题拍照手机APP。本系统使用阿里云服务器作为MongoDB数据库服务器存储错题数据，客户端则是基于iOS操作系统开发。“错题拍拍手机APP”注  重小低年级使用群体的需求，主要功能模块有：用户管理、错题管理和数据管理。其中关键的错题管理部分包括导入、导出和复习错题三大使用步骤。导入模块设计了拼音写词、成语意思和近反义词等七种内置题型导入模板，能有效的帮助用户在最短时间内整理错题。导出模块包括自动组卷和导出可打印PDF试卷的功能，可以方便的进行错题的导出并重做。复习模块提供基于艾宾浩斯记忆曲线的复习提醒功能，用户在完成复习答题后，可以使用自动批改功能进行错题批改，并记录每次复习的成绩。本软件的主要特点是在导入和复习错题时，均提供完备的汉字OCR工具。该OCR模型采用百度AI的公开接口，识别准确率高、速度快，能有效帮助用户减少手动输入的时间。本应用导出的PDF试卷与应用内复习时的一键识别功能配合使用，可以最大程度的简化传统错题复习流程，记录复习时间和成绩信息，是当前应用市场上独具特色的错题整理工具APP。

**关键词**：汉字OCR；艾宾浩斯遗忘曲线；错题识别；小学语文

**ABSTRACT**

This paper designs a mobile application of organizing mistakes by photographing based on Chinese OCR technology for after-school tutoring needs of pupils for primary Chinese. The system uses Alibaba Cloud server as a MongoDB database server to store mistake data, and the client is developed based on the iOS operating system. The mistake recorder system pays attention to the needs of pupils. The main functional modules are: user management, mistake management and data management. The key part mistake management includes three main steps, which are importing, exporting and reviewing of mistakes. In the import module, this application specifically designs seven built-in templates for importing mistakes, such as pinyin, idiom meanings, synonyms, antonyms, etc., which can effectively help users organize mistakes in the shortest possible time. The export module includes functions of automatic generating papers and exporting the printable PDF test papers, so that users can easily export and redo the test paper. The review module provides review reminder function based on the Ebbinghaus Forgetting Curve. After the user completes review, the user can use the automatic evaluating function to correct the answers, and record the results of each review. The main feature of this software is that when importing and reviewing mistakes, the application provides a complete Chinese OCR tool. The OCR model is provided by Baidu AI's public interface. Its recognition accuracy and speed are high, so it can effectively help users reduce the time of manual input. The PDF test paper exported by this application is used together with the one-click recognition function of the review part of the application, which can simplify the traditional process of revising mistakes as much as possible. The application can also record review time and result, so it is a unique tool application to organize mistakes in the current application market.

**KEY WORDS**：Chinese OCR；Ebbinghaus Forgetting Curve；Mistake Recognition；Primary Chinese

## 预览

### 主要界面
<p float="left">
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%99%BB%E5%BD%95%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="客户端登录界面"/>
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E4%B8%BB%E9%A1%B5%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="主页界面"/>
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E5%A4%8D%E4%B9%A0%E9%94%99%E9%A2%98%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="复习错题界面"/>
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E9%94%99%E9%A2%98%E6%9C%AC%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="错题本界面"/>
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%87%BA%E9%94%99%E9%A2%98%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="导出错题界面"/>
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E9%94%99%E9%A2%98%E7%BC%96%E8%BE%91%E7%95%8C%E9%9D%A2.PNG" width="300" height="533" alt="错题编辑界面"/>
</p>

### 登录
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E7%99%BB%E5%BD%95.gif" width="300" height="533" alt="登录"/></br>
### 更改头像
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E6%9B%B4%E6%94%B9%E5%A4%B4%E5%83%8F.gif" width="300" height="533" alt="更改头像"/></br>
### 编辑用户信息
<img src="https://github.com/uzktQ/Client-for-Mistakerecorder/blob/master/preview/%E7%BC%96%E8%BE%91%E7%94%A8%E6%88%B7%E4%BF%A1%E6%81%AF.gif" width="300" height="533" alt="编辑用户信息"/></br>
### 导入标准错题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E6%A0%87%E5%87%86%E9%94%99%E9%A2%98.gif" width="300" height="533" alt="导入标准错题"/></br>
### 导入拼音写词题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E6%8B%BC%E9%9F%B3%E5%86%99%E8%AF%8D%E9%A2%98.gif" width="300" height="533" alt="导入拼音写词题"/></br>
### 导入成语意思题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E6%88%90%E8%AF%AD%E6%84%8F%E6%80%9D%E9%A2%98.gif" width="300" height="533" alt="导入成语意思题"/></br>
### 导入成语意思题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E6%88%90%E8%AF%AD%E6%84%8F%E6%80%9D%E9%A2%98.gif" width="300" height="533" alt="导入成语意思题"/></br>
### 导入近义词题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E8%BF%91%E4%B9%89%E8%AF%8D%E9%A2%98.gif" width="300" height="533" alt="导入近义词题"/></br>
### 导入默写古诗题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E9%BB%98%E5%86%99%E5%8F%A4%E8%AF%97%E9%A2%98.gif" width="300" height="533" alt="导入默写古诗题"/></br>
### 导入组词题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E7%BB%84%E8%AF%8D%E9%A2%98.gif" width="300" height="533" alt="导入默写古诗题"/></br>
### 导入修改病句题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%85%A5%E4%BF%AE%E6%94%B9%E7%97%85%E5%8F%A5%E9%A2%98.gif" width="300" height="533" alt="导入修改病句题"/></br>
### 导出错题试卷
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%AF%BC%E5%87%BA%E9%94%99%E9%A2%98%E8%AF%95%E5%8D%B7.gif" width="300" height="533" alt="导出错题试卷"/></br>
### 复习成语意思题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%A4%8D%E4%B9%A0%E6%88%90%E8%AF%AD%E6%84%8F%E6%80%9D%E9%A2%98.gif" width="300" height="533" alt="复习成语意思题"/></br>
### 复习默写古诗题
<img src="https://github.com/casdm/Client-for-Mistakerecorder/blob/master/preview/%E5%A4%8D%E4%B9%A0%E9%BB%98%E5%86%99%E5%8F%A4%E8%AF%97%E9%A2%98.gif" width="300" height="533" alt="复习默写古诗题"/></br>
