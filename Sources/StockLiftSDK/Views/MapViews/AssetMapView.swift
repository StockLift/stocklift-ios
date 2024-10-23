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
    let annotations: [AssetCoordinates]
    let missingSymbols: Int
    let usersAssets: [GeoAssetsData]
    @Binding var date: String
    @Binding var hasCostBasis: Bool
    
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
            Text("Geographic Diversification")
                .appFontRegular()
                .padding(.top)
            
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
                            .appFontMedium(size: 8, color: .white)
                    }
                }
            }
            .frame(width: self.rect.width * 0.8, height: 300)
            .padding(8)
            
//            if self.isDev() {
//                Text("Missing Assets: \(missingSymbols)")
//                    .appFontMedium(size: 10)
//            }
            
            NavigationLink {
                MapViewDetails(geoVM: GeoAssetViewModel(usersAssets: usersAssets),
                               date: $date,
                               hasCostBasis: $hasCostBasis,
                               updateCostBasisAction: updateCostBasisAction)
            } label: {
                Text("View by Region")
                    .appFontMedium(color: .yellow)
                    .padding(.bottom)
            }

        }
        .makeCardLayer()
    }
    
    private func updateCostBasisAction(_ symbol: String, value: Float) {
        DetailsViewModel.updateCostBasis(symbol: symbol, value: value)
    }
}

