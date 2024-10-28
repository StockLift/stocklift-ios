//
//  PortfolioSummaryChart.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/25/24.
//

import SwiftUI

enum PortfolioPercentChange {
    case increase
    case decrease
}

@available(iOS 15.0, *)
struct PortfolioSummaryChart: View {
    
    @ObservedObject var portfolioVM: PortfolioViewModel
    @Binding var showNullDataAlert: Bool
    
    let chartHeader: String
    
    @State private var progressPercent: CGFloat = 0
    @State private var showScore: Bool = false
    @State private var showScorePoints = false
    @State private var width = UIScreen.main.bounds.width / 1.15
    @State private var timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var percent: Float {
        if portfolioVM.diversificationScore > 100 {
            return 100
        } else {
            return portfolioVM.diversificationScore
        }
    }
    
    var gainOrLoss: PortfolioPercentChange {
        return portfolioVM.portfolioUpOrDown ? .increase : .decrease
    }
    
    var returnGainOrLoss: PortfolioPercentChange {
        return portfolioVM.returnUpOrDown ? .increase : .decrease
    }
    
    var score: String {
        return portfolioVM.diversificationScore.clean
    }
    
    init(_ vm: PortfolioViewModel, showNullDataAlert: Binding<Bool>, chartHeader: String) {
        self.portfolioVM = vm
        self._showNullDataAlert = showNullDataAlert
        self.chartHeader = chartHeader
    }
  
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack {
                Text(chartHeader)
                    .appFontRegular(size: 16)
                Text(portfolioVM.netWorth, format: .currency(code: "USD"))
                    .appFontBold(size: 24, color: .blue)
            }
            .padding(.vertical, 6)
            
                HStack {
                    PercentChangeView(config: gainOrLoss,
                                      amount: portfolioVM.percentChangeInPortfolio,
                                      type: true)
                    
                    PercentChangeView(config: returnGainOrLoss,
                                      amount: portfolioVM.returnOnInvestment,
                                      type: false)
                    
                    .overlay(alignment: .topTrailing) {
                        if !portfolioVM.hasCostBasis {
                            Image(systemName: ImageKeys.warning)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .padding(.top, 8)
                                .padding(.trailing, 8)
                                .onTapGesture {
                                    guard !portfolioVM.hasCostBasis else { return }
                                    withAnimation(.easeInOut) { showNullDataAlert.toggle() }
                                }
                        }
                    }
                }
                .padding(.top, 0)
                .padding(.bottom)
                
   
            
            VStack {
                if showScore {
                    TitleView("\(score)", show: showScorePoints)
                    
                    AppProgressBar(width: $width,
                                   height: 12,
                                   cornerRadius: 22,
                                   percentOfProgress: $progressPercent
                    )
                    .animation(.spring(response: 0.55, dampingFraction: 0.85), value: progressPercent)
                    .padding(.horizontal, 4)
                    .padding(.bottom)
                } else {
                    ScoreButton(!hasAccount)
                        .onTapGesture {
                            showScore.toggle()
                        }
                }
            }
        }
//        .makeCardLayer(color: .appSecondaryBackground)
        .onReceive(timer) { value in
            if progressPercent < CGFloat(percent) && showScore {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                    progressPercent += 1
                    
                }
            } else if showScore && progressPercent == CGFloat(percent)  {
                showScorePoints = true
            }
        }
    }
    
    
    
    private func PercentChangeView(config: PortfolioPercentChange, amount: String?, type: Bool) -> some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                
                Image(config == .increase ? ImageKeys.upArrow : ImageKeys.downArrow, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    if isNull(amount)  {
                        RoundedRectangle(cornerRadius: 2)
                            .foregroundColor(.blue)
                            .padding(2)
                            .padding(.bottom, 6)
                            .frame(maxWidth: UIScreen.main.bounds.width / 4.5)
                    }
                    
                    else if let amount = amount {
                        Text("\(setSymbol(amount))%")
                            .appFontBlack(size: 16, color: config == .increase ? Color.blue : Color.red)
                    }
                    
                    else {
                        ProgressView()
                            .padding(.leading)
                    }
                    
                    if type == true {
                        Text(config == .increase ? "Increase from\nlast close" : "Decrease from\nlast close")
                            .appFontRegular()
                            .multilineTextAlignment(.leading)
                            .layoutPriority(1)
                    } else {
                        Text("Return on\nInvestment")
                            .appFontRegular()
                            .multilineTextAlignment(.leading)
                            .layoutPriority(1)
                    }
                }
            }
            .padding(4)
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.white.opacity(0.6), lineWidth: 1))
    }
    
    private func TitleView(_ score: String, show: Bool) -> some View {
        HStack {
            Text("Diversification Score")
                .appFontRegular(size: 16)
            
            Spacer()
            
            if show {
                Text(score)
                    .appFontBlack(size: 16, color: .blue)
            }
            
        }
        .padding(.horizontal, 10)
    }
    
    private func ScoreButton(_ disabled: Bool) -> some View {
        Text("Calculate Diversification Score")
            .appFontRegular()
            .padding(.vertical, 8)
            .frame(width: UIScreen.main.bounds.width / 1.15, height: 24)
            .background(disabled ? Color.gray : Color.blue)
            .cornerRadius(20)
            .padding(.horizontal, 8)
            .padding(.bottom)
    }
    
    
    
    
    
    private func isNull(_ amount: String?) -> Bool {
        amount == nil ? true : false
    }
    
    private var hasAccount: Bool {
        portfolioVM.hasAccountConnected
    }
}



