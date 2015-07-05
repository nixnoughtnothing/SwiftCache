# SwiftCache

  `SwiftCache` is a data structure for Least Recently Used (LRU) image cache. 
  
  A doubly linked linear list + hashTable of pointers to the linked list items  
  When you need to remove a value from the cache, you remove from the tail end.  
  When you add a value to cache, you just place it at the head of the LinkedList(Queue).  

# Usage

### Set(Key, imageUrlString)
Adds the specified item to the cache with the specified key and imageUrlString
```swift 
cache.set("foo", urlString: "https://foo/foo.png")
```

### Get(Key)
Return an item if exists, otherwise returns `nil`
```swift 
cache.get("foo") //=> <UIImage: 0x7f97a8799b20>, {100, 100}
```

### Display

```swift 
println(cache.display()) 

/*=>
------ Current Cached Items ------- 

---Head--- 
Key: foo, Value: Optional(<UIImage: 0x7f97a8799b20>, {100, 100}) 
Key: bar, Value: Optional(<UIImage: 0x7f97a8792f10>, {100, 100}) 
---Tail--- 
*/
```

### RemoveAll
Removes all items from the cache.
```swift 
cache.removeAll()
```

### Number of cached Items
Returns the number of items in the cache.
```swift 
cache.itemCount //=> e.g. 3
```


### Maximum number of cached Items

```swift 
cache.maxCount //=> e.g. 10
```




