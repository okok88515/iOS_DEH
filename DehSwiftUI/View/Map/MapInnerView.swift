//
//  DEHMapInner.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2021/3/5.
//  Copyright © 2021 mmlab. All rights reserved.
//
//used for
import SwiftUI
import MapKit
struct DEHMapInner: View {
    var Xoi:XOI
    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var settingStorage:SettingStorage
//    @State var selection: Int? = nil
    @State var showingAlert = false
    var xoiCategory = ""
    
    var body: some View {
        Map(coordinateRegion: $locationManager.coordinateRegion, annotationItems: Xoi.containedXOIs ?? testxoi){ xoi in
            MapAnnotation(
                coordinate: xoi.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                NavigationLink(destination: destinationSelector(xoi:xoi), label: {
                    VStack{
                        Text(xoi.name)
                        //還沒把index收下來
                        pinSelector(number:xoi.index ?? 0,xoiCategory:xoiCategory)
                    }
                })
            }
        }
        .onAppear(
            perform: {
                locationManager.setToXoiLocation(xoi: (Xoi.containedXOIs ?? testxoi)[0])
            }
        )
        .overlay(
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
        )
        .toolbar(content: {
            ToolbarItem {
                Button {
                    print("favorite pressed")
                    // if exist then remove or not exist then add
                    if let index = settingStorage.XOIs["favorite"]?.firstIndex(of: Xoi){
                        settingStorage.XOIs["favorite"]?.remove(at: index)
                    }
                    else{
                        settingStorage.XOIs["favorite"]?.append(Xoi)
                        showingAlert = true
                    }
                } label: {
                    Image("heart")
                }
            }
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Add to favorite".localized))
        }
        
        
    }
}

extension DEHMapInner{
    @ViewBuilder func destinationSelector(xoi:XOI) -> some View{
        switch xoi.xoiCategory {
        case "poi": XOIDetail(xoi:xoi)
        case "loi": DEHMapInner(Xoi: xoi,locationManager: locationManager, xoiCategory: xoi.xoiCategory)
            
        case "aoi": DEHMapInner(Xoi: xoi, locationManager: locationManager,xoiCategory: xoi.xoiCategory)
        case "soi": DEHMapInner(Xoi: xoi,locationManager: locationManager,xoiCategory: xoi.xoiCategory)
        default:
            Text("error")
        }
    }
    @ViewBuilder func pinSelector(number:Int,xoiCategory:String) -> some View{
        switch xoiCategory {
        case "poi": Image("player_pin")
        case "loi": ImageWithNumber(number: number)
        case "aoi": Image("player_pin")
        case "soi": ImageWithNumber(number: number)
        default:
            Text("error")
        }
    }
}

//struct DEHMapInner_Previews: PreviewProvider {
//    static var previews: some View {
//        DEHMapInner(xois: testxoi)
//    }
//}
