import CSV
import Foundation

// 修改这里并授予CSV权限
let path = "/Users/yangxijie/Desktop/CCCC 浣熊财记/PROJECT/TestData-CSV/测试数据集.csv"

let stream = InputStream(fileAtPath: path)!
let csv = try! CSVReader(stream: stream, hasHeaderRow: true)

let headerRow = csv.headerRow!
// print("\(headerRow)")

var counter: Int = 1

var testDataFile = "import Foundation\nimport SwiftDate\n\n// [测试数据]\n\n"
var testMetaItemsArray = "let testMetaItems: [MetaItem] = ["

while let _ = csv.next() {
//    print("\(csv["originalText"]!)")
//    print("\(csv["spentMoneyAt"]!)")
//    print("\(csv["event"]!)")
//    print("\(csv["amount_float"]!)")
//
//    print("\(csv["tags"]!)".split(separator: " "))
//
//    print("\(csv["focus"]!)")
//
//    print("\(csv["forWho"]!)")
//
//    print("\(csv["story.rating"]!)")
//    print("\(csv["story.emoji"]!)")
//    print("\(csv["story.text"]!)")

    var data = """
    let testMetaItem_\(counter) = MetaItem(
        originalText: "\(csv["originalText"]!)",
        spentMoneyAt: "\(csv["spentMoneyAt"]!)".toDate("yyMMdd", region: regionChina) ?? DateInRegion(region: regionChina),
        event: "\(csv["event"]!)",
        amount_float: \(csv["amount_float"]!)
    """

    if "\(csv["tags"]!)" != "" {
        let tagsListString =
            "\(csv["tags"]!)".split(separator: " ")

        data += """

            ,tags: \(tagsListString)
        """
    }

    if "\(csv["focus"]!)" != "" {
        data += """

            ,focus: "\(csv["focus"]!)"
        """
    }

    if "\(csv["forWho"]!)" != "" {
        let forWhoListString =
            "\(csv["forWho"]!)".split(separator: " ")

        data += """

            ,forWho: \(forWhoListString)
        """
    }

    if "\(csv["story.rating"]!)" != "" {
        data += """

            ,story: MetaItem.Story(rating: \(csv["story.rating"]!),
                                  emoji: "\(csv["story.emoji"]!)",
                                  text: "\(csv["story.text"]!)")
        """
    }

    data += """

    )
    """

    testMetaItemsArray += "testMetaItem_\(counter), "

    testDataFile += data + "\n\n"

    counter += 1
}

testMetaItemsArray += "]"

// 将所有MetaItem整合在一起
testDataFile += testMetaItemsArray + "\n\n"

// 添加Swift Flag
testDataFile = "#if DEV\n\n" + testDataFile + "#endif\n\n"

// 添加操作提示
testDataFile += "//复制log、粘贴到项目、删掉最后一行、格式化"

print(testDataFile)
