# SwiftCache

  `SwiftCache` is a data structure for Least Recently Used (LRU) image cache. 
  
  ```
  A doubly linked linear list + hashTable of pointers to the linked list items  
  
  Illustration of the design:
 
  <----------------------------------- Queue ------------------------------------>
 
  (MRU)item                 item                    item                  (LRU)item 
   ______                  ______                  ______                  ______
  | head | older(next) => |      | older(next) => |      | older(next) => | tail |
  |  A   |                |  B   |                |  C   |                |  D   |
  |______| <= newer(prev) |______| <= newer(prev) |______| <= newer(prev) |______|
  
  added  -->  -->  -->  -->  -->  -->  -->  -->  -->  -->  --> -->  -->  --> removed
  ```

# Installation
#### CocoaPods

coming soon

#### Manually
Just drag and drop the `SwiftCache.swift` file in the `SwiftCache` folder into `your project`.


# Usage

### New (maxCount:Int)

```swift
var cache = SwiftCache<String, UIImage>() // The default is 10
or 
var cache = SwiftCache<String, UIImage>(maxCount: 5)
```

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

/*
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

# Tests
Open the Xcode project and press `⌘-U` to run the tests.



