//
//  ModelMain.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import Foundation

struct ModelMain {
    var name: String
    var location: String
    var type: String
    var image: String
    
  static  let restaurantNames = [
         "Kitchen", "Bonsai", "Вкусочка", "Индокитай", "Sultan Burger", "Speak Easy", "Классик", "Националь", "Вкусные истории", "Асса", "Рандеву"]
    
   static func getPlaces() -> [ModelMain] {
        var placesModel = [ModelMain]()
        
        for places in restaurantNames {
            placesModel.append(ModelMain(name: places, location: "Moscow", type: "Restorant", image: places))
        }
        
        return placesModel
    }
}
