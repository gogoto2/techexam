//
//  ModelGeneratorHelper.swift
//  technicalexamTests
//
//  Created by iOS on 10/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

@testable import technicalexam

func generateDeliveryModel() -> Delivery {
    let sender = Sender(phone: "9999999",
                        name: "mark",
                        email: "mark@gmail.com")
    
    let route = Route(start: "Metro Manila",
                           end: "Legazpi City")
    
    let delivery = Delivery(id: "#000000",
                            remarks: "a remrk",
                            pickupTime: "2018-11-22T07:06:05-08:00",
                            goodsPicture: "https://loremflickr.com/320/240/cat?lock=28542",
                            deliveryFee: "$1",
                            surcharge: "$20",
                            route: route,
                            sender: sender,
                            uuid: "1234")
    return delivery
}
