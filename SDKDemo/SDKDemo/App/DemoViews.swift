//
//  DemoViews.swift
//  SDKDemo
//
//  Created by Christopher Hicks on 10/24/24.
//

import SwiftUI
import StockLiftSDK

//MARK: ALL Charts Demo
struct DemoAllChartsView: View {
    var testingType: [SLChartType]
    var body: some View {
        if testingType.isEmpty {
            VStack {
                SLCharts()
                    .frame(height: UIScreen.main.bounds.height * 0.43)
                    .padding()
                
                DemoTextView(text: "This is a demo of the SLCharts DEFAULT configuration (colors, fonts, charts, etc.).")
                
//                SLCharts([.portfolioSummary, .topHoldings],
////                         projectionsChartHeader: HelperClass.randomTitle(),
////                         benchmarkChartHeader: HelperClass.randomTitle(),
////                         sectorChartHeader: HelperClass.randomTitle(),
//                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
//                         linkAccountForegroundColor: HelperClass.randomColor(),
//                         linkAccountBackgroundColor: HelperClass.randomColor(),
//                         linkAccountBorderColor: HelperClass.randomColor(),
//                         //                         linkAccountFontColor: HelperClass.randomColor(),
//                         chartForegroundColor: HelperClass.randomColor(),
//                         chartForegroundBorderColor: HelperClass.randomColor(),
//                         //                         headerFontColor: HelperClass.randomColor(),
//                         //                         sectorDetailFontColor: HelperClass.randomColor(),
//                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
//                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
//                         cardBackgroundColor: HelperClass.randomColor()
//                )
//                .frame(height: 350)
//                .padding()
//                
//                DemoTextView(text: "This is a demo of the SLCharts configured with the Portfolio Summary and Top Holdings Charts.")
                
                SLCharts([.benchmarkPerformance, .projectionsPerformance, .geoDiversification],
//                         projectionsChartHeader: HelperClass.randomTitle(),
//                         benchmarkChartHeader: HelperClass.randomTitle(),
//                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
                         linkAccountButtonColor: HelperClass.randomColor(),
                         linkAccountButtonFontColor: HelperClass.randomColor(),
                         //                         linkAccountFontColor: HelperClass.randomColor(),
                         gainColor: HelperClass.randomColor(),
                         lossColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
                         //                         headerFontColor: HelperClass.randomColor(),
                         //                         sectorDetailFontColor: HelperClass.randomColor(),
                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         assetDefaultColor: HelperClass.randomColor(),
                         cardBackgroundColor: HelperClass.randomColor()

                )
                .frame(height: 420)
                
                DemoTextView(text: "This is a demo of the SLCharts configured with the Benchmark, Projections, and Geo Diversification Charts.")
                
//                SLCharts(
////                    projectionsChartHeader: HelperClass.randomTitle(),
////                    benchmarkChartHeader: HelperClass.randomTitle(),
////                    sectorChartHeader: HelperClass.randomTitle(),
////                    geoDiversificationChartHeader: HelperClass.randomTitle(),
////                    topHoldingsChartHeader: HelperClass.randomTitle(),
////                    portfolioSummaryChartHeader: HelperClass.randomTitle(),
//                    linkAccountHeader: HelperClass.randomConnectAccountTitle(),
//                    linkAccountForegroundColor: HelperClass.randomColor(),
//                    linkAccountBackgroundColor: HelperClass.randomColor(),
//                    linkAccountBorderColor: HelperClass.randomColor(),
//                    linkAccountConnectSize: HelperClass.randomHeight(),
//                    linkAccountFont: HelperClass.randomSmFont(),
//                    //                    linkAccountFontColor: HelperClass.randomColor(),
//                    height: HelperClass.randomHeight(),
//                    chartForegroundColor: HelperClass.randomColor(),
//                    chartForegroundBorderColor: HelperClass.randomColor(),
//                    //                    xAxisFont: HelperClass.randomSmFont(),
//                    //                    xAxisFontColor: HelperClass.randomColor(),
//                    //                    yAxisFont: HelperClass.randomSmFont(),
//                    //                    yAxisFontColor: HelperClass.randomColor(),
//                    //                    headerFont: HelperClass.randomLgFont(),
//                    //                    headerFontColor: HelperClass.randomColor(),
//                    //                    subHeaderFont: HelperClass.randomSmFont(),
//                    //                    subHeaderFontColor: HelperClass.randomColor(),
//                    //                    sectorDetailFont: HelperClass.randomSmFont(),
//                    //                    sectorDetailFontColor: HelperClass.randomColor(),
//                    sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor()],
//                    portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor()],
//                    buttonColor: HelperClass.randomColor(),
//                    //                    buttonFontColor: HelperClass.randomColor(),
//                    buttonFont: HelperClass.randomSmFont(),
//                    cardBackgroundColor: HelperClass.randomColor(),
//                    cardCornerRadius: HelperClass.randomCornerRadius(),
//                    cardShadow: HelperClass.randomShadowBool(),
//                    disclaimerTitleFont: HelperClass.randomLgFont(),
//                    disclaimerBodyFont: HelperClass.randomSmFont()
//                )
//                .frame(height: 380)
                
//                DemoTextView(text: "This is a demo of the SLCharts configured with all charts.")
            }
        } else {
            SLCharts(testingType)
                .frame(height: 350)
                .padding()
        }
    }
}

struct DemoTextView: View {
    var text: String = "This is a demo of the SLCharts configuration."
    var body: some View {
        Rectangle().fill(Color(UIColor.tertiaryLabel)).frame(height: 60)
            .overlay { Text(text).font(.footnote).padding(4) }
            .padding(6)
    }
}

struct Example1View: View {
    var body: some View {
        ScrollView {
            Text("Example if a user initializes each chart individually.")
                .font(.footnote).foregroundStyle(Color.secondary)
            SLCharts([.portfolioSummary], axis: .vertical)
            
            SLCharts([.topHoldings])
                .frame(height: 320)
            
            SLCharts([.geoDiversification, .benchmarkPerformance, .sectorDiversification])
                .frame(height: 320)
        }
    }
}

struct Example2View: View {
    var body: some View {
        VStack {
            Text("Example if a user initializes using the new vertical alignment.")
                .font(.footnote).foregroundStyle(Color.secondary)
            SLCharts(axis: .vertical)
        }
    }
}

/*
 let uuid: String
 let name: String
 let email: String
 var age: Int?
 var country: SLClientCountry?
 var state: String?
 */

//MARK: - LOGIN VIEW
struct DemoLoginView: View {
    let login: (SLClient) -> Void
    
    @State private var uuid: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var age: String = ""
    @State private var country: String = ""
    @State private var state: String = ""
    
    var body: some View {
        VStack {
            // uuid
            TextField(uuid, text: $uuid)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            // name
            TextField(name, text: $name)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            // email
            TextField(email, text: $email)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            // age
            TextField(age, text: $age)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            // country
            TextField(country, text: $country)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            // state
            TextField(state, text: $state)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.tertiaryLabel))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.horizontal)
            
            Text("Submit")
                .padding(.horizontal)
                .padding(.vertical, 8)
                .foregroundStyle(Color.white)
                .background(Color.purple)
                .cornerRadius(10)
                .onTapGesture {
                    // construct SLClient
                    let client = SLClient(
                        uuid: uuid,
                        name: name,
                        email: email,
                        age: Int(age),
                        country: SLClientCountry(rawValue: country) ?? .unitedStates,
                        state: state
                    )
                    handleLogin(client)
                }
            Spacer()
        }
        .onAppear {
            getSLClientFromUserDefaults()
        }
    }
    
    private func handleLogin(_ client: SLClient) {
        print("Logged in: \(client)")
        login(client)
        HelperClass.saveSLClientToUserDefaults(client)
    }
    
    private func getSLClientFromUserDefaults()  {
        let client = HelperClass.getSLClientFromUserDefaults()
        // set values to self
        uuid = client?.uuid ?? "User uuid"
        name = client?.name ?? "User name"
        email = client?.email ?? "User email"
        age = client?.age?.description ?? "User age"
        country = client?.country?.description ?? "User country"
        state = client?.state ?? "User state"
    }
}
