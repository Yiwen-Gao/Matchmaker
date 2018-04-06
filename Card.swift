//
//  Card.swift
//  Concentration
//
//  Created by Yiwen Gao on 3/13/18.
//  Copyright © 2018 Yiwen Gao. All rights reserved.
//

import Foundation

/* as opp to classes,
 1) classes = ref types, structs = value types
 2) structs no inheritance
 */
struct Card {
    
    private static var idFactory = 0
    var isFaceUp = false
    var isMatched = false
    var id: Int
    
    init() {
        id = Card.getUniqueId()
    }
    
    private static func getUniqueId() -> Int {
        idFactory += 1 //don't need to say Card.idFactory bc it's a static function
        return idFactory
    }
}
