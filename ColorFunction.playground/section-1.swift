// Playground - noun: a place where people can play

import UIKit
import Darwin


var str = "Hello, playground"


func ColorDistance(e1: UIColor,e2: UIColor) -> Int{
    var r1:CGFloat = 0,g1:CGFloat = 0,b1:CGFloat = 0, a1:CGFloat = 0
    var r2:CGFloat = 0,g2:CGFloat = 0,b2:CGFloat = 0, a2:CGFloat = 0
    e1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    e2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    
    let rmean = ( r1 + r2 ) / 2;
    let r = r1 - r2
    let g = g1 - g2
    let b = b1 - b2
    
    var tempR = Int((512+rmean)*r*r) >> 8
    var tempG = Int(4*g*g)
    var tempB = Int((767-rmean)*b*b) >> 8
    
    return (tempR + tempG + tempB)
    
}