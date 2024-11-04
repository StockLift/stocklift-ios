//
//  AssetMapView.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/1/24.
//  Copyright © 2024 StockLift Inc. All rights reserved.
//

import SwiftUI
import MapKit

@available(iOS 15.0, *)
struct AssetMapView: View {
    @Binding var showDisclaimer: Bool
    @Binding var assetImages: [String: URL]
    let annotations: [AssetCoordinates]
    let usersAssets: [GeoAssetsData]
    let chartHeader: String
    
    @Binding var date: String
    @Binding var hasCostBasis: Bool
    let headerFont: Font
    let headerFontColor: Color
    let subHeaderFont: Font
    let subHeaderFontColor: Color
    let gainColor: Color
    let lossColor: Color
    let assetDefaultColor: Color
    let symbolFont: Font
    let fontColor: Color
    let nameFont: Font
    let assetDetailsHeaderFont: Font
    let assetDetailsBodyFont: Font
    let assetDetailsHighlightColor: Color
    
    @State private var showDetails: Bool = false
    
    /// New York
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.6943, longitude: -73.9249), 
                                                   span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    // iOS 17
//    let position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 40.6943, longitude: -73.9249),
//            span: MKCoordinateSpan(latitudeDelta: 80, longitudeDelta: 80)
//        )
//    )

    var body: some View {
        VStack {
            Text(chartHeader)
                .font(headerFont)
                .foregroundColor(headerFontColor)
                .underline(color: headerFontColor)
                .overlay(alignment: .trailing) {
                    DisclaimerImage(showDisclaimer: $showDisclaimer, headerFontColor: headerFontColor)
                }
                .padding(.bottom)
            
            // iOS 17
//            Map(initialPosition: position, interactionModes: [.rotate, .zoom])
//                .mapStyle(.imagery) {
//                    ForEach(annotations) { location in
//                            Marker(location.name, coordinate: location.coordinate)
//                        }
//                }
            Map(coordinateRegion: $region, annotationItems: annotations) { item in
                MapAnnotation(coordinate: item.coordinate) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 22)
                        Text(item.symbol ?? "n/a")
                            .font(.system(size: 8))
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .padding(6)
            
            Text("View by Region")
                .font(subHeaderFont)
                .foregroundColor(subHeaderFontColor)
                .padding(.bottom)
                .onTapGesture {
                    self.showDetails.toggle()
                }
            
            
        }
        .popover(isPresented: $showDetails) {
            MapViewDetails(
                geoVM: GeoAssetViewModel(usersAssets: usersAssets),
                date: $date,
                hasCostBasis: $hasCostBasis,
                assetImages: $assetImages,
                updateCostBasisAction: updateCostBasisAction,
                gainColor: gainColor,
                lossColor: lossColor,
                assetDefaultColor: assetDefaultColor,
                symbolFont: symbolFont,
                fontColor: fontColor,
                nameFont: nameFont,
                assetDetailsHeaderFont: assetDetailsHeaderFont,
                assetDetailsBodyFont: assetDetailsBodyFont,
                assetDetailsHighlightColor: assetDetailsHighlightColor
            )
        }
    }
    
    private func updateCostBasisAction(_ symbol: String, value: Float) {
//        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
}

