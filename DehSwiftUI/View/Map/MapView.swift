//
//  Map.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/3.
//  Copyright © 2020 mmlab. All rights reserved.
//https://swiftwithmajid.com/2020/07/29/using-mapkit-with-swiftui/

import SwiftUI
import MapKit
import Combine
import Alamofire
struct DEHMap: View {
    //use stateobject to avoid renew the variable
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var settingStorage:SettingStorage
    @State var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.997, longitude: 120.221),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State var poiIndex:Int? = nil
    @State var idsIndex:Int = 0
    @State var typesIndex:Int = 0
    @State var formatsIndex:Int = 0
    @State var selection: Int? = nil
    @State var selectSearchXOI = false
    @State private var cancellable: AnyCancellable?
    @State var filterState = false
    @State var showFilterButton = true
    @State var showTitle:Bool = true
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.coordinateRegion, annotationItems: settingStorage.XOIs[settingStorage.mapType] ?? []){xoi in
                MapAnnotation(
                    coordinate: xoi.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    NavigationLink("", tag: settingStorage.XOIs[settingStorage.mapType]?.firstIndex(of: xoi) ?? 0, selection: $selection, destination: {destinationSelector(xoi:xoi)})
                    pin(xoi: xoi, selection: $selection)
                }
            }
            .navigationBarItems(trailing:HStack{
                Button {
                    filterState = true
                } label: {
                    Image("blueFilter")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                    
                }
                .disabled(showFilterButton)
                .hidden(showFilterButton)
                
                Button(action: {
                    print("map_locate tapped")
                    selectSearchXOI = true
                }
                ) {
                    Image("location")
                        .foregroundColor(.blue)
                }
                .actionSheet(isPresented: $selectSearchXOI) {
                    if app == "dehMicro" || app == "sdcMicro"{
                        return ActionSheet(title: Text("Select Search XOIs"), message: Text(""), buttons: [
                            .default(Text("POI".localized)) {
                                searchXOIs(action: "searchNearbyPOI") },
                            .cancel()
                        ])
                    }
                    else {
                        return ActionSheet(title: Text("Select Search XOIs"), message: Text(""), buttons: [
                            .default(Text("POI".localized)) { searchXOIs(action: "searchNearbyPOI") },
                            .default(Text("LOI".localized)) { searchXOIs(action: "searchNearbyLOI") },
                            .default(Text("AOI".localized)) { searchXOIs(action: "searchNearbyAOI") },
                            .default(Text("SOI".localized)) { searchXOIs(action: "searchNearbySOI") },
                            .cancel()
                        ])
                    }
                }
            })
            .overlay(
                ZStack{
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Image("sniper_target")
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        HStack{
                            Button(action: {
                                print("gps tapped")
                                locationManager.updateLocation()
                            }) {
                                Image("gps")
                            }
                            .padding(.leading, 10.0)
                            Spacer()
                            Button(action: {
                                print("alert tapped")
                            }) {
                                Image("alert")
                            }
                            .padding(.trailing, 10.0)
                        }
                        .padding(.bottom,30.0)
                    }
                }
            )
            if filterState{
                FilterView(idsIndex: $idsIndex, typesIndex: $typesIndex, formatsIndex: $formatsIndex, myViewState: $filterState, locationManager: locationManager)
            }
        }
        .onAppear {
            if settingStorage.XOIs["nearby"] != [] && settingStorage.mapType == "nearby" {
                showFilterButton = false
            }
        }
    }
}

extension DEHMap{
    func searchXOIs(action:String){
        print("User icon pressed...")
        print(locationManager.coordinateRegion.center.latitude)
        let parameters:[String:String] = [
            "username": "\(settingStorage.account)",
            "lat" :"\(locationManager.coordinateRegion.center.latitude)",
            "lng": "\(locationManager.coordinateRegion.center.longitude)",
            "dis": "\(settingStorage.searchDistance * 1000)",
            "num": "\(settingStorage.searchNumber)",
            "coi_name": coi,
            "action": action,
            "user_id": "\(settingStorage.userID)",
            "password":"\(settingStorage.password)",
            "language":"中文"
        ]
        let url = getNearbyXois[action] ?? ""
        let publisher:DataResponsePublisher<XOIList> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher
            .sink(receiveValue: {(values) in
                self.settingStorage.XOIs["nearby"] = values.value?.results
                print(locationManager.coordinateRegion.center.latitude)
                self.settingStorage.mapType = "nearby"
            })
        if action == "searchNearbyPOI"{
            showFilterButton = false
        }
        else{
            showFilterButton = true
        }
    }
    @ViewBuilder func destinationSelector(xoi:XOI) -> some View{
        switch xoi.xoiCategory {
        case "poi": XOIDetail(xoi:xoi)
        case "loi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        case "aoi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        case "soi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        default:
            Text("error")
        }
    }
}
struct pin:View{
    @EnvironmentObject var settingStorage:SettingStorage
    var xoi:XOI
    @Binding var selection:Int?
    @State var showTitle = true
    let mapping = ["user":"player_pin","expert":"expert_pin","docent":"docent_pin"]
    var body: some View {
        VStack(spacing:0){
            Button {
                self.selection = settingStorage.XOIs[settingStorage.mapType]?.firstIndex(of: xoi)
            } label: {
                HStack {
                    Text(xoi.name)
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                }
                
            }
            .padding(10)
            .background(Color(.white))
            .cornerRadius(10)
            .hidden(showTitle)
            .disabled(showTitle)
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .offset(x: 0, y: -5)
                .opacity(showTitle ? 0 : 1)
            Image(mapping[xoi.creatorCategory] ?? "user_pin")
                .onTapGesture {
                    withAnimation(.easeInOut){
                        showTitle.toggle()
                    }
                }
        }
        
    }
}
struct DEHMap_Previews: PreviewProvider {
    static var previews: some View {
        DEHMap()
            .environmentObject(SettingStorage())
    }
}
