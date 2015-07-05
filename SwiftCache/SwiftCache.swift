//
//  SwiftCache.swift
//  SwiftCache
//
//  Created by nixnoughtnothing on 7/4/15.
//  Copyright (c) nix nought nothing All rights reserved.
//



/**
*   - A data structure for LRU Cache written in Swift -
*
*   A doubly linked linear list + hashTable of pointers to the linked list items
*
*   Illustration of the design:
*
*      <----------------------------------- Queue ------------------------------------>
*
*        item                    item                    item                    item
*       ______                  ______                  ______                  ______
*      | head | older(next) => |      | older(next) => |      | older(next) => | tail |
*      |  A   |                |  B   |                |  C   |                |  D   |
*      |______| <= newer(prev) |______| <= newer(prev) |______| <= newer(prev) |______|
*
*      added  -->  -->  -->  -->  -->  -->  -->  -->  -->  -->  --> -->  -->  --> removed
*/

import Foundation
import UIKit


// MARK: - Item Class -
class Item<Key,UIImage> {
    var next:Item? // tail side
    var previous:Item? // head side
    var key:Key
    var value:UIImage?
    
    // initialize
    init(key:Key,value: UIImage?){
        self.key = key
        self.value = value
    }
}


// MARK: - Queue(LinkedList) Class -
class Queue<Key, Value> {
    
    var head: Item<Key,UIImage>? //== MRU(Most Recently Used Item)
    var tail: Item<Key,UIImage>? //== LRU(Least Recently Used Item)
    
    
    // initialize
    init(){
    }
    
    
    // MRU Itemをheadに持ってくるメソッド
    func addToHead(mruItem:Item<Key,UIImage>){
        
        if head == nil  {
            head = mruItem
            tail = mruItem
        }else{
            var temp = head
            head = mruItem
            head!.next = temp
            head!.next?.previous = mruItem
        }
    }
    
    
    // 削除予定itemが存在する場合のみこのメソッドをcallする
    func removeItemLink(item:Item<Key,UIImage>){
        
        if head === item{
            
            if head?.next != nil{
                head = head?.next
                head?.previous = nil
            }else{
                head = nil
                tail = nil
            }
        }else if tail === item{
            
            tail?.previous?.next = nil
            tail = tail?.previous
        }else {
            // 「A,item,C」の順で要素があり、Aのnext(=item)にCを代入し、itemへのリンクをなくす
            item.previous?.next = item.next
            
            // 「A,item,C」の順で要素があり、Cのprevious(=item)にAを代入し、itemへのリンクをなくす
            item.next?.previous = item.previous
        }
    }
}



// MARK: - Main Class -
class SwiftCache<Key:Hashable,Value> {
    

    
    var maxCount:Int  // MAXINUM Limit(Cached Item)
    var itemCount = 0 // Number of Cached Item
    private let queue: Queue<Key, Value>
    private var hashTable: [Key : Item<Key, UIImage>] // Dictionary Type
    
    
    init(maxCount:Int = 10){
        self.maxCount = maxCount
        self.queue = Queue()
        // minimuCapacityの要素数を上限に辞書型インスタンスを生成し、変数hashTableに代入
        self.hashTable = [Key : Item<Key, UIImage>](minimumCapacity: self.maxCount)
    }
    
    
    
    // Set(ImagefromURL)
    func set(key:Key,urlString:String) -> UIImage?{
        if let imageUrl = NSURL(string: urlString) {
            if let data = NSData(contentsOfURL: imageUrl){
                var image = UIImage(data: data)
                if image != nil{
                    setImage(key, value: image!)
                }
            }
            return nil
        }
        return nil
    }
    
    
    func setImage(key:Key,value:UIImage){
        // Update the value of item with <key> and Move towards the head
        if var item = hashTable[key]{
            
            item.value = value
            
            self.queue.removeItemLink(item)
            self.queue.addToHead(item)
            
            // Set new cache
        }else{
            var item = Item(key: key,value: value)
            
            
            if maxCount > itemCount{
                
                self.queue.addToHead(item)
                self.hashTable[key] = item
                self.itemCount++
            }else{
                
                // Remove LRU cache
                println("Removed cachedItem: key=>\(self.queue.tail!.key) \n")
                self.hashTable.removeValueForKey(self.queue.tail!.key)
                self.queue.tail = self.queue.tail!.previous
                if var tailItem = self.queue.tail{
                    tailItem.next = nil
                }
                // Add MRU new cache
                self.queue.addToHead(item)
                self.hashTable[key] = item
            }
            
        }
    }
    
    // get a value by key
    func get(key:Key)->UIImage?{
        // Find our cached item
        if let item = self.hashTable[key] {
            println(item.value)
            self.queue.removeItemLink(item)
            self.queue.addToHead(item)
            return item.value
        } else {
            // Not cached.
            return nil
        }
    }
    
    
    
    
    // ----------------------------------------------------------------------------
    // Following code is optional and can be removed without breaking the core
    // functionality.

    
    // removeAll
    func removeAll(){
        
        var current = self.queue.head
        
        while current != nil {
            current?.previous = nil
            current = current?.next
            current?.previous?.next = nil
        }
        
        self.queue.head = nil
        self.queue.tail = nil
        
        self.hashTable.removeAll()
        self.itemCount = 0
    }
    
    func display() -> String {
        var description = "------ Current Cached Items ------- \n\n"
        var current = self.queue.head
        
        description += "---Head--- \n"
        while current != nil {

            description += "Key: \(current!.key), Value: \(current!.value) \n"
            current = current?.next
        }
        description += "---Tail--- \n"
        
        return description
    }
    
// TODO:getAllする場合、要素の順番がLRU順になっていないので、要修正
//    func getAll() -> [Key:UIImage] {
//        
//        var cachedImages = [Key:UIImage]()
//        var current = self.queue.head
//        
//        while current != nil {
//            
//            cachedImages[current!.key] = current!.value
//            current = current?.next
//        }
//        return cachedImages
//    }
//    
    // TODO: 1) toJSON(), 2) multiThread,
}