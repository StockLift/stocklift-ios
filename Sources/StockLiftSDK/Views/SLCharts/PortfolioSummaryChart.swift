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
    
    // Initializers
//    let showNullDataAlert: Bool
    let chartHeader: String
    let headerFont: Font
    let headerFontColor: Color
    let scoreButtonColor: Color
    let scoreButtonFontColor: Color
    let scoreButtonFont: Font
    // Link Account
    let linkAccountHeader: String
    let linkAccountForegroundColor: Color
    let linkAccountBackgroundColor: Color
    let linkAccountBorderColor: Color
    let linkAccountConnectSize: CGFloat
    let linkAccountFont: Font
    let linkAccountFontColor: Color
    let plaidError: () -> Void
    let getPortfolio: () -> Void
    
    @State private var progressPercent: CGFloat = 0
    @State private var showScore: Bool = false
    @State private var showScorePoints = false
    @State private var width = UIScreen.main.bounds.width / 1.15
    @State private var timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    var percent: Float? {
        if let score = portfolioVM.diversificationScore {
            if score > 100 {
                return 100
            } else {
                return score
            }
        }
        return nil
    }
    
    var gainOrLoss: PortfolioPercentChange {
        return portfolioVM.portfolioUpOrDown ? .increase : .decrease
    }
    
    var returnGainOrLoss: PortfolioPercentChange {
        return portfolioVM.returnUpOrDown ? .increase : .decrease
    }
    
    var diversificationScore: String? {
        return portfolioVM.diversificationScore?.clean
    }
    
    
    private func isNull(_ amount: String?) -> Bool {
        amount == nil ? true : false
    }
    
    private var hasAccount: Bool {
        portfolioVM.hasAccountConnected
    }
    
    init(
        _ vm: PortfolioViewModel,
//        showNullDataAlert: Bool,
        chartHeader: String = "Portfolio Net Summary",
        headerFont: Font = .subheadline,
        headerFontColor: Color = .primary,
        scoreButtonColor: Color = .blue,
        scoreButtonFontColor: Color = .primary,
        scoreButtonFont: Font = .caption,
        linkAccountHeader: String = "Add a brokerage account to get a free detailed breakdown of your investments",
        linkAccountForegroundColor: Color = .white,
        linkAccountBackgroundColor: Color = .black,
        linkAccountBorderColor: Color = .white,
        linkAccountConnectSize: CGFloat = 38,
        linkAccountFont: Font = .caption,
        linkAccountFontColor: Color = .primary,
        plaidError: @escaping () -> Void,
        getPortfolio: @escaping () -> Void
    )
    {
        self.portfolioVM = vm
//        self.showNullDataAlert = showNullDataAlert
        self.chartHeader = chartHeader
        self.headerFont = headerFont
        self.headerFontColor = headerFontColor
        self.scoreButtonColor = scoreButtonColor
        self.scoreButtonFontColor = scoreButtonFontColor
        self.scoreButtonFont = scoreButtonFont
        self.linkAccountHeader = linkAccountHeader
        self.linkAccountForegroundColor = linkAccountForegroundColor
        self.linkAccountBackgroundColor = linkAccountBackgroundColor
        self.linkAccountBorderColor = linkAccountBorderColor
        self.linkAccountConnectSize = linkAccountConnectSize
        self.linkAccountFont = linkAccountFont
        self.linkAccountFontColor = linkAccountFontColor
        self.plaidError = plaidError
        self.getPortfolio = getPortfolio
    }
    
    //MARK: - BODY
    var body: some View {
        if let netWorth = portfolioVM.netWorth, let score = diversificationScore {
            MainView(netWorth: netWorth, score: score)
        } else if portfolioVM.isLoading == false {
            // --- NO ACCOUNT DATA view
            // Link Plaid flow
            LinkAccountView(
                linkAccountHeader: linkAccountHeader,
                plaidError: plaidError,
                getPortfolio: getPortfolio,
                foregroundColor: linkAccountForegroundColor,
                backgroundColor: linkAccountBackgroundColor,
                borderColor: linkAccountBorderColor,
                connectSize: linkAccountConnectSize,
                font: linkAccountFont,
                fontColor: linkAccountFontColor
            )
        } else {
            ProgressView()
        }
    }
    
    //MARK: MAIN VIEW
    @ViewBuilder
    private func MainView(netWorth: Float, score: String) -> some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 24) {
                Text(chartHeader)
                    .font(headerFont)
                    .foregroundColor(headerFontColor)
                    .underline(color: headerFontColor)
                
//                Spacer()
                
                Text(netWorth, format: .currency(code: "USD"))
                    .font(.title2)
                    .foregroundColor(.primary)
            }
//            .padding(.vertical, 6)
            
            Spacer()
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
//                            .onTapGesture {
//                                guard !portfolioVM.hasCostBasis else { return }
//                                withAnimation(.easeInOut) { showNullDataAlert.toggle() }
//                            }
                    }
                }
            }
//            .padding(.top, 0)
//            .padding(.bottom)
            
            Spacer()
            
            // Diversification Score View
            DiversificationScore(score: score)
        }
        .onReceive(timer) { value in
            guard let percent = percent else { return }
            if progressPercent < CGFloat(percent) && showScore {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                    progressPercent += 1
                }
            } else if showScore && progressPercent == CGFloat(percent)  {
                showScorePoints = true
            }
        }
    }
    
    //MARK: DIVERSIFICATION SCORE VIEW
    @ViewBuilder
    private func DiversificationScore(score: String) -> some View {
        VStack {
            if showScore {
                HStack {
                    Text("Diversification Score")
                        .font(headerFont)
                        .foregroundColor(headerFontColor)
                    Spacer()
                    if showScorePoints {
                        Text(score)
                            .appFontBlack(size: 16, color: .blue)
                    }
                }
                .padding(.horizontal, 10)
                AppProgressBar(width: $width,
                               height: 12,
                               cornerRadius: 22,
                               percentOfProgress: $progressPercent
                )
                .animation(.spring(response: 0.55, dampingFraction: 0.85), value: progressPercent)
                .padding(.horizontal, 8)
                .padding(.bottom)
                
            } else {
                Text("Calculate Diversification Score")
                    .font(scoreButtonFont)
                    .foregroundColor(scoreButtonFontColor)
                    .padding(.vertical, 8)
                    .frame(width: UIScreen.main.bounds.width / 1.15, height: 24)
                    .background(!hasAccount ? Color.gray : scoreButtonColor)
                    .cornerRadius(20)
                    .padding(.horizontal, 8)
                    .padding(.bottom)
                    .onTapGesture {
                        guard hasAccount else { return }
                        withAnimation(.easeOut) {
                            showScore.toggle()
                        }
                    }
            }
        }
    }
    
    //MARK: PERCENT CHANGE VIEW
    @ViewBuilder
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
    
}



