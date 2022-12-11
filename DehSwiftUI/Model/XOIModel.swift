/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The model for an individual landmark.
 */

import SwiftUI
import CoreLocation

// get set : 讀／寫
//protocol XOIProtocol:Identifiable {
//    var id: Int{get set}
//    var name: String{get set}
//    var latitude: Double{get set}
//    var longitude: Double{get set}
//    var creatorCategory: String{get set}
//    var xoiCategory: String{get set}
//    var detail: String{get set}
//    var viewNumbers: Int{get set}
//    var mediaCategory: String{get set}
//    func getLocationCoordinate()-> CLLocationCoordinate2D
//}

import MapKit
class XOIList:Decodable{
    let results: [XOI]
}
struct media_set:Codable{
    var media_type:String
    var media_format:Int
    var media_url:String
//    var foreignKey:Int
}


class XOI:Identifiable,Decodable {

    var containedXOIs:[XOI]?
    var id: Int = 0
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var creatorCategory: String = ""
    var xoiCategory: String = ""
    var detail: String = ""
    var viewNumbers: Int = 0
    var mediaCategory: String = ""
    var distance: Double = 0.0
    var media_set: [media_set]!
    var open: Bool = false
    var index: Int? = -1
    var coordinate:CLLocationCoordinate2D!{
        get{
            return CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude)
        }
    }
    enum CodingKeys: String, CodingKey{
        case id = "XOI_id"
        case name = "XOI_title"
        case detail = "XOI_description"
        case media_set = "media_set"
        case creatorCategory = "identifier"
        case xoiCategory
        case mediaCategory = "mediaCategory"
        case open
        case containedXOIs = "containedXOIs"
        case latitude
        case longitude
        case index
//        case viewNumbers
    }
    init(id: Int,name: String,latitude: Double,longitude: Double,creatorCategory: String,xoiCategory: String,detail: String,viewNumbers: Int,mediaCategory: String){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.creatorCategory = creatorCategory
        self.xoiCategory = xoiCategory
        self.detail = detail
        self.viewNumbers = viewNumbers
        self.mediaCategory = mediaCategory
    }
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.ContainedXOIs = try container.decode([XOI].self, forKey: .ContainedXOIs)
//    }
    
}

extension XOI:Hashable,Encodable{
    static func == (lhs: XOI, rhs: XOI) -> Bool {
        return lhs.id == rhs.id && lhs.xoiCategory == rhs.xoiCategory
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func region() -> MKCoordinateRegion{
        return MKCoordinateRegion(center: coordinate, latitudinalMeters:20000,longitudinalMeters:20000)
    }
    
    func setContainedXOI(XOIs:[XOI]){
        self.containedXOIs = XOIs
    }
}






