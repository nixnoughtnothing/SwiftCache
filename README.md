# SwiftCache
`SwiftCache` is a data structure for Least Recently Used (LRU) image cache.

# Usage

### Set(Key,imageUrlString)

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

```swift 
cache.removeAll()
```

### Number of cached Items

```swift 
cache.itemCount //=> e.g. 3
```


### Maximum number of cached Items

```swift 
cache.maxCount //=> e.g. 10
```




