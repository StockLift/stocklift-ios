//
//  DisclaimerView.swift
//  StockLiftSDK
//
//  Created by Christopher Hicks on 10/28/24.
//

import SwiftUI

@available(iOS 15.0, *)
struct DisclaimerView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            Text("Disclaimer")
                .font(.title3)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 14) {
                
                Text("The Portfolio calculations and insight in this app do not constitute financial advice and are intended as an informational tool to help understand your portfolio. Your personal performance figures are an estimate only and should not be solely relied upon in making investment decisions. Your personal performance figures are calculated using data provided by StockLift’s third-party partner Plaid.")
                
                Text("By default, all of your linked accounts are included in your performance information. To remove an account, unlink it in the settings section of your profile.")
                
                
                Text("Factors including unsettled activity, mutual fund to ETF conversions, corporate actions, delays in data updates from the brokerage(s) or Plaid, the specific or inconsistent accounting practices of your brokerage(s), and lack of data availability through Plaid may cause performance results to differ from actual performance. Again, all calculations displayed in the portfolio section are meant as estimates for informational purposes only.")
                
                
                Text("Keep in mind that past performance is not a guarantee of future performance. StockLift is not a brokerage firm or financial advisory firm and bears no responsibility for investment outcomes, as stated and previously agreed upon in the StockLift Terms and Conditions.")
                
            }
            .font(.caption)
            
            Spacer()
        }
        .padding()
        .overlay(alignment: .topTrailing) {
            Image(systemName: ImageKeys.xMark)
                .padding()
                .onTapGesture {
                    isPresented.toggle()
                }
        }
    }
}
