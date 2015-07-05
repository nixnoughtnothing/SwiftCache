//
//  ViewController.swift
//  SwiftCache
//
//  Created by nixnoughtnothing on 7/3/15.
//  Copyright (c) nixnoughtnothing All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create
        var cache = SwiftCache<String, UIImage>() // or (maxCount: Int)
        
        // Set
        cache.set("A", urlString:"http://img2.wikia.nocookie.net/__cb20121108015014/thesimssocial/images/2/21/Ruby-(item).png" )
        cache.set("B", urlString:"http://img2.wikia.nocookie.net/__cb20121108015014/thesimssocial/images/2/21/Ruby-(item).png")
        cache.set("C", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("D", urlString:"http://www.richasi.com/Cirque/Projects/full/figure5.png")
        cache.set("E", urlString:"https://www.leanplum.com/static/landing/images/chrome.png")
        cache.set("F", urlString:"http://a1.mzstatic.com/us/r30/Purple7/v4/77/f6/7a/77f67acf-e7b3-d526-3c17-f620d60aa415/icon100x100.png")
        cache.set("G", urlString:"http://www.kic.org.uk/pathways/wp-content/themes/kic-corp-en-2013/includes/langselector/uk.png")
        cache.set("H", urlString:"http://daqri.com/content/uploads/2014/01/cnet.png")
        cache.set("I", urlString:"http://petapixel.com/assets/images/icon-fb.png")
        cache.set("J", urlString:"http://www.panoramas.com/media/category/college/BYU.png")
        cache.set("K", urlString:"http://a1.mzstatic.com/us/r30/Purple7/v4/76/9b/0c/769b0ced-cc38-ecad-58b3-3b6e6da23607/icon100x100.png")
        cache.set("L", urlString:"http://www.olympic.org/Global/Images/Olympic%20Games/winter/1994-lillehammer/logo-lillehammer1994.png")

        // Get
        if let item = cache.get("G") {
            println("Item [G] =>Value: \(item)")
        } else {
            println("Item [G] doesn't exist")
        }
        
        // Display
        println(cache.display())
        
        
        // ItemCount & MaxCount
        println("CurrentItemCount: \(cache.itemCount) / maxCount: \(cache.maxCount) \n")
        
        // RemoveAll
        cache.removeAll()
        
        // Display
        println(cache.display())
        
        // ItemCount & MaxCount
        println("CurrentItemCount: \(cache.itemCount) / maxCount: \(cache.maxCount) \n")
        
        // Set
        cache.set("M",urlString:"http://img2.wikia.nocookie.net/__cb20121108015014/thesimssocial/images/2/21/Ruby-(item).png")
        
        // Display
        println(cache.display())
        
        // Get
        println(cache.get("A"))
        println(cache.get("B"))
        println(cache.get("C"))
        println(cache.get("D"))
        println(cache.get("E"))
        println(cache.get("F"))
        println(cache.get("G"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

