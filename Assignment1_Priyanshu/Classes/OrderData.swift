//
//  OrderData.swift
//  Assignment1_Priyanshu
//
//  Created by Priyanshu Kaushik on 2025-03-20.
//

import UIKit

class OrderData: NSObject {
    
    var id:Int?
    var deliveryDate:String?
    var address:String?
    var size:Int?
    var meatToppings:String?
    var vegToppings:String?
    var avatar:String?
    
    
    //constructor
    func initWithOrdersData(theRow i:Int, thedeliveryDate d:String, theaddress a:String, thesize s:Int, themeatToppings m: String, thevegToppings v: String, theavatar av: String){
        
        id=i
        deliveryDate=d
        address=a
        size=s
        meatToppings=m
        vegToppings=v
        avatar=av
    }
    
    
    
    }
    
    
    


