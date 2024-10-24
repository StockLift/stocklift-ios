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
    var body: some View {
        ScrollView {
            VStack {
                SLCharts()
                    .frame(height: 350)
                    .padding()
                
                DemoTextView(text: "This is a demo of the SLCharts default configuration.")
                
                SLCharts(.all,
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
                         headerFontColor: HelperClass.randomColor(),
                         sectorDetailFontColor: HelperClass.randomColor(),
                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 350)
                .padding()
                
                DemoTextView()
                
                SLCharts(.all,
                         projectionsChartHeader: HelperClass.randomTitle(),
                         benchmarkChartHeader: HelperClass.randomTitle(),
                         sectorChartHeader: HelperClass.randomTitle(),
                         linkAccountHeader: HelperClass.randomConnectAccountTitle(),
                         linkAccountForegroundColor: HelperClass.randomColor(),
                         linkAccountBackgroundColor: HelperClass.randomColor(),
                         linkAccountBorderColor: HelperClass.randomColor(),
                         linkAccountFontColor: HelperClass.randomColor(),
                         chartForegroundColor: HelperClass.randomColor(),
                         chartForegroundBorderColor: HelperClass.randomColor(),
                         headerFontColor: HelperClass.randomColor(),
                         sectorDetailFontColor: HelperClass.randomColor(),
                         sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor(), HelperClass.randomColor()],
                         cardBackgroundColor: HelperClass.randomColor()
                )
                .frame(height: 420)
                
                DemoTextView()
            }
        }
        .navigationBarTitle("All Charts Demo")
    }
}

//MARK: Growth Projections Chart Demo
struct DemoGrowthProjectionsChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
        //        TemplateDemoView {
        //            SLProjectionsChart(
        //                chartHeader: HelperClass.randomTitle(),
        //                height: HelperClass.randomHeight(),
        //                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
        //                linkAccountForegroundColor: HelperClass.randomColor(),
        //                linkAccountBackgroundColor:  HelperClass.randomColor(),
        //                chartForegroundColor: HelperClass.randomColor(),
        //                chartForegroundBorderColor: HelperClass.randomColor(),
        //                font: HelperClass.randomSmFont(),
        //                fontColor: HelperClass.randomColor(),
        //                headerFont: HelperClass.randomLgFont(),
        //                headerFontColor: HelperClass.randomColor()
        //            )
        //            .padding(CGFloat(Int.random(in: 4...25)))
        //        }
    }
}

//MARK: Sector Breakdown Chart Demo
struct DemoSectorBreakdownChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
        //        TemplateDemoView {
        //            SLSectorBreakdownChart(
        //                chartHeader: HelperClass.randomTitle(),
        //                linkAccountHeader: HelperClass.randomConnectAccountTitle(),
        //                linkAccountForegroundColor: HelperClass.randomColor(),
        //                linkAccountBackgroundColor: HelperClass.randomColor(),
        //                linkAccountBorderColor: HelperClass.randomColor(),
        //                font: HelperClass.randomSmFont(),
        //                fontColor: HelperClass.randomColor(),
        //                headerFont: HelperClass.randomLgFont(),
        //                headerFontColor: HelperClass.randomColor()
        //            )
        //            .frame(height: UIScreen.main.bounds.width)
        //        }
    }
}

//MARK: Benchmark Chart Demo
struct DemoBenchmarkChart: View {
    var body: some View {
        Text("Will not be available until v2, focusing on the All Charts configuration first.")
            .font(.footnote)
    }
}

//MARK: Net Worth Chart Demo
struct DemoNetWorthChart: View {
    var body: some View {
        Text("Coming Soon")
            .font(.footnote)
    }
}


struct DemoTextView: View {
    var text: String = "This is a demo of the SLCharts configuration."
    var body: some View {
        Rectangle().fill(Color.gray).frame(height: 60)
            .overlay { Text(text).font(.footnote) }
    }
}




//MARK: - LOGIN VIEW
struct DemoLoginView: View {
    let login: (String) -> Void
    @State private var userUuid: String = ""
    var body: some View {
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
