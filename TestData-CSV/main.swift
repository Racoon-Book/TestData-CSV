import CSV
import Foundation

let path = "/Users/yangxijie/Desktop/CCCC 语音记账/PROJECT/TestData-CSV/导出 数据集.csv"

let stream = InputStream(fileAtPath: path)!
let csv = try! CSVReader(stream: stream, hasHeaderRow: true)

let headerRow = csv.headerRow!
// print("\(headerRow)")

var counter: Int = 1
var command = "let testMetaItems: [MetaItem] = ["

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

    command = command + "testMetaItem_\(counter), "

    print(data)
    print()

    counter = counter + 1
}

command = command + "]"

print(command)
