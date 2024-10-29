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
        ScrollView {
            VStack {
                SLCharts()
                    .frame(height: 350)
                    .padding()
                
                DemoTextView(text: "This is a demo of the SLCharts default configuration (colors, fonts, charts, etc.).")
                
                SLCharts([.portfolioSummary, .topHoldings],
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
//                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
//                         headerFontColor: HelperClass.randomColor(),
//                         sectorDetailFontColor: HelperClass.randomColor(),
                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 350)
                .padding()
                
                DemoTextView(text: "This is a demo of the SLCharts configured with the Portfolio Summary and Top Holdings Charts.")
                
                SLCharts([.benchmark, .projections, .geoDiversification],
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
//                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
//                         headerFontColor: HelperClass.randomColor(),
//                         sectorDetailFontColor: HelperClass.randomColor(),
                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 420)
                
                DemoTextView(text: "This is a demo of the SLCharts configured with the Benchmark, Projections, and Geo Diversification Charts.")
                
                SLCharts(
                    projectionsChartHeader: HelperClass.randomTitle(),
                    benchmarkChartHeader: HelperClass.randomTitle(),
                    sectorChartHeader: HelperClass.randomTitle(),
                    geoDiversificationChartHeader: HelperClass.randomTitle(),
                    topHoldingsChartHeader: HelperClass.randomTitle(),
                    portfolioSummaryChartHeader: HelperClass.randomTitle(),
                    linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                    linkAccountForegroundColor: HelperClass.randomColor(),
                    linkAccountBackgroundColor: HelperClass.randomColor(),
                    linkAccountBorderColor: HelperClass.randomColor(),
                    linkAccountConnectSize: HelperClass.randomHeight(),
                    linkAccountFont: HelperClass.randomSmFont(),
//                    linkAccountFontColor: HelperClass.randomColor(),
                    height: HelperClass.randomHeight(),
                    chartForegroundColor: HelperClass.randomColor(),
                    chartForegroundBorderColor: HelperClass.randomColor(),
                    //                    xAxisFont: HelperClass.randomSmFont(),
//                    xAxisFontColor: HelperClass.randomColor(),
                    //                    yAxisFont: HelperClass.randomSmFont(),
//                    yAxisFontColor: HelperClass.randomColor(),
//                    headerFont: HelperClass.randomLgFont(),
//                    headerFontColor: HelperClass.randomColor(),
//                    subHeaderFont: HelperClass.randomSmFont(),
//                    subHeaderFontColor: HelperClass.randomColor(),
                    //                    sectorDetailFont: HelperClass.randomSmFont(),
//                    sectorDetailFontColor: HelperClass.randomColor(),
                    sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor()],
                    portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor()],
                    buttonColor: HelperClass.randomColor(),
//                    buttonFontColor: HelperClass.randomColor(),
                    buttonFont: HelperClass.randomSmFont(),
                    cardBackgroundColor: HelperClass.randomColor(),
                    cardCornerRadius: HelperClass.randomCornerRadius(),
                    cardShadow: HelperClass.randomShadowBool(),
                    disclaimerTitleFont: HelperClass.randomLgFont(),
                    disclaimerBodyFont: HelperClass.randomSmFont()
                )
                .frame(height: 380)
                
                DemoTextView(text: "This is a demo of the SLCharts configured with all charts.")
            }
        }
//        .navigationBarTitle("All Charts Demo")
    }
}

//MARK: Growth Projections Chart Demo
struct DemoGrowthProjectionsChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}

//MARK: Sector Breakdown Chart Demo
struct DemoSectorBreakdownChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}

//MARK: Benchmark Chart Demo
struct DemoBenchmarkChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}

//MARK: GEO DIVERSIFICATION Chart Demo
struct DemoGeoDiversificationChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}

//MARK: TOP HOLDINGS Chart Demo
struct DemoTopHoldingsChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}

//MARK: - PORTFOLIO SUMMARY Chart Demo
struct DemoPortfolioSummaryChart: View {
    var body: some View {
        TemplateDemoView {
            ComingSoonView()
        }
    }
}



// -------- HELPER VIEWS

struct ComingSoonView: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the SLCharts (all charts) configuration first.")
            .font(.body)
    }
}

struct DemoTextView: View {
    var text: String = "This is a demo of the SLCharts configuration."
    var body: some View {
        Rectangle().fill(Color(UIColor.tertiaryLabel)).frame(height: 60)
            .overlay { Text(text).font(.footnote) }
        //            .multilineTextAlignment(.center)
            .padding(6)
    }
}

struct Example1View: View {
    var body: some View {
        ScrollView {
            SLCharts([.portfolioSummary])
                .frame(height: 210)
            
            SLCharts([.topHoldings])
                .frame(height: 320)
            
            SLCharts([.geoDiversification, .benchmark, .sector])
                .frame(height: 320)
        }
    }
}

struct Example2View: View {
    var body: some View {
        ScrollView {
            SLCharts([.portfolioSummary, .projections])
                .frame(height: 220)
            
//            SLCharts([.topHoldings])
//                .frame(height: 320)
//            
//            SLCharts([.geoDiversification, .benchmark, .sector])
//                .frame(height: 320)
        }
    }
}

//MARK: - LOGIN VIEW
struct DemoLoginView: View {
    let login: (String) -> Void
    @State private var userUuid: String = ""
    var body: some View {
        VStack {
//            HStack {
//                NavigationLink {
//                    Example1View()
//                } label: {
//                    Text("Example 1")
//                }
//                
//                NavigationLink {
//                    Example2View()
//                } label: {
//                    Text("Example 2")
//                }
//            }

            TextField("User uuid", text: $userUuid)
                .keyboardType(.default)
                .autocapitalization(.none)
                .padding()
            Divider()
            Text("Submit")
                .padding(.horizontal)
                .padding(.vertical, 8)
                .foregroundStyle(Color.white)
                .background(Color.purple)
                .cornerRadius(10)
                .onTapGesture {
                    login(userUuid)
                }
            Spacer()
        }
    }
}
