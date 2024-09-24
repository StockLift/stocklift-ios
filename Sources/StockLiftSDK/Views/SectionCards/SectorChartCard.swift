//
//  SectorChartCard.swift
//  Stocklift
//
//  Created by Christopher Hicks on 8/21/23.
//  Copyright © 2023 StockLift Inc. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 15.0, *)
struct SectorChartCard: View {
    @ObservedObject var portfolioVM: PortfolioViewModel
    @State private var nullDate = ""
    @State private var nullCostBasis = true
    
    private var screenWidth: Double {
        let screen = UIScreen.main.bounds.width
        let value = screen - 150
        return value
    }
    
    private var dateConnected: Binding<String> {
        $portfolioVM.dateConnected
    }
    
    private var hasCostBasis: Binding<Bool> {
        $portfolioVM.hasCostBasis
    }
    
    private var sectorDetails: [[SectorTotals : [UserEquity]]] {
        portfolioVM.sectorDetails
    }
    
    private var showDetailsButton: Bool {
        return portfolioVM.hasAccountConnected
    }
    
    
    //  Body
    var body: some View {
        VStack {
            TitleView
            
            VStack {
                PortfolioOrLinkAccount
                ViewDetailsButton
                if  !portfolioVM.hasAccountConnected {
                    Spacer()
                }
            }
            Spacer()
        }
        .makeCardLayer()
    }
    
    // Subviews
    private var TitleView: some View {
        VStack(spacing: 4) {
            Text("Diversification by Sector")
                .appFontRegular()
        }
        .padding(.top)
    }
    
    private var PortfolioOrLinkAccount: some View {
        HStack {
            if let entries = portfolioVM.sectorEntries, portfolioVM.hasAccountConnected {
                /// PIE CHART ** SP 500 Sector
                PieChartView(values: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.value },
                             colors: PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS).map { $0.color })
                .frame(width: screenWidth)
                .frame(width: screenWidth / 2)
                .padding(.leading, 4)
                Spacer()
                /// SECTOR ** SCROLL View
                SectorScrollView
            } else {
                LinkAccountView(portfolioVM: portfolioVM, plaidError: plaidError)
                    .padding()
            }

        }
    }
    
    
    /// SECTOR SCROLL View
    private var SectorScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let entries = portfolioVM.sectorEntries {
                ForEach(PortfolioChartUtils.entriesForDiversification(entries, colors: PIE_CHART_COLORS)) { entry in
                    NavigationLink {
                        DetailsView(sectorDetailsVM: DetailsViewModel(sectDict: sectorDetails),
                                    date: dateConnected,
                                    missingData: hasCostBasis,
                                    selectedSector: SelectedSector(rawValue: entry.label) ?? .none)
                    } label: {
                        SectorScrollViewCell(entry)
                    }
                }
            }
        }
        .setScrollBorderShading()
        .padding(.vertical)
        .padding(.horizontal, 14)
    }
    
    /// VIEW DETAILS ** Button
    private var ViewDetailsButton: some View {
        NavigationLink {
            DetailsView(sectorDetailsVM: DetailsViewModel(sectDict: sectorDetails),
                        date: dateConnected,
                        missingData: hasCostBasis,
                        selectedSector: .none)
        } label: {
            if showDetailsButton {
                Text("View Details")
                    .appFontMedium(color: .appYellow)
            } else {
                EmptyView()
            }
        }
        .padding(.bottom, 28)
    }
    
    private func SectorScrollViewCell(_ entry: PieChartData) -> some View {
        HStack {
            Circle()
                .foregroundColor(entry.color)
                .frame(width: 8, height: 8)
            
            Text(PortfolioChartUtils.amount(entry.value))
                .appFontMedium(size: 16)
            
            Text(entry.label)
                .appFontRegular(size: 11)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(Color.appItemBackground)
        .cornerRadius(22)
    }
    
    private func plaidError() {
        portfolioVM.handleAlert(err: .duplicateAccount, codeSheet: "Onboard Porfolio") { }
    }
    
}

//struct SectorChartCard_Previews: PreviewProvider {
//    static var previews: some View {
//        eSectorChartCard()
//    }
//}
