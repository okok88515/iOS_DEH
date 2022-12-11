//
//  LocationManager.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/22.
//  Copyright © 2020 mmlab. All rights reserved.
//
//https://stackoverflow.com/questions/57681885/how-to-get-current-location-using-swiftui-without-viewcontrollers
//subjects
//https://stackoverflow.com/questions/60482737/what-is-passthroughsubject-currentvaluesubject

import SwiftUI
import CoreLocation
import Combine
import MapKit
class LocationManager: NSObject, ObservableObject {
    var listeningOnce:Int = 0
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            coordinateRegion = MKCoordinateRegion(center:CLLocationCoordinate2D(
                                                    latitude: lastLocation?.coordinate.latitude ?? 23.58_323, longitude: lastLocation?.coordinate.longitude ?? 121.58_260),span:MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            objectWillChange.send()
        }
    }
    @Published var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.997, longitude: 120.221),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.locationStatus = status
//        print(#function, statusString)
//    }
    // up is old version
    //seems not essentially to do now
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        self.locationStatus = manager.authorizationStatus 
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        if(location.horizontalAccuracy > 0 && listeningOnce > 0){
            listeningOnce -= 1
            if(listeningOnce == 0){
                self.locationManager.stopUpdatingLocation()
            }
        }
        print(#function, location)
    }
    
    func startUpdate(){
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdate(){
        self.locationManager.stopUpdatingLocation()
    }
    
    func updateLocation(){
        //避免浪費電，如果只開一次會無法更新
        self.locationManager.startUpdatingLocation()
        listeningOnce = 3
    }
    
    func setToXoiLocation(xoi:XOI)-> Void{
        self.coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: xoi.latitude, longitude: xoi.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        objectWillChange.send()
    }
    func getDistanceFromCurrentPlace(coordinate:CLLocationCoordinate2D) -> Double{
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let currentLatitude = self.coordinateRegion.center.latitude
        let currentlongitude = self.coordinateRegion.center.longitude
        
        return CLLocation(latitude: currentLatitude, longitude: currentlongitude).distance(from: CLLocation(latitude: latitude, longitude: longitude))
        
    }

}
