//
//  ModelMain.swift
//  MenuApp
//
//  Created by macbook on 07.06.2023.
//

import RealmSwift

class ModelMain: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?, rating: Double) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
        self.rating = rating
    }
}

enum PresentStyle: Int, CaseIterable {
    case folder = 0
    case words = 1
    
    var text: String {
        get {
            switch self {
            case .folder:
                return "Date"
            case .words:
                return "Name"
            }
        }
    }
}
