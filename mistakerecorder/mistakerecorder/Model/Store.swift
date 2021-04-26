//
//  Store.swift
//  mistakerecorder
//
//  Created by CaSdm on 2021/2/3.
//

import Foundation

class ObservableString: ObservableObject {
    @Published var content: String
    
    init(_ content: String) {
        self.content = content
    }
}

class ObservableBool: ObservableObject {
    @Published var content: Bool
    
    init(_ content: Bool) {
        self.content = content
    }
}

protocol DataDelegate {
    func fetch(newData: String)
}

class User: ObservableObject, Codable { // 用户
    @Published var username: String
    @Published var nickname: String
    @Published var realname: String
    @Published var idcard: String
    @Published var emailaddress: String
    @Published var password: String
    @Published var avatar: String
    @Published var mistakeList: [Mistake] // 错题列表
    
    enum CodingKeys: CodingKey {
        case username
        case nickname
        case realname
        case idcard
        case emailaddress
        case password
        case avatar
        case mistakeList
    }
    
    init(username: String, nickname: String, realname: String, idcard: String, emailaddress: String, password: String, avatar: String) {
        self.username = username
        self.nickname = nickname
        self.realname = realname
        self.idcard = idcard
        self.emailaddress = emailaddress
        self.password = password
        self.avatar = avatar
        self.mistakeList = [
            Mistake(subject: "语文", category: MistakeCategory.PinYinXieCi.toString(), questionDescription: MistakeCategory.PinYinXieCi.generateDescription(),
                    questionItems: [
                        QuestionItem(question: "高兴*", rightAnswer: "兴"),
                        QuestionItem(question: "模*仿", rightAnswer: "模"),
                        QuestionItem(question: "震*动", rightAnswer: "震"),
                        QuestionItem(question: "零*用", rightAnswer: "零"),
                        QuestionItem(question: "顿时*", rightAnswer: "时"),
                        QuestionItem(question: "努*力", rightAnswer: "努"),
                        QuestionItem(question: "开心*", rightAnswer: "心"),
                        QuestionItem(question: "勤*奋", rightAnswer: "勤")
                    ]),
            Mistake(subject: "语文", category: MistakeCategory.ChengYuYiSi.toString(), questionDescription: MistakeCategory.ChengYuYiSi.generateDescription(),
                    questionItems: [
                        QuestionItem(question: Idiom(derivation: "《三国志·魏志·杜恕传》免为庶人，徙章武郡，是岁嘉平元年。”裴松之注引《杜氏新书》故推一心，任一意，直而行之耳。”", example: "所以彭官保便～的料理防守事宜，庄制军便～料理军需器械。★清·张春帆《宦海》第四回", explanation: "只有一个心眼儿，没有别的考虑。", pinyin: "yī xīn yī yì", word: "一心一意", abbreviation: "yxyy").toJsonString(), rightAnswer: "一心一意"),
                        QuestionItem(question: Idiom(derivation: "《孟子·公孙丑上》宋人有闵其苗之不长而揠之者，茫茫然归，谓其人曰‘今日病矣，予助苗长矣。’其子趋而往视之，苗则槁矣。”", example: "对学生的教育既不能～，也不能放任自流。", explanation: "揠拔。把苗拔起，以助其生长。比喻违反事物发展的客观规律，急于求成，反而把事情弄糟。", pinyin: "yà miáo zhù zhǎng", word: "揠苗助长", abbreviation: "ymzz").toJsonString(), rightAnswer: "揠苗助长"),
                        QuestionItem(question: Idiom(derivation: "《论语·学而》《诗》云‘如切如磋，如琢如磨。’其斯之谓与？”宋·朱熹注言治骨角者，既切之而复磋之；治玉石者，既琢之而复磨之，治之已精，而益求其精也。”", example: "白求恩同志是个医生，他以医疗为职业，对技术～；在整个八路军医务系统中，他的医术是很高明的。（毛泽东《纪念白求恩》）", explanation: "比喻已经很好了，还要求更好。表示要求极高。", pinyin: "jīng yì qiú jīng", word: "精益求精", abbreviation: "jyqj").toJsonString(), rightAnswer: "精益求精")
                    ]),
            Mistake(subject: "语文", category: MistakeCategory.JinYiCi.toString(), questionDescription: MistakeCategory.JinYiCi.generateDescription(),
                    questionItems: [
                        QuestionItem(question: JinFanYiCiResult(word: "希罕", pinyin: "xī han", content: "稀少。明何景明《内篇》之二三：“凡河南之士几何也？集于学，弗万人已尔？集于试，弗千人已尔？然名于録者，八十人焉尔矣。较之，亦希罕旷絶之遇也。”希奇。金董解元《西厢记诸宫调》卷一：“便死也须索看，这里管塑盖得希罕·”马烽西戎《吕梁英雄传》第七七回：“我当是什么希罕东西，原来是颗地雷！”贪图；喜爱。元关汉卿《救风尘》第三折：“我着你开着这个客店，我那里希罕你那房钱养家。”《红楼梦》第一一七回：“他见我们不希罕那玉，便随意给他些，就过去了。”清李渔《蜃中楼·运宝》：“本院只要亲事，那里希罕粧奩。”孙犁《白洋淀纪事·正月》：“你该去挑对花瓶大镜子，再要个洋瓷洗脸盆，我就是希罕那么个大花盆！”", jin: ["希奇","特别","稀奇","稀少","疏落","稀疏"], fan: ["平常","普遍","通常"]).toJsonString(), rightAnswer: "希奇/特别/稀奇/稀少/疏落/稀疏"),
                        QuestionItem(question: JinFanYiCiResult(word: "偏僻", pinyin: "piān pì", content: "荒僻，交通不便。《英烈传》第二七回：“那士卒因地方偏僻，全不提防，都酣酣的大睡。”清姚鼐《张仲絜时文序》：“﹝常熟﹞虽偏僻下邑，其士人多知乘时，或逾於都会广聚之区，习使之然也。”鲁迅《朝花夕拾·五猖会》：“我家的所在很偏僻。”杨沫《青春之歌》第二章：“热河省一个偏僻的山村里，住着一家姓李的人家。”引申为孤陋，见闻短浅。清和邦额《夜谭随录·梁生》：“二兄偏僻，必以我言为河汉，请晰言之，可乎？”指冷僻，不常见。许地山《换巢鸾凤》：“我先说了，不许用偏僻的句。”偏颇，不公正。元无名氏《刘弘嫁婢》第二折：“你道的差了，天有万物於人，人无一物於天，天有甚么偏僻那？”清梁绍壬《两般秋雨盦随笔·理学偏僻》：“王荆公以《春秋》为断烂朝报，不列六经；程伊川以《资治通鑑》为玩物丧志，禁人勿习。讲理学者偏僻，往往如此。”胡蕴玉《中国文学史序》：“放言倡论，冒为经世之谈；袭貌遗神，流为偏僻之论。”指房中术。宋周密《志雅堂杂钞·人事》：“士大夫至晚年，多事偏僻之术；往往无子者，盖交感之道，必精与气，然后生育。而偏僻之术，多加以繫缆之法，盖气不过，所以无子也。”元朱庭玉《梁州第七·妓门庭》套曲：“有几多説不尽人不会的偏僻、风流、是非，造次不容易。”", jin: ["冷僻","荒僻","僻静","清静","偏远","生僻","寂静","罕见","幽静"], fan: ["热闹","繁华"]).toJsonString(), rightAnswer: "冷僻/荒僻/僻静/清静/偏远/生僻/寂静/罕见/幽静"),
                        QuestionItem(question: JinFanYiCiResult(word: "珍贵", pinyin: "zhēn guì", content: "珍爱，重视。《三国志·魏志·荀彧传》“韦康为凉州，后败亡”南朝宋裴松之注：“不意双珠，近出老蚌，甚珍贵之。”清王端履《重论文斋笔录》卷一：“侍郎有《籜石斋集》五十卷行世，其画尤为儒林珍贵。”邹韬奋《思想犯罪》：“这样说起来，思想原是可以珍贵的东西，方培养之不暇，何以目为‘犯罪’而‘被处分’呢？”贵重，宝贵。明郎瑛《七修类稿·事物·杨埴》：“世号杨倭漆，所制器皿亦珍贵。”曹靖华《飞花集·只研朱墨作春山》：“这些信，是他全部著作的构成部分，是他留给祖国人民的极珍贵的精神财富。”", jin: ["宝贵","名贵","贵重","珍奇","珍稀","爱护","爱惜","珍惜","重视","珍视","可贵","珍爱","珍重"], fan: ["普通","平凡","低贱","便宜"]).toJsonString(), rightAnswer: "宝贵/名贵/贵重/珍奇/珍稀/爱护/爱惜/珍惜/重视/珍视/可贵/珍爱/珍重"),
                        QuestionItem(question: JinFanYiCiResult(word: "发愣", pinyin: "fā lèng", content: "见“发楞”。", jin: ["发呆"], fan: [""]).toJsonString(), rightAnswer: "发呆"),
                        QuestionItem(question: JinFanYiCiResult(word: "照例", pinyin: "zhào lì", content: "依照惯例或常情。宋洪巽《旸谷漫录》：“此日试厨幸中臺意，照例支犒。”《官场现形记》第四三回：“随凤占又赶到城外，照例禀送，区奉仁自去回任不题。”巴金《一个平淡的早晨》五：“他穿好衣服，照例地在楼下厨房里洗了脸，漱了口。”", jin: ["循例","按例"], fan: [""]).toJsonString(), rightAnswer: "循例/按例"),
                        QuestionItem(question: JinFanYiCiResult(word: "节省", pinyin: "jié shěng", content: "节约；节俭。《后汉书·何敞传》：“奏王侯就国，除苑囿之禁，节省浮费，賑卹穷孤。”清平步青《霞外攟屑·时事·彭尚书奏折》：“查此款需费无多，可否於节省铁路巨款之中，分十分之一。”浩然《艳阳天》第九章：“这女人能算计，会节省，妇女群里百里难挑一。”", jin: ["节减","减省","节俭","俭约","节约","俭省","省俭","俭朴","撙节","节流","减削","精打细算"], fan: ["浪费","糟蹋","奢侈","耗费","糟塌"]).toJsonString(), rightAnswer: "节减/减省/节俭/俭约/节约/俭省/省俭/俭朴/撙节/节流/减削/精打细算"),
                        QuestionItem(question: JinFanYiCiResult(word: "震动", pinyin: "zhèn dòng", content: "震惊，惊动。《书·盘庚下》：“尔谓朕曷震动万民以迁。”《史记·鲁仲连邹阳列传》：“天下震动，诸侯惊骇。”宋司马光《论西夏札子》：“奋扬天威，震动沙漠。”浩然《艳阳天》第三章：“萧长春听到这个意外的消息，真有点被震动了。”受到外力影响而颤动。汉司马相如《上林赋》：“山陵为之震动，川谷为之荡波。”宋苏轼《后赤壁赋》：“划然长啸，草木震动，山鸣谷应，风起水涌。”冰心《我的邻居》：“一阵机关枪响之后，紧接着就是天坍地陷似的几阵大声，门窗震动。”比喻盛怒；威严。晋袁宏《后汉纪·灵帝纪上》：“上释皇乾震动之怒，下解黎庶酸楚之情也。”《陈书·谢哲萧允等传论》：“是知上官、博陆之权势，阎、邓、梁、竇之震动，吁可畏哉。”清王夫之《读四书大全说·中庸第二十章二三》：“子之语大勇曰：‘虽千万人，吾往矣。’是何等震动、严毅、先人夺人，岂谈笑举鼎之谓哉。”轰动；激动。《东观汉记·光武纪》：“士众喜乐，师行鼓舞，歌咏雷声，八荒震动。”宋曾巩《救灾议》：“天下之民，闻国家厝置如此，恩泽之厚，其孰不震动感激，悦主上之义於无穷乎。”《老残游记》第八回：“大家喊道：‘好了，好了！前面到了集镇了！’只此一声，人人精神震动。”秦牧《＜长河浪花集＞序》：“他们为社会主义事业鞠躬尽瘁……这是使我们多么感奋震动的事！”", jin: ["震荡","振动","颠簸","滚动","晃动","动荡","触动","动摇","活动","轰动","惊动","发抖","振撼","颤栗","起伏","震撼","振荡","哆嗦","颤动","战栗","波动","流动","颤抖","震憾"], fan: ["静止"]).toJsonString(), rightAnswer: "震荡/振动/颠簸/滚动/晃动/动荡/触动/动摇/活动/轰动/惊动/发抖/振撼/颤栗/起伏/震撼/振荡/哆嗦/颤动/战栗/波动/流动/颤抖/震憾"),
                        QuestionItem(question: JinFanYiCiResult(word: "发愤", pinyin: "fā fèn", content: "勤奋；决心努力。《史记·孔子世家》：“其为人也，学道不倦，诲人不厌，发愤忘食，乐以忘忧。”晋葛洪《抱朴子·交际》：“乃发愤著论，杜门絶交，斯诚感激有为而然。”《宋史·文苑传五·苏洵》：“年二十七始发愤为学。”清严有禧《漱华随笔·徐翁》：“督尚书兄弟发愤为学，相继登第。”丁玲《过年》：“小菡要发愤读书，要争气。”参见“发愤忘食”。发奋振作。汉班固《东都赋》：“於是圣皇乃握乾符，阐坤珍，披皇图，稽帝文，赫尔发愤，应若兴云。”《后汉书·班超梁慬传论》：“时政平则文德用，而武略之士无所奋其力能，故汉世有发愤张胆，争膏身於夷狄以要功名，多矣。”《南史·文学传·祖皓》：“逆竖滔天，王室如燬，正是义夫发愤之秋，志士忘躯之日。”元刘君锡《来生债》第一折：“有等人精神发愤，都待要习文演武立功勋。”《明史·欧阳一敬传》：“自严嵩败，言官争发愤论事，一敬尤敢言。”发泄愤懑。《楚辞·九章·惜诵》：“惜诵以致愍兮，发愤以抒情。”《史记·太史公自序》：“《诗》三百篇，大抵贤圣发愤之所为作也。”南朝梁刘勰《文心雕龙·杂文》：“原兹文之设，迺发愤以表志。”唐成玄英《＜庄子＞序》：“﹝庄周﹞当战国之初，降衰周之末，叹苍生之业薄，伤道德之陵夷，乃慷慨发愤，爰著斯论。”明何景明《述归赋》：“左氏著《国语》，马迁抽《史记》，荀卿董子之流，皆有论譔，大抵困屈穷阨，发愤述作。”激起愤慨；激于义愤。《史记·伯夷列传》：“或择地而蹈之，时然后出言，行不由径，非公正不发愤，而遇祸灾者，不可胜数也。”《后汉书·袁术传》：“董卓无道，陵虐王室……天子播越，宫庙焚毁，是以豪桀发愤，沛然俱起。”《晋书·刘琨传》：“逆胡刘聪，敢率犬羊，冯陵輦轂，人神发愤，遐邇奋怒。”宋司马光《祭雷道矩文》：“无位於朝，忧国遑遑。发愤抗言，忠鯁激昂。”鲁迅《汉文学史纲要》第六篇：“盖秦灭六国，四方怨恨，而楚尤发愤，誓虽三户必亡秦。”犹含恨。《汉书·司马迁传》：“是岁，天子始建汉家之封，而太史公留滞周南，不得与从事，发愤且卒。”晋潘岳《马汧督诔》：“慨慨马生，硠硠高致。发愤囹圄，没而犹眡。”唐刘知几《史通·五行志杂驳》：“昭子以纳君不遂，发愤而卒。”《明史·刘源清传》：“振前为乱卒所拥，实不反，诣源清自明。不能白，发愤自杀。”清曾国藩《江忠烈公神道碑铭》：“城陷，发愤投水死。”", jin: ["努力","勤劳","勤奋","勤恳","立志","辛勤","勤苦","奋发","发奋","勤勉"], fan: ["消沉","振奋","气馁"]).toJsonString(), rightAnswer: "努力/勤劳/勤奋/勤恳/立志/辛勤/勤苦/奋发/发奋/勤勉")
                    ]),
            Mistake(subject: "语文", category: MistakeCategory.FanYiCi.toString(), questionDescription: MistakeCategory.FanYiCi.generateDescription(),
                    questionItems: [
                        QuestionItem(question: JinFanYiCiResult(word: "温暖", pinyin: "wēn nuǎn", content: "暖和。汉桓宽《盐铁论·国疾》：“往者常民衣服温暖而不靡，器质朴牢而致用。”《后汉书·东夷传·倭》：“气温腝，冬夏生菜茹。”宋曾巩《喜二弟侍亲将至》诗：“共眠布被取温暖，同举菜羹甘淡薄。”清蒲松龄《聊斋志异·翩翩》：“顾生肃缩，乃持襆掇拾洞口白云，为絮复衣；著之，温煗如襦，且轻鬆常如新绵。”杨沫《青春之歌》第一部第五章：“一道温暖的热流，缓缓地流过了道静冰冷的全身。”犹温存。宋杨万里《明发祈门悟法寺溪行险绝》诗：“何须双鷺相温暖，鷺过还教转寂寥。”《醒世恒言·卖油郎独占花魁》：“王九妈新讨了瑶琴……终日好茶好饭，去将息他，好言好语，去温暖他。”巴金《抹布集·第二的母亲》：“我婶母是一个毫不亲切的妇人，我虽然被她抚养过，但是我从她那里并不曾得到温暖。”参见“温存”。", jin: ["暖和","和煦","和善","和暖","和缓","温柔","和气","温顺","温存","温和"], fan: ["寒冷","冰冷","孤独","凄冷","凊恧","冰寒","清冷"]).toJsonString(), rightAnswer: "寒冷/冰冷/孤独/凄冷/凊恧/冰寒/清冷"),
                        QuestionItem(question: JinFanYiCiResult(word: "兴奋", pinyin: "xīng fèn", content: "奋起。明刘基《祀方丘颂》：“提三尺剑，由一旅兴奋于长淮。”中国近代史资料丛刊《辛亥革命·黎元洪布告山东人民文》：“曷勿及时兴奋，共襄大业？”激动。鲁迅《书信集·致郑振铎》：“‘兴奋’我很赞成，但不要‘太’，‘太’即容易疲劳。”巴金《灭亡》第十四章：“他异常兴奋，浑身发烧，头脑也有点昏迷。”大脑皮层的基本神经活动过程之一，在外部或内部刺激之下产生。", jin: ["振奋","亢奋","激昂","激动","高兴","喜悦","高昂","怡悦","欢喜","兴盛","快活","愉快","欢乐","振作","快乐","乐意","得意","抖擞","繁盛","茂盛","欢跃","焕发","感奋","痛快","开心"], fan: ["镇静","平静","沮丧","萎靡","失落","恼恨","惆怅","疲劳","消沉","惊慌","紧张","愁闷","疲倦","抑制","慌张","懊丧","低落","疲惫"]).toJsonString(), rightAnswer: "镇静/平静/沮丧/萎靡/失落/恼恨/惆怅/疲劳/消沉/惊慌/紧张/愁闷/疲倦/抑制/慌张/懊丧/低落/疲惫"),
                        QuestionItem(question: JinFanYiCiResult(word: "勤奋", pinyin: "qín fèn", content: "勤勉。清平步青《霞外攟屑·掌故·林西厓方伯》：“似此勤奋出力之员，岂可拘其家世，不加奬励。”巴金《探索集·探索之四》：“我还是要写作，而且要更勤奋地写作。”", jin: ["勤恳","勤苦","努力","发奋"], fan: ["懒惰","懒散","懈怠"]).toJsonString(), rightAnswer: "懒惰/懒散/懈怠"),
                        QuestionItem(question: JinFanYiCiResult(word: "糊涂", pinyin: "hú tu", content: "头脑不清；不明事理。《宋史·吕端传》：“太宗欲相端，或曰：‘端为人糊涂。’太宗曰：‘端小事糊涂，大事不糊涂。’决意相之。”金元好问《送高信卿》诗：“万事糊涂酒一壶，别时聊为鼓咙胡。”闻一多《“一二·一”运动始末记》：“每一个糊涂的人都清醒起来。”模糊。《京本通俗小说·拗相公》：“﹝荆公﹞将舃底向土墙上抹得字跡糊涂，方纔罢手。”元乔吉《扬州梦》第四折：“因此上落魄江湖载酒行，糊涂了黄粱梦境。”明唐寅《出塞》诗之二：“功成筑京观，万里血糊涂。”清洪昇《长生殿·窥浴》：“腮边花粉糊涂，嘴上臙脂狼藉。”含糊，不明确。《二刻拍案惊奇》卷十二：“晦菴也没奈他何。只得糊涂做了不合蛊惑上官，狠毒将他痛杖了一顿，发去绍兴，另加勘问。”《儒林外史》第五十回：“不但人拿的糊涂，连这牌票上的文法也有些糊涂。”方言。指糊状的食品。柯岩《奇异的书简·追赶太阳的人四》：“河南农村有个习惯，一到饭时就好拿着馍，端着‘糊涂’到饭场圪蹴着，三个一群，两个一伙，连说话带喝汤。”《中国歌谣资料·山东临沐民歌·要吃元亨饭》：“煎饼粗，糊涂薄，肚子吃不饱，怎么能干活！”", jin: ["迷糊","胡涂","费解","模糊","懵懂","戆直","迷乱","昏迷"], fan: ["明白","清醒","清楚","聪明","精明","明了","理解"]).toJsonString(), rightAnswer: "明白/清醒/清楚/聪明/精明/明了/理解"),
                        QuestionItem(question: JinFanYiCiResult(word: "贫穷", pinyin: "pín qióng", content: "贫苦困厄。谓缺少财物，困顿不顺。《荀子·性恶》：“仁之所在无贫穷，仁之所亡无富贵。”《战国策·秦策一》：“苏秦曰：‘嗟乎！贫穷则父母不子，富贵则亲戚畏惧。人生世上，势位富贵，盖可忽乎哉！’”《史记·苏秦列传》引此作“贫贱”。指缺少资财。元王实甫《破窑记》第二折：“他见我贫穷，齎发与我两个银子，教我上朝应举去。”杨沫《我的生平》：“父亲不知去向，哥哥也不肯回家，只剩下我带着两个幼小的妹妹守着贫穷垂危的母亲。”指穷人。《礼记·月令》：“﹝季春之月﹞天子布德行惠，命有司发仓廩，赐贫穷，振乏絶。”《汉书·董仲舒传》：“今吏既亡教训於下，或不承用主上之法，暴虐百姓，与姦为市，贫穷孤弱，冤苦失职，甚不称陛下之意。”《魏书·释老志》：“后有出贷，先尽贫穷，徵债之科，一準旧格。”", jin: ["贫苦","贫困","贫寒","穷困","贫乏","贫弱","障碍","困苦","清寒","清贫","困穷","艰难","贫窭","穷苦","困难"], fan: ["富有","富饶","富裕","富强","富贵","优裕","宽裕","富庶"]).toJsonString(), rightAnswer: "富有/富饶/富裕/富强/富贵/优裕/宽裕/富庶"),
                        QuestionItem(question: JinFanYiCiResult(word: "夸奖", pinyin: "kuā jiǎng", content: "称赞：社员们都～他进步很快。", jin: ["奖励","称誉","赞美","称赞","赞许","夸赞","颂扬","夸耀","颂赞","赞扬","奖赏","讴歌","嘉勉","赞赏","歌颂","嘉奖","称道","表扬","褒奖","称扬","赞叹","赞誉","称颂","表彰"], fan: ["责骂","训斥","责怪","毁谤","诘责","捉弄","指斥","呵责","取笑","嘲弄","讥笑","谴责","责备","指责","批评"]).toJsonString(), rightAnswer: "责骂/训斥/责怪/毁谤/诘责/捉弄/指斥/呵责/取笑/嘲弄/讥笑/谴责/责备/指责/批评"),
                        QuestionItem(question: JinFanYiCiResult(word: "熟练", pinyin: "shú liàn", content: "工作、动作等因常做而有经验。唐柳宗元《非国语上·问战》：“士卒之熟练者众寡？器械之坚利者何若？”清魏源《圣武记》卷九：“德楞泰熟练军务，策划精明，拊循士卒，人皆用命。”鲁迅《三闲集·文艺与革命》：“他们便以熟练的才技，写出这种残缺和破败。”精细煮炼过的素绢。宋陆游《立夏》诗：“日斜汤沐罢，熟练试单衣。”明王兆云《挥麈诗话·百别诗》：“霜藤熟练莹无瑕，人去空悬对碧纱。”煮炼丝、麻、棉织品使之洁白柔软。参阅明宋应星《天工开物·熟练》。", jin: ["烂熟","老到","实习","流利","娴熟","老练","练习","老成","操练","精通","熟悉","纯熟","熟习","谙练","干练"], fan: ["生硬","生疏"]).toJsonString(), rightAnswer: "生硬/生疏"),
                        QuestionItem(question: JinFanYiCiResult(word: "阴暗", pinyin: "yīn àn", content: "亦作“阴闇”。黑暗；昏暗。《后汉书·郎顗传》：“窃见正月以来，阴闇连日。”唐元稹《苦雨》诗：“烦昏一日内，阴暗三四殊。”清纳兰性德《别意》诗：“芭蕉阴暗玉绳斜，风送微凉透碧纱。”曹禺《日出》第一幕：“窗外一座座的大楼，遮住了光线，屋里显得很阴暗。”比喻懊丧、消沉。梁斌《红旗谱》五五：“江涛看她脸上阴暗下来，握起她的手说：‘不回去又怎么办？’”柳青《创业史》第一部第十七章：“但是梁三老汉并不高兴，他仍然是进门时的阴暗表情。”沙汀《困兽记》七：“她没有说完，她的脸色又阴暗了，恢复了一向消沉、不快的常态。”不可告人的，不光明正大的。如：阴暗心理。", jin: ["昏暗","暗淡","阴晦","黑暗","晦暗","惨淡","黯淡","阴沉","阴霾","阴郁","阴雨","幽暗","阴森","昏昧","迷蒙"], fan: ["明亮","辉煌","晴朗","明后","明朗","爽朗"]).toJsonString(), rightAnswer: "明亮/辉煌/晴朗/明后/明朗/爽朗")
                    ]),
            Mistake(subject: "语文", category: MistakeCategory.MoXieGuShi.toString(), questionDescription: MistakeCategory.MoXieGuShi.generateDescription(),
                questionItems: [
                    QuestionItem(question: Poem(detailid: 95, title: "赋得古原草送别", type: "五言律诗", content: "离离原上草，一岁一枯荣。野火烧不尽，春风吹又生。远芳侵古道，晴翠接荒城。又送王孙去，萋萋满别情。", explanation: "1.离离：繁盛的样子。2.原：原野。3.荣：繁盛。4.远芳侵古道：伸向远方的一片野草，侵占了古老的道路。远芳：牵连一片的草。5.晴翠接荒城：在晴天，一片绿色连接着荒城。6.又送王孙去，萋萋满别情：这两句借用《楚辞》“王孙游兮不归，春草生兮萋萋”的典故。王孙：贵族。这里指的是自己的朋友。萋萋：草盛的样子。", appreciation: "这是一首应考习作，相传白居易十六岁时作。按科举考试规定，凡指定的试题，题目前须加“赋得”二字，作法与咏物诗相类似。《赋得古原草送别》即是通过对古原上野草的描绘，抒发送别友人时的依依惜别之情。诗的首句“离离原上草”，紧紧扣住题目“古原草”三字，并用叠字“离离”描写春草的茂盛。第二句“一岁一枯荣”，进而写出原上野草秋枯春荣，岁岁循环，生生不已的规律。第三、四句“野火烧不尽，春风吹又生”，一句写“枯”，一句写“荣”，是“枯荣”二字意思的发挥。不管烈火怎样无情地焚烧，只要春风一吹，又是遍地青青的野草，极为形象生动地表现了野草顽强的生命力。第五、六句“远芳侵古道，晴翠接荒城”，用“侵”和“接”刻画春草蔓延，绿野广阔的景象，“古道”“荒城”又点出友人即将经历的处所。最后两句“又送王孙去，萋萋满别情”，点明送别的本意。用绵绵不尽的萋萋春草比喻充塞胸臆、弥漫原野的惜别之情，真正达到了情景交融，韵味无穷。全诗章法谨严，用语自然流畅而又工整，写景抒情水乳交融，意境浑成，在“赋得体”中堪称绝唱。据宋人尤袤《全唐诗话》记载：白居易十六岁时从江南到长安，带了诗文谒见当时的大名士顾况。顾况看了名字，开玩笑说：“长安米贵，居大不易。”但当翻开诗卷，读到这首诗中“野火烧不尽，春风吹又生”两句时，不禁连声赞赏说：“有才如此，居亦何难！”连诗坛老前辈也被折服了，可见此诗艺术造诣之高。", author: "白居易").toJsonString(), rightAnswer: "离离原上草，一岁一枯荣。野火烧不尽，春风吹又生。远芳侵古道，晴翠接荒城。又送王孙去，萋萋满别情。"),
                    QuestionItem(question: Poem(detailid: 1, title: "行宫", type: "五言绝句", content: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。", explanation: "⑴寥落：寂寞冷落。⑵行宫：皇帝在京城之外的宫殿。", appreciation: "元稹的这首《行宫》是一首抒发盛衰之感的诗，可与白居易《上阳白发人》参互并观。这里的古行宫即洛阳行宫上阳宫，白头宫女即“上阳白发人”。据白居易《上阳白发人》，这些宫女天宝（742-756）末年被“潜配”到上阳宫，在这冷宫里一闭四十多年，成了白发宫人。这首短小精悍的五绝具有深邃的意境，富有隽永的诗味，倾诉了宫女无穷的哀怨之情，寄托了诗人深沉的盛衰之感。此诗首句点明地点：古行宫；二句暗示时间：红花盛开之季；三句介绍人物；白头宫女；四句描绘动作：闲坐说玄宗。构筑了一幅完整动人的图画。当年花容月貌，娇姿艳质，辗转落入宫中，寂寞幽怨；此时青春消逝，红颜憔悴；闲坐无聊，只有谈论已往。此情此景，十分凄绝。这首诗平实，但很有概括力，也很含蓄，并给人以想象的天地，历史沧桑之感尽在不言之中。诗人塑造意境，艺术上主要运用了两种表现手法。一是以少总多。我国古典诗歌讲究精炼，写景、言情、叙事都要以少总多。这首诗正具有举一而反三，字少而意多的特点。四句诗，首句指明地点，是一座空虚冷落的古行宫；次句暗示环境和时间，宫中红花盛开，正当春天季节；三句交代人物，几个白头宫女，与末句联系起来推想，可知是玄宗天宝末年进宫而幸存下来的老宫人；末句描写动作，宫女们正闲坐回忆、谈论天宝遗事。二十个字，地点、时间、人物、动作，全都表现出来了，构成了一幅非常生动的画面。这个画面触发读者联翩的浮想：宫女们年轻时都是月貌花容，娇姿艳质，这些美丽的宫女被禁闭在这冷落的古行宫之中，成日价寂寞无聊，看着宫花，花开花落，年复一年，青春消逝，红颜憔悴，白发频添，如此被摧残，往事不堪重省。然而，她们被禁闭冷宫，与世隔绝，别无话题，却只能回顾天宝时代玄宗遗事，此景此情，令人凄绝。“寥落”、“寂寞”、“闲坐”，既描绘当时的情景，也反映诗人的倾向。凄凉的身世，哀怨的情怀，盛衰的感慨，二十个字描绘出那样生动的画面，表现出那样深刻的意思，所以宋洪迈《容斋随笔》卷二说这首诗“语少意足，有无穷之味”；明胡应麟《诗薮·内编》卷六以为这首诗是王建所作，并说“语意绝妙，合（王）建七言《宫词》百首，不易此二十字也”。另一个表现手法是以乐景写哀。我国古典诗歌，其所写景物，有时从对立面的角度反衬心理，利用忧思愁苦的心情同良辰美景气氛之间的矛盾，以乐景写哀情，却能收到很好的艺术效果。这首诗也运用了这一手法。诗所要表现的是凄凉哀怨的心境，但却着意描绘红艳的宫花。红花一般是表现热闹场面，烘托欢乐情绪的，但在这里却起了很重要的反衬作用：盛开的红花和寥落的行宫相映衬，加强了时移世迁的盛衰之感；春天的红花和宫女的白发相映衬，表现了红颜易老的人生感慨；红花美景与凄寂心境相映衬，突出了宫女被禁闭的哀怨情绪。红花，在这里起了很大的作用。这都是利用好景致与恶心情的矛盾，来突出中心思想，即王夫之《姜斋诗话》所谓“以乐景写哀”，一倍增其哀。白居易《上阳白发人》“宫莺百啭愁厌闻，梁燕双栖老休妒”，也可以说是以乐写哀。不过白居易的写法直接揭示了乐景写哀情的矛盾，而元稹《行宫》则是以乐景作比较含蓄的反衬，显得更有余味。", author: "元稹").toJsonString(), rightAnswer: "寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。"),
                    QuestionItem(question: Poem(detailid: 4, title: "相思", type: "五言绝句", content: "红豆生南国，春来发几枝。愿君多采撷，此物最相思。", explanation: "１、红豆：又名相思子，一种生在岭南地区的植物，结出的籽象豌豆而稍扁，呈鲜红色。２、采撷：采摘。", appreciation: "这是借咏物而寄相思的诗。一题为《江上赠李龟年》，可见是眷怀友人无疑。起句因物起兴，语虽单纯，却富于想象；接着以设问寄语，意味深长地寄托情思；第三句暗示珍重友谊，表面似乎嘱人相思，背面却深寓自身相思之重；最后一语双关，既切中题意，又关合情思，妙笔生花，婉曲动人。全诗情调健美高雅，怀思饱满奔放，语言朴素无华，韵律和谐柔美。可谓绝句的上乘佳品唐代绝句名篇经乐工谱曲而广为流传者为数甚多。王维《相思》就是梨园弟子爱唱的歌词之一。据说天宝之乱后，著名歌者李龟年流落江南，经常为人演唱它，听者无不动容。红豆产于南方，结实鲜红浑圆，晶莹如珊瑚，南方人常用以镶嵌饰物。传说古代有一位女子，因丈夫死在边地，哭于树下而死，化为红豆，于是人们又称呼它为“相思子”。唐诗中常用它来关合相思之情。而“相思”不限于男女情爱范围，朋友之间也有相思的，如苏李诗“行人难久留，各言长相思”即著例。此诗题一作《江上赠李龟年》，可见诗中抒写的是眷念朋友的情绪。“南国”（南方）即是红豆产地，又是朋友所在之地。首句以“红豆生南国”起兴，暗逗后文的相思之情。语极单纯，而又富于形象。次句“春来发几枝”轻声一问，承得自然，寄语设问的口吻显得分外亲切。然而单问红豆春来发几枝，是意味深长的，这是选择富于情味的事物来寄托情思。“来日绮窗前，寒梅著花未？”（王维《杂诗》）对于梅树的记忆，反映出了客子深厚的乡情。同样，这里的红豆是赤诚友爱的一种象征。这样写来，便觉语近情遥，令人神远。第三句紧接着寄意对方“多采撷”红豆，仍是言在此而意在彼。以采撷植物来寄托怀思的情绪，是古典诗歌中常见手法，如汉代古诗：“涉江采芙蓉，兰泽多芳草，采之欲遗谁？所思在远道”即著例。“愿君多采撷”似乎是说：“看见红豆，想起我的一切吧。”暗示远方的友人珍重友谊，语言恳挚动人。这里只用相思嘱人，而自己的相思则见于言外。用这种方式透露情怀，婉曲动人，语意高妙。宋人编《万首唐人绝句》，此句“多”字作“休”。用“休”字反衬离情之苦，因相思转怕相思，当然也是某种境况下的人情状态。用“多”字则表现了一种热情饱满、一往情深的健美情调。此诗情高意真而不伤纤巧，与“多”字关系甚大，故“多”字比“休”字更好。末句点题，“相思”与首句“红豆”呼应，既是切“相思子”之名，又关合相思之情，有双关的妙用。“此物最相思”就象说：只有这红豆才最惹人喜爱，最叫人忘不了呢。这是补充解释何以“愿君多采撷”的理由。而读者从话中可以体味到更多的东西。诗人真正不能忘怀的，不言自明。一个“最”的高级副词，意味极深长，更增加了双关语中的含蕴。全诗洋溢着少年的热情，青春的气息，满腹情思始终未曾直接表白，句句话儿不离红豆，而又“超以象外，得其圜中”，把相思之情表达得入木三分。它“一气呵成，亦须一气读下”，极为明快，却又委婉含蓄。在生活中，最情深的话往往朴素无华，自然入妙。王维很善于提炼这种素朴而典型的语言来表达深厚的思想感情。所以此诗语浅情深，当时就成为流行名歌是毫不奇怪的。", author: "王维").toJsonString(), rightAnswer: "红豆生南国，春来发几枝。愿君多采撷，此物最相思。")
                ]),
            Mistake(subject: "语文", category: MistakeCategory.ZuCi.toString(), questionDescription: MistakeCategory.ZuCi.generateDescription(),
                questionItems: [
                    QuestionItem(question: "传", rightAnswer: "传输/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染/传达/传送/传说/传染"),
                    QuestionItem(question: "液", rightAnswer: "饱和溶液/出液/凤液/鼻液/冻液/白液/丹液/胶体溶液/筋液/分液漏斗/九液/精液/甘液/肌液/金波玉液/金液/蜡液/醴液/鞴液/和液/炼液/寒液/降液/金浆玉液/秋液/溶液/融液/融液贯通/输液/沥液/黏液/鸾液/柔液/灵液/七液/琼液/入液/渖液/霜液/泰液/五粮液/石液/矢液/汤液/温液/血液循环/素液/唾液/唾液腺/琬液/香液/五液/消液/星液/淫液/松液/霞液/新鲜血液/悬浊液/液/液池/液樠/液洽/液态/液汤/液廷/液压油/液液/液雨/阴液/太液/胃液/仙液/仙液琼浆/玉液金波/玉液金浆/玉液琼浆/幽液/银液/云液/组织液/烟液/御液/汁液/粘液/粘液性水肿/滋液"),
                    QuestionItem(question: "健", rightAnswer: "干健/古健/臿健/麤健/桀健/矫健/军健/精健/紧健/魁健/李健吾(1906-1982)/憨健/老健/躥健/急健/俊健/伉健/斗健/峻健/劲健/警健/快健/马前健/活健/活龙鲜健/坚额健舌/佼健/趫健/猛健/平健/强健/峭健/清健/酋健/率健/票健/遒健/瘦健/爽健/通健/吴健雄(1912-1997)/纤健/鲜车健马/鲜健/雅健/完健/雄深雅健/眼保健操/竦健/顽健/武健/尉健行(1931- )/黠健/枭健/阳健/勇健/月健天恩/行健/牙健/整健/躁健/壮健/运动健将/陟健/中岛健藏(1903-1979)/作健"),
                    QuestionItem(question: "洒", rightAnswer: "风流潇洒/赤洒洒/备洒扫/备埽洒/阔洒洒/倍洒/离洒/飞洒/迸洒/滮洒/交洒/湔洒/挥洒/醴洒/空洒洒/利利洒洒/利洒/流洒/三洒/漂洒/飘洒/泼泼洒洒/泼洒/扫洒/淋洒/喷洒/平洒/洒兵/洒尘/洒带/洒道/洒调/洒光/洒海剌/洒翰/洒豁/洒酒/洒泪/洒泪雨/洒练/洒落/洒墨/洒派/洒泣/洒签/洒然/洒如/洒洒/洒洒潇潇/洒扫/洒扫应对/洒埽/洒涕/洒脱/洒淅/筛寒洒白/筒洒/脱洒/洒线/洒削/洒鞋/洒心/洒心更始/洒绣/洒濯/飒洒/散洒/潠洒/洋洋洒洒/一火洒/析洒/消洒/相门洒埽/萧洒/沃洒/淅洒/潇洒/沾洒/震洒/昭洒"),
                    QuestionItem(question: "夜", rightAnswer: "彻夜/碍夜/吊夜/博夜/朝朝寒食﹐夜夜元宵/朝歌夜弦/冲夜/独夜/隔夜/放夜/丁夜/丙夜/白夜/澈夜/俾夜作昼/俾昼作夜/黑天半夜/甲夜/打夜狐/打夜胡/打夜作/秉烛夜游/分夜/分夜钟/好天良夜/即夜/静夜思/夫妻无隔夜之仇/辰夜/担隔夜忧/花朝月夜/过夜/晖夜/极夜/节夜/景夜/逼夜/飞天夜叉/枫桥夜泊/成夜/弛夜/池鹅夜击/第十二夜/不夜/不夜侯/不夜珠/半夜/半夜三更/伴大夜/鬼夜哭/鬼夜泣/获虎之夜/晦夜/皓夜/朗夜/警夜/累夜/连明彻夜/连明达夜/连明连夜/连日继夜/连日连夜/莫夜/平夜/花烛夜/嘉夜/禁夜/兰夜/竟夜/良夜/弥日累夜/门不夜关/门不夜扃/年夜/三日三夜说不了/上半夜/司夜/凉夜/落夜/青夜/穷夜/却金暮夜/日日夜夜/三五夜/深夜/守夜/侍夜/叔夜/买夜/买夜钱/冥夜/母夜叉/牛头夜叉/起夜/侵夜/日夜/日夜兼程/日以继夜/山阴夜雪/生死长夜/暑夜/连更彻夜/连更晓夜/连更星夜/漏夜/龙夜/暮夜/暮夜金/牛衣夜哭/潜夜/鹊夜传枝/入夜/上夜/神母夜号/神母夜哭/霜夜/望夜/武宿夜/祇夜/前半夜/清夜/晩夜/戊夜/宵夜/无昼无夜/西夜国/晓行夜宿/晓行夜住/晓夜/下夜/炫昼缟夜/玄夜/衣锦夜行/衣锦夜游/元夜/天方夜谭/乌夜啼/五夜/五夜元宵/无明无夜/无明夜/小节夜/小年夜/消夜/消夜果/消夜图/星夜/行夜/修夜/薛夜来/夜艾/夜班/夜半/夜半客/夜半乐/夜奔/夜不闭户/夜不收/夜餐/夜残/夜草/夜叉/夜叉国/夜禅/夜长梦短/夜场/夜车/夜沉沉/夜持/夜筹/夜春/夜大/夜大学/夜捣/夜籴/夜定/夜度娘/夜儿/夜儿个/夜发/夜饭/夜飞蝉/夜分/夜夫/夜府/夜蛤/夜工/夜光/夜光杯/夜光璧/夜光表/夜光枕/夜光芝/夜光珠/夜航/夜航船/夜合/夜合花/夜合资/夜何其/夜壑/夜壶/夜户/夜话/夜会/夜昏/夜魂/夜间/夜禁/夜精/夜景/夜警/夜局/夜觉/夜刻/夜客/夜课/夜空/夜来/夜来香/夜郎/夜里/夜里个/夜漏/夜漫漫/夜盲/夜盲眼/夜盲症/夜猫子/夜明/夜明表/夜明帘/夜明苔/夜明犀/夜明杖/夜明枕/夜明珠/夜冥/夜暝/夜尿症/夜盆儿/夜魄/夜气/夜勤/夜日/夜色/夜膳/夜深/夜时/夜食/夜士/夜室/夜肆/夜台/夜天/衣绣夜游/寅夜/岁夜/通宵彻夜/通夜/午夜/午夜钟/宣夜/笑面夜叉/雄鸡夜鸣/一日一夜/耀夜/夜天光/夜庭/夜头/夜柝/夜晩/夜未央/夜午/夜夕/夜袭/夜香/夜宵/夜消/夜校/夜星子/夜行/夜行被绣/夜行人/夜行游女/夜学/夜巡/夜严/夜眼/夜宴/夜燕/夜央/夜妖/夜夜曲/夜以继日/夜阴/夜莺/夜永/夜游神/夜游子/夜鱼/夜渔/夜雨对床/夜战/夜照/夜者/夜直/夜中/夜珠/夜潴/夜装/夜总会/夜作/夜坐吟/移日卜夜/永夜/遂夜/宿夜/宿夜然诺/透夜/下半夜/无晓夜/雪夜访普/雁夜/遥夜/银夜/夤夜/乙夜/养夜/昼伏夜动/昼伏夜行/昼伏夜游/昼日昼夜/昼想夜梦/昼夜/昼阴夜阳/小夜班/小夜曲/歇夜/一夜/一夜风流/一夜夫妻百夜恩/一旦夜/鱼龙夜/以日继夜/以夜继朝/以夜继日/以夜继昼/以夜续昼/月夜/镇日镇夜/镇夜/仲夏夜之梦/照夜/照夜白/照夜宝/照夜玑/照夜清/中夜/中夜舞/专夜/住夜/昨夜/坐夜/早夜/闸夜/直夜/值夜/烛夜/烛夜花/足日足夜/蚤出夜入/蚤兴夜寐/蚤夜/终夜/昼度夜思/脂夜/灼夜"),
                    QuestionItem(question: "建", rightAnswer: "筹建/构建/分建/常建/杓建/匡建/福建省/福建子/工业建筑/顾建康/经济基础与上层建筑/开建/鼎建/公共建筑/改建/半封建/斗建/封建/封建把头/封建地租/封建割据/封建论/封建社会/封建社会主义/封建士大夫/封建余孽/封建制度/封建主/封建主义/盖建/懋建/建安风骨/建安骨/建白/建本/建弼/建标/建策/建茶/建倡/建辰月/建陈/建齿/建丑/建除家/建除体/建储/建春/建疵/建德/建德国/建德乡/建定/建都/建分/建櫜/建功立业/建鼓/建官/建亥/建号/建侯/建华/建画/建麾/建极/建家/建交/建醮/建节/建军/建类/建礼/建历/建立/建瓴/建瓴高屋/建马/建卯月/建明/建茗/建木/建年/建缮/建设/建生/建始殿/建事/建首/建竖/建水县/建巳月/建嗣/建同/建统/建文/建溪春/建邪/建星/建戌/建牙/建言/建阳/建窑/建业/建义/建寅/建寅月/建旟/建元/建章/建章宫/建制/建寘/建置/建中/建筑摄影/利建/设建/社会主义建设/破竹建瓴/论建/起建/笯赤建国/虱建草/树建/庶建/殊建/三建/王建(约767-约830)/兴建/修建/豫建/营建/悬鼗建铎/选建/月建/中美建交联合公报/筑建/组建/朱建华(1963- )/运筹建策/肇建/左建外易/在建/中国建设银行"),
                    QuestionItem(question: "酒", rightAnswer: "撤酒/董酒/持螯把酒/高粱酒/干酢酒/菖蒲酒/冰堂酒/醇酒/醇酒妇人/醇酒美人/荡酒/脯酒/粗酒/楚酒/大羹玄酒/尝酒/颠酒/逞酒/吃白酒/案酒/恶醉强酒/冻酒/挏酒/挏马酒/打酒坐/打酒座/茶余酒后/酬酒/避酒/干酒/白羊酒/白衣酒/白衣送酒/吃花酒/备酒浆/阿剌吉酒/阿剌酒/合欢酒/覆酒瓮/害酒/将进酒/好酒/进酒/京口酒/借酒浇愁/敬酒不吃吃罚酒/菊华酒/菊酒/旧酒徒/旧瓶新酒/旧瓶装新酒/苦酒/蓝尾酒/牢酒/醪酒/洞天圣酒将军/湩酒/甘酒/鹅雏酒/鹅黄酒/福酒/醜酒/鸱头酒/酢酒/醋酒/狠酒/红灯緑酒/过酒/监酒/会酒/浆酒霍肉/浆酒藿肉/浆米酒/灰酒/金丝酒/谨酒/肯酒/就酒/离酒/腊酒/烂肠酒/椒柏酒/椒栢酒/椒酒/逼酒/从酒/边酒/柑酒/鹅酒/百花酒/耽酒/躭酒/簇酒/汾酒/公酒/和酒/花雕酒/花酒/鸡酒/交心酒/哈剌基酒/讲书祭酒/解酒/金钗换酒/金貂换酒/金貂取酒/金貂贳酒/节酒/酒媪/酒吧/酒吧间/酒把持/酒半/酒伴/酒榜/酒牓/酒杯/酒杯藤/酒悲/酒标/酒鳖/酒兵/酒病/酒病花愁/酒博士/酒逋/酒瓿/酒材/酒藏/酒槽/酒肠/酒场/酒潮/酒车/酒掣子/酒铛/酒城/酒酲/酒池/酒池肉林/酒筹/酒臭/酒舩/酒船/酒船台/酒床/酒慈/酒次/酒次青衣/酒刺/酒村/酒大工/酒胆/酒疸/酒啖/酒党/酒舠/酒到脐/酒道/酒德/酒敌/酒底/酒地花天/酒颠/酒店/酒淀/酒董/酒湩/酒毒/酒端/酒恶/酒饵/酒法/酒坊/酒坊使/酒舫/酒风/酒疯/酒疯子/酒逢知己千杯少/金屑酒/开酒/醴酒/醴酒不设/斗酒/斗酒百篇/斗酒飞拳/斗酒双柑/斗酒学士/斗酒只鸡/东岩酒/恶酒/病酒/艾酒/池酒林胾/沽酒/沽美酒/酤酒/鸡尾酒/鸡血酒/禁酒/金谷酒/金谷酒数/酒逢知己千钟少/酒缶/酒脯/酒妇/酒赋/酒缸/酒堈/酒膏/酒歌/酒功/酒觥/酒钩/酒沽/酒辜/酒酤/酒骨/酒官/酒罐子/酒光/酒鬼/酒国/酒果/酒菓/酒过/酒海/酒酣/酒豪/酒痕/酒红/酒后茶余/酒胡/酒胡芦/酒壶/酒葫芦/酒虎诗龙/酒户/酒簄/酒花/酒话/酒荒/酒幌/酒祸/酒几/酒妓/酒家/酒家保/酒家胡/酒家佣/酒价/酒驾/酒监/酒脚/酒教/酒窖/酒酵/酒戒/酒劲/酒浸头/酒禁/酒京/酒经/酒精/酒精灯/酒纠/酒糺/酒臼/酒局/酒具/酒爵/酒军/酒榼/酒渴/酒客/酒课/酒窟/酒库/酒狂/酒魁/酒困/酒阑/酒痨/酒醪/酒姥/酒乐/酒罍/酒厘/酒礼/酒醴/酒吏/酒利/酒帘/酒脸/酒鳞/酒伶/酒令/酒龙/酒龙诗虎/酒楼/酒篓/酒卢/酒垆/酒炉/酒録/酒簏/酒律/酒緑灯红/酒螺/酒蠃/酒幔/酒枚/酒闷子/酒米/酒米圆/酒面/酒民/酒缗/酒魔/酒魔头/酒囊/酒囊饭包/酒囊饭袋/酒娘/酒娘子/酒糵/酒排间/酒牌/酒盘/酒柸/酒醅/酒斾/酒斾子/酒旆/酒盆/酒朋/酒癖/酒瓢/酒品/酒评鲁赵/酒瓶/酒缾/酒粕/酒魄/酒铺/酒齐/酒旗/酒旗星/酒气/酒器/酒钱/酒鎗/酒情/酒权/酒泉/酒榷/酒人/酒人保/酒容/酒肉/酒肉朋友/酒肉兄弟/眖酒/朗姆酒/醨酒/酪酒/角酒/渴酒/酹酒/恋酒迷花/恋酒贪花/刘伶酒/露酒/緑酒红灯/美酒/马奶酒/拈酒/闹酒/攉酒/活酒/霹雳酒/皮酒/平阳酒/浇酒/戒酒/酒入舌出/酒色/酒色天/酒膳/酒觞/酒舍/酒社/酒甧/酒神/酒升/酒生/酒圣/酒失/酒石酸/酒食地狱/酒食征逐/酒史/酒市/酒式/酒势/酒适/酒树/酒水/酒税/酒思/酒素/酒嗉子/酒算/酒所/酒台/酒太公/酒态/酒坛/酒提/酒畑/酒亭/酒桶/酒筒/酒头/酒椀/酒望/酒翁/酒瓮/酒瓮饭囊/酒瓮子/酒务/酒务子/酒饩/酒仙/酒仙翁/酒乡/酒蠁/酒谐/酒蟹/酒心/酒兴/酒星/酒瑆/酒醒/酒性/酒醑/酒言酒语/酒筵/酒颜/酒宴/酒艳/酒燕/酒肴/酒殽/酒靥/酒衣/酒蚁/酒逸/酒隐/酒罂/酒罃子/酒影/酒游花/酒友/酒有别肠/酒有别膓/酒余茶后/酒盂/酒妪/酒眃/酒晕/酒晕紁/酒晕妆/酒韵/酒在肚里，事在心头/酒在口头，事在心头/酒在心头，事在肚里/酒糟/酒糟鼻/酒糟头/酒灶/酒贼/酒皶鼻/酒债/酒盏/酒醆/酒战/酒正/酒政/酒卮/酒巵/酒直/酒帜/酒炙/酒中八仙/酒中趣/酒中蛇/酒盅/酒钟/酒舟/酒注子/酒馔/酒莊/酒子/酒滓/酒租/酒醉/酒尊/酒樽/酒罇/酒佐/酒坐/酒座/金酒/嚼酒/醮酒/婪尾酒/浪酒闲茶/礼酒/破酒/猎酒/量酒/轮回酒/芦酒/蛮酒/漉酒/漉酒巾/年酒/糱酒/内酒/耆酒/朋酒/汽酒/评酒/醲酒/弄酒/擒奸酒/青田酒/劝酒/劝酒胡/三白酒/三鞭酒/桑落酒/桑椹酒/山酒/社酒/烧酒/使酒/使酒骂坐/使酒骂座/生酒/十酒/事酒/沥酒/留犁挠酒/鸬鹚酒/虏酒/鲁酒薄而邯郸围/满月酒/泥酒/麻姑酒/名酒/骑驴酒/蜜酒/醅酒/陪酒/蚍蜉酒草/青衣行酒/乳酒/三辰酒/师友祭酒/水酒/侍酒/树头酒/秫酒/双柑斗酒/扑酒/临邛酒/醽酒/梅村祭酒/挠酒/酿酒/牛酒/卯酒/碰柜酒/丕酒/齐酒/飘酒/强酒/女酒/顷刻酒/请酒/清酒/让酒/若酒/若下酒/伤酒/绍酒/绍兴酒/诗酒/诗酒风流/诗酒社/诗朋酒侣/诗朋酒友/石榴酒/寿酒/试酒/黍酒/黍米酒/葡萄酒/蒱酒/令酒/渌酒/麦酒/卖酒提瓶/脑儿酒/命酒/奶酒/乞浆得酒/马酒/千里酒/千日酒/青稞酒/榷酒/榷酒酤/榷酒钱/榷酒征茶/逡巡酒/肉朋酒友/肉山酒海/阮貂换酒/阮氏酒/箬下酒/撒酒风/洒酒/三酒/筛酒/蛇酒/麝酒/食酒/诗坛祭酒/市酒/漱酒/蒲酒/蒲桃酒/蒲陶酒/蒲萄酒/送酒/贪酒/逃酒/筩酒/无彝酒/喜酒/先酒/下酒/贤人酒/青梅煮酒/琴歌酒赋/曲阿酒/曲酒/热酒/软脚酒/觞酒/上尊酒/上樽酒/时酒/酾酒/牲酒/乡饮酒/乡饮酒礼/松肪酒/颂酒/缩酒/殢酒/通路酒/猥酒/乌程酒/香酒/无灰酒/无酒/戏酒/消肠酒/消酒/吴祭酒/谢酒/谢亲酒/凶酒/絮酒/哑酒/舀酒/蚁酒/倚酒三分醉/宜城酒/宜春酒/有酒/有酒胆没饭胆/有酒胆无饭力/松花酒/松黄酒/溲酒/醙酒/索酒/岁旦酒/梯气酒/添酒/头脑酒/屠苏酒/小酒/小酒店/昔酒/消胀酒/新瓶装旧酒/衔酒/噀酒/窨酒/肴酒/淫酒/莤酒/娱酒/岁酒/松叶酒/讨酒钱/宿酒/天酒/酴酒/酴縻酒/酴醾酒/酴醿酒/投酒/投脑酒/豚酒/亡酒/窝心酒/午酒/文酒/销肠酒/仙家酒/献酒/闲茶浪酒/压酒/压酒囊/笑酒窝/雄黄酒/羊羔美酒/羊酒/义酒/颐酒/恬酒/甜酒/土酒/醒酒/醒酒冰/醒酒池/醒酒花/醒酒石/醒酒汤/杏酒/湑酒/烟酒/雪酒/盐酒蟹/酽酒/用酒打猩猩/侑酒/香槟酒/斋中酒/醆酒/鸩酒/只鸡斗酒/只鸡絮酒(只ｚｈī)/只鸡樽酒/旨酒/中酒/彘肩斗酒/醉翁之意不在酒/纵酒/行酒/酗酒/血酒/引酒/猿酒/醳酒/元酒/真钦酒/支酒/卮酒/中山酒/重阳酒/治酒/治聋酒/稚酒/置酒/渍酒/尊酒/真一酒/撞门酒/煮酒/樽酒/樽酒论文/罇酒/载酒问奇字/早秫酒/张公吃酒李公颠/秩酒/追酒/谘酒/嗺酒/佐酒/酝酒/止酒/征酒/重酒/驻色酒/祝酒/浊酒/醉酒饱德"),
                    QuestionItem(question: "玻", rightAnswer: "毛玻璃/铅玻璃/钠钙玻璃/石英玻璃/水玻璃")
                ]),
            Mistake(subject: "语文", category: MistakeCategory.XiuGaiBingJu.toString(), questionDescription: MistakeCategory.XiuGaiBingJu.generateDescription(),
                questionItems: [
                    QuestionItem(question: BingJu(sentence: "为了班集体，做了很多好事。", type: [BingJuCategory.ChengFenCanQue.toString()]).toJsonString(), rightAnswer: "为了班集体，小明做了很多好事。"),
                    QuestionItem(question: BingJu(sentence: "他做事很冷静、武断。", type: [BingJuCategory.YongCiBuDang.toString()]).toJsonString(), rightAnswer: "他做事很冷静、果断。"),
                    QuestionItem(question: BingJu(sentence: "在联欢会上，我们听到悦耳的歌声和优美的舞蹈。", type: [BingJuCategory.DaPeiBuDang.toString()]).toJsonString(), rightAnswer: "在联欢会上，我们听到悦耳的歌声，看到优美的舞蹈。")
                ])
        ]
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try values.decode(String.self, forKey: .username)
        self.nickname = try values.decode(String.self, forKey: .nickname)
        self.realname = try values.decode(String.self, forKey: .realname)
        self.idcard = try values.decode(String.self, forKey: .idcard)
        self.emailaddress = try values.decode(String.self, forKey: .emailaddress)
        self.password = try values.decode(String.self, forKey: .password)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        self.mistakeList = try values.decode([Mistake].self, forKey: .mistakeList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(realname, forKey: .realname)
        try container.encode(idcard, forKey: .idcard)
        try container.encode(emailaddress, forKey: .emailaddress)
        try container.encode(password, forKey: .password)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(mistakeList, forKey: .mistakeList)
    }
}

class Mistake: ObservableObject, Identifiable, Codable { // 错题
    @Published var subject: String // 错题所属学科：语文、数学、英语等
    @Published var category: String // 错题类型：近义词、反义词等
    @Published var questionDescription: String // 题干描述："写出下列词语的反义词。"
    @Published var questionItems: [QuestionItem] // 题目项数组
    @Published var createdDate: String // 创建的时间
    @Published var revisedRecords: [RevisedRecord] // 已经复习的记录
    @Published var nextRevisionDate: String // 下一次复习的时间
    @Published var revisionStatus: String // 正在复习标记
    
    func equals(mistake: Mistake) -> Bool {
        if self.subject == mistake.subject &&
            self.category == mistake.category &&
            self.questionDescription == mistake.questionDescription &&
            self.createdDate == mistake.createdDate &&
            self.nextRevisionDate == mistake.nextRevisionDate &&
            self.revisionStatus == mistake.revisionStatus {
            return true
        } else {
            return false
        }
    }
    
    func totalRevisionEvaluation() -> Double { // 根据所有复习记录计算总的复习进度，返回值在[0, 1]之间
        var progress: Double = 0
        
        let familiar: Double = 100 // 掌握为100分
        let vague: Double = 50 // 模糊为50分
        let forgotten: Double = 0 // 忘记为0分
        
        if self.revisedRecords.count != 0 {
            for record in self.revisedRecords {
                if record.revisedPerformance == "掌握" {
                    progress += familiar
                } else if record.revisedPerformance == "模糊" {
                    progress += vague
                } else {
                    progress += forgotten
                }
            }
            progress /= Double(self.revisedRecords.count) * 100.0
        }
        
        return progress
    }
    
    func isRevising() -> Bool {
        if self.revisionStatus == "true" {
            return true
        } else {
            return false
        }
    }
    
    enum CodingKeys: CodingKey {
        case subject
        case category
        case questionDescription
        case questionItems
        case createdDate
        case revisedRecords
        case nextRevisionDate
        case revisionStatus
    }
    
    init(subject: String, category: String, questionDescription: String, questionItems: [QuestionItem]) {
        self.subject = subject
        self.category = category
        self.questionDescription = questionDescription
        self.questionItems = questionItems
        self.createdDate = DateFunctions.functions.currentDate()
        self.revisedRecords = [
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 0), revisedPerformance: "掌握"),
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 2), revisedPerformance: "模糊"),
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 3), revisedPerformance: "忘记"),
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 5), revisedPerformance: "模糊"),
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 7), revisedPerformance: "掌握"),
            RevisedRecord(revisedDate: DateFunctions.functions.addDate(startDate: DateFunctions.functions.currentDate(), addition: 10), revisedPerformance: "模糊")]
        self.nextRevisionDate = DateFunctions.functions.currentDate()
        self.revisionStatus = "false"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.subject = try values.decode(String.self, forKey: .subject)
        self.category = try values.decode(String.self, forKey: .category)
        self.questionDescription = try values.decode(String.self, forKey: .questionDescription)
        self.questionItems = try values.decode([QuestionItem].self, forKey: .questionItems)
        self.createdDate = try values.decode(String.self, forKey: .createdDate)
        self.revisedRecords = try values.decode([RevisedRecord].self, forKey: .revisedRecords)
        self.nextRevisionDate = try values.decode(String.self, forKey: .nextRevisionDate)
        self.revisionStatus = try values.decode(String.self, forKey: .revisionStatus)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subject, forKey: .subject)
        try container.encode(category, forKey: .category)
        try container.encode(questionDescription, forKey: .questionDescription)
        try container.encode(questionItems, forKey: .questionItems)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(revisedRecords, forKey: .revisedRecords)
        try container.encode(nextRevisionDate, forKey: .nextRevisionDate)
        try container.encode(revisionStatus, forKey: .revisionStatus)
    }
}

struct RevisedRecord: Codable { // 已复习记录
    let revisedDate: String
    let revisedPerformance: String
}

class QuestionItem: ObservableObject, Identifiable, Codable { // 题目项
    @Published var question: String // 题目
    @Published var rightAnswer: String // 正确答案
    @Published var answer: String // 作答答案
    
    enum CodingKeys: CodingKey {
        case question
        case rightAnswer
        case answer
    }
    
    init(question: String, rightAnswer: String) {
        self.question = question
        self.rightAnswer = rightAnswer
        self.answer = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try values.decode(String.self, forKey: .question)
        self.rightAnswer = try values.decode(String.self, forKey: .rightAnswer)
        self.answer = try values.decode(String.self, forKey: .answer)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(question, forKey: .question)
        try container.encode(rightAnswer, forKey: .rightAnswer)
        try container.encode(answer, forKey: .answer)
    }
}
