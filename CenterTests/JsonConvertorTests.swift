//
//  JsonConvertorTests.swift
//  CenterTests
//
//  Created by hancock on 2019/9/19.
//  Copyright © 2019 Thoughtworks. All rights reserved.
//

import XCTest
@testable import Center

class JsonConvertorTests: XCTestCase {

    func testShouldGetDic_whenConvert_givenCodableObject() {
        
        let weekplan = aWeekplan()
        let dic = JSONConvertor.objectToDic(object: weekplan)
        
        assert(dic?["id"] as? String == aWeekplan().id)
        assert(dic?["weekNum"] as? Int == aWeekplan().weekNum)
        assert(dic?["content"] as? String == aWeekplan().content)
        assert(dic?["award"] as? String == aWeekplan().award)
        assert(dic?["punishment"] as? String == aWeekplan().punishment)
    }
    
    func testShouldGetObject_whenConvert_givenData() {
        let data = weekplanData()
        let weekplan: Weekplan? = JSONConvertor.dataToObject(data: data)
        assert(weekplan?.id == "id")
        assert(weekplan?.weekNum == 30)
        assert(weekplan?.content == "content")
        assert(weekplan?.award == "award")
        assert(weekplan?.punishment == "punishment")
    }
    
    func testShouldGetString_whenConvert_givenStringData() {
        let data = stringData()
        let finalString: String? = JSONConvertor.dataToObject(data: data)
        assert(finalString == "test string")
    }
    
    func testShouldGetNull_whenConvert_givenString() {
        let string = "test string"
        let dic = JSONConvertor.objectToDic(object: string)
        assert(dic == nil)
    }
    
    private func aWeekplan() -> Weekplan {
        let weekplan = Weekplan()
        weekplan.id = "id"
        weekplan.weekNum = 30
        weekplan.content = "content"
        weekplan.award = "award"
        weekplan.punishment = "punishment"
        return weekplan
    }
    
    private func weekplanData() -> Data? {
        let weekplan = aWeekplan()
        return try? JSONEncoder().encode(weekplan)
    }
    
    private func stringData() -> Data? {
        let string = "test string"
        return string.data(using: String.Encoding.utf8)
    }

}

private class Weekplan: NSObject, Codable {
    var id: String?
    
    var weekNum: Int?
    
    var content: String?
    
    var award: String?
    
    var punishment: String?
    
    override var description: String {
        return "id: \(id ?? "null"), weekNum: \(weekNum ?? 0), content: \(content ?? "null"), award: \(award ?? "null"), punishment: \(punishment ?? "null")"
    }
}
