//
//  XOIDetail.swift
//  DehSwiftUI
//
//  Created by 阮盟雄 on 2020/12/2.
//  Copyright © 2020 mmlab. All rights reserved.


import SwiftUI
import Alamofire
import Combine
import CryptoKit
import MapKit
struct XOIDetail: View {
    var xoi: XOI
    //only for favorite used
    @EnvironmentObject var settingStorage:SettingStorage
    @State var viewNumbers = -1
    @State private var cancellable: AnyCancellable?
    @State private var cancellable2: AnyCancellable?
    @State private var mediaCancellable: [AnyCancellable] = []
    //    @State private var images:[UIImage] = []
    @State private var medias:[MediaMulti] = []
    @State private var commentary:MediaMulti = MediaMulti(data: Data(), format: .Default)
    @State var index = 0
    @State private var showingAlert = false
    @State private var showingShare = false
    @State private var showingSheet = false
    var body: some View{
        ScrollView {
            VStack {
                XOIMediaSelector(xoi: xoi)
                    .frame(height: 400.0)
                
                VStack(alignment: .leading) {
                    HStack(){
                        Text(xoi.name)
                            .font(.title)
                        Spacer()
                        Image(xoi.creatorCategory)
                        
                        Button(action: {
                            print("favorite pressed")
                            // if exist then remove or not exist then add
                            if let index = settingStorage.XOIs["favorite"]?.firstIndex(of: xoi){
                                settingStorage.XOIs["favorite"]?.remove(at: index)
                            }
                            else{
                                settingStorage.XOIs["favorite"]?.append(xoi)
                                showingAlert = true
                            }
                        }) {
                            Image("heart")
                            
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Add to favorite".localized))
                        }
                        
                        Button(action: {
                            print("more pressed")
                            showingSheet = true
                        }) {
                            Image("more")
                        }
                        .actionSheet(isPresented: $showingSheet) {
                            ActionSheet(title: Text("Select more options".localized), message: Text(""), buttons: [
                                .default(Text("Guide to POI".localized)) {
                                    navigatedAction()
                                },
                                .cancel()
                            ])
                        }
                    }
                    HStack {
                        Text("Voice Commentary")
                            .foregroundColor(Color.white)
                        Spacer()
                        commentary.view()
                    }
                    .frame(height: 30.0)
                    .background(Color.init(UIColor(rgba:"#24c08c")))
                    Text("View Numbers: " + String(viewNumbers).hidden(viewNumbers == -1))
                    Text(xoi.detail)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            getViewerNumber()
            getMedia()
            addPoiCount()
        }
        .navigationBarItems(trailing: Button {
            self.showingShare = true
        } label: {
            Image(systemName: "square.and.arrow.up.on.square.fill")
                .foregroundColor(.blue)
        }
                                .sheet(isPresented: $showingShare, onDismiss: {print("show shareSheet")}, content: {
            ActivityViewController(activityItems: [URL(string: "http://deh.csie.ncku.edu.tw/poi_detail/" + String(xoi.id))!])
        })
        )
        
    }
}
extension XOIDetail{
    @ViewBuilder func XOIMediaSelector(xoi:XOI) -> some View{
        switch xoi.xoiCategory {
        case "poi":
            PagingView(index: $index.animation(), maxIndex: medias.count - 1) {
                ForEach(self.medias, id: \.data) {
                    singleMedia in
                    singleMedia.view()
                }
            }
        case "loi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        case "aoi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        case "soi": DEHMapInner(Xoi: xoi, xoiCategory: xoi.xoiCategory)
        default:
            Text("error")
        }
    }
    
    
    func getViewerNumber(){
        let parameters:Parameters = [
            "poi_id": xoi.id
        ]
        let url = POIClickCountUrl
        let publisher:DataResponsePublisher<ClickCount> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable = publisher.sink(receiveValue: {(values) in
                if let _ = values.value?.count{
                    viewNumbers = values.value?.count ?? -1
                }
                
            })
        }
    func addPoiCount(){
        let parameters:Parameters = [
            "user_id": settingStorage.userID,
            "ip":"127.0.0.1",
            "page":"/API/test/poi_detail/\(xoi.id)"
        ]
        let url = addPoiCountUrl
        let publisher:DataResponsePublisher<Result> = NetworkConnector().getDataPublisherDecodable(url: url, para: parameters)
        self.cancellable2 = publisher
            .sink(receiveValue: {(values) in
                    print(values.value?.result ?? "")
            })
    }
    
    func navigatedAction() {
        let srcLocation = MKMapItem.forCurrentLocation()
        let dst = CLLocationCoordinate2D(latitude: xoi.latitude, longitude: xoi.longitude)
        let dstLocation = MKMapItem.init(placemark: MKPlacemark(coordinate: dst, addressDictionary: nil))
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: [srcLocation, dstLocation], launchOptions: options)
    }
    //set media data in place
    func getMedia(){
        
        //        let format = [
        //            "Commentary": 8,
        //            "Video": 4,
        //            "Voice": 2,
        //            "Picture": 1,
        //        ]
        if let _ = xoi.media_set{
            //
            for (_,media) in xoi.media_set.enumerated(){
                if media.media_format == 0 || media.media_type == ""{
                    medias = [MediaMulti(data: UIImage(imageLiteralResourceName: "none").pngData() ?? Data(), format: format.Picture)]
                    continue
                }
                let url = media.media_url
                let publisher:DataResponsePublisher = NetworkConnector().getMediaPublisher(url: url)
                
                //            self.mediaCancellable[index] = publisher
                let cancelable = publisher
                    .sink(receiveValue: {(values) in
                        if let formatt = format(rawValue: media.media_format){
                            if let data = values.data{
                                switch formatt{
                                case format.Commentary:
                                    self.commentary = MediaMulti(data:data,format: formatt)
                                case .Video:
                                    fallthrough
                                case .Voice:
                                    fallthrough
                                case .Picture:
                                    medias.append(MediaMulti(data:data,format: formatt))
                                case .Default:
                                    print("default")
                                }
                                
                            }
                        }
                        //                    print(values.data?.JsonPrint())
                        switch media.media_format{
                        case format.Commentary.rawValue:
                            print("Commentary")
                        case format.Video.rawValue:
                            print("Video")
                        case format.Voice.rawValue:
                            print("Voice")
                        case format.Picture.rawValue:
                            print("Picture")
                            //                        print(values.debugDescription)
                            //                        images.append(UIImage(data: values.data ?? Data()) ?? UIImage())
                        default:
                            print()
                        }
                        //                    self.mediaCancellable?.cancel()
                        
                        
                    })
                self.mediaCancellable.append(cancelable)
                //
            }
        }
        else{
            medias = [MediaMulti(data: UIImage(imageLiteralResourceName: "none").pngData() ?? Data(), format: format.Picture)]
            //            images = [UIImage(imageLiteralResourceName: "none")]
        }
    }
}
class Result:Decodable {
    var result:String

    init(result:String) {
        self.result = result
    }
}
struct XOIDetail_Previews:
    PreviewProvider {
    static var previews: some View {
        XOIDetail(xoi:testxoi[0])
            .environmentObject(SettingStorage())
    }
}

