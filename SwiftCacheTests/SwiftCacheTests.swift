//
//  SwiftCacheTests.swift
//  SwiftCacheTests
//
//  Created by nixnoughtnothing on 7/3/15.
//  Copyright (c) 2015 Sttir Inc. All rights reserved.
//

import UIKit
import XCTest
import SwiftCache

class SwiftCacheTests: XCTestCase {
    
    var cache = SwiftCache<String, UIImage>()
    
    override func setUp() {
        cache = SwiftCache<String, UIImage>()
        cache.removeAll()
        super.setUp()
    }
    
    override func tearDown() {
        cache.removeAll()
        super.tearDown()
    }
    
    
    func testGetterAndSetter(){
        let nilCache = cache.get("unavailable")
        XCTAssertNil(nilCache, "Get nil Cache")
        
        cache.set("hoge",urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        XCTAssertNotNil(cache.get("hoge"), "Get non-nil object")
    }
    
    func testRemoveLRU(){
        cache.set("item1", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item2", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item3", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("item4", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item5", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item6", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("item7", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item8", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item9", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("item10", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item11", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        
        XCTAssertNil(cache.get("item1"), "items1 should be removed")
        XCTAssertEqual(cache.queue.tail!.key, "item2", "tail => item2")
        println(cache.display())
        
        cache.get("item5")
        cache.get("item2")
        cache.set("item12", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        XCTAssertNil(cache.get("item3"), "items3 should be removed")
        XCTAssertEqual(cache.queue.tail!.key, "item4", "tail => item4")
        XCTAssertNil(cache.queue.tail!.next, "item4(tail).next should be nil")
        XCTAssertEqual(cache.queue.tail!.previous!.key,"item6", "item4(tail).previous should be item6")
        
        XCTAssertEqual(cache.queue.head!.key, "item12", "head => item12")
        XCTAssertEqual(cache.queue.head!.next!.key, "item2", "head.next => item2")
        XCTAssertNil(cache.queue.head!.previous,  "item12(head).previous should be nil")
        println(cache.display())
    }
    
    
    func testMaxCount(){
        XCTAssertNotNil(cache.maxCount, "Get non-nil object")
        XCTAssertEqual(cache.maxCount, 10, "maxCount: 10")
        
        var cache2 = SwiftCache<String, UIImage>(maxCount: 5)
        XCTAssertNotNil(cache2.maxCount, "Get non-nil object")
        XCTAssertEqual(cache2.maxCount, 5, "maxCount: 5")
    }
    
    func testItemCount(){
        XCTAssertNotNil(cache.itemCount, "Get non-nil object")
        XCTAssertEqual(cache.itemCount, 0, "itemCount: 0")
        
        cache.set("item1", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item2", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item3", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        XCTAssertEqual(cache.itemCount, 3, "itemCount: 3")
        
        cache.set("item4", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item5", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item6", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("item7", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("item8", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("item9", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("item10", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        
        XCTAssertEqual(cache.itemCount, 10, "itemCount: 10")
        
        cache.set("item11", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        XCTAssertEqual(cache.itemCount, 10, "itemCount: 10")
    }
    
    
    func testRemoveAll() {
        cache.set("remove1", urlString:"http://dic.nicovideo.jp/oekaki/256231.png")
        cache.set("remove2", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("remove3", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        XCTAssertNotNil(cache.get("remove1"), "Get non-nil object")
        XCTAssertNotNil(cache.get("remove2"), "Get non-nil object")
        XCTAssertNotNil(cache.get("remove3"), "Get non-nil object")
        println(cache.itemCount)
        
        cache.removeAll()
        
        XCTAssertNil(cache.get("remove1"), "Get deleted object")
        XCTAssertNil(cache.get("remove2"), "Get deleted object")
        XCTAssertNil(cache.get("remove3"), "Get deleted object")
        println(cache.itemCount)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}