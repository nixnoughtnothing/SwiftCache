# SwiftCache
`SwiftCache` is a data structure for Least Recently Used (LRU) image cache.

# Usage

### Set(Key,imageUrlString)

```swift 
cache.set("foo", urlString: "https://foo/foo.png")
```

### Get(Key)

```swift 
cache.get("foo") //=> <UIImage: 0x7f97a8799b20>, {100, 100}
```

### Display

```swift 
println(cache.display()) //=> 
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




