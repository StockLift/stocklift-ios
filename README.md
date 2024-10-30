# StockLift iOS SDK

## Setup

1. Init the StockLiftSDK config object with your access token in your App Delegate

_Example_

```swift
public final class AppDelegate: NSObject, UIApplicationDelegate {

    public func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        /// SET YOUR SDK ACCESS TOKEN
        ///  https://sdk-stocklift.co/docs/

        StockLiftSDK.accessToken = <token>

        return true
    }
}
```

2. Set your client details before connecting the users account.

_Example_

```swift
let client = SLClient(uuid: "test-123", name: "Jane Doe", email: "test@test.com")
StockLiftSDK.client = client
```

3. Create a SLCharts instance and set a height 

```swift
 SLCharts()
    .frame(height: UIScreen.main.bounds.height * 0.40)
    .padding()
```

Majority of all the UI is customizable. Look at the docs or Package files to see what is available. 

```swift
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
    linkAccountButtonColor: HelperClass.randomColor(),
    linkAccountButtonFontColor: HelperClass.randomColor(),
    linkAccountConnectSize: HelperClass.randomHeight(),
    linkAccountFont: HelperClass.randomSmFont(),
    linkAccountFontColor: HelperClass.randomColor(),
    height: HelperClass.randomHeight(),
    chartForegroundColor: HelperClass.randomColor(),
    chartForegroundBorderColor: HelperClass.randomColor(),
    xAxisFont: HelperClass.randomSmFont(),
    xAxisFontColor: HelperClass.randomColor(),
    yAxisFont: HelperClass.randomSmFont(),
    yAxisFontColor: HelperClass.randomColor(),
    headerFont: HelperClass.randomLgFont(),
    headerFontColor: HelperClass.randomColor(),
    subHeaderFont: HelperClass.randomSmFont(),
    subHeaderFontColor: HelperClass.randomColor(),
    sectorDetailFont: HelperClass.randomSmFont(),
    sectorDetailFontColor: HelperClass.randomColor(),
    sp500Colors: [HelperClass.randomColor(), HelperClass.randomColor()],
    portfolioColors: [HelperClass.randomColor(), HelperClass.randomColor()],
    buttonColor: HelperClass.randomColor(),
    buttonFontColor: HelperClass.randomColor(),
    buttonFont: HelperClass.randomSmFont(),
    cardBackgroundColor: HelperClass.randomColor(),
    cardCornerRadius: HelperClass.randomCornerRadius(),
    cardShadow: HelperClass.randomShadowBool(),
    disclaimerTitleFont: HelperClass.randomLgFont(),
    disclaimerBodyFont: HelperClass.randomSmFont()
        )
```

# SLProjectionsChart

## Overview

`SLProjectionsChart` is a SwiftUI view that displays growth chart projections for a user's portfolio. It includes customizable properties for the chart's appearance and a link account section.

## Initialization

To initialize `SLProjectionsChart`, you can provide the following parameters:

- `chartHeader`: A `String` representing the header for the chart.
- `height`: A `CGFloat` representing the height of the chart.
- `linkAccountHeader`: A `String` representing the header title for the link account view.
- `linkAccountForegroundColor`: A `Color` for the foreground of the link account view.
- `linkAccountBackgroundColor`: A `Color` for the background of the link account view.
- `linkAccountBorderColor`: A `Color` for the border of the link account view.
- `linkAccountConnectSize`: A `CGFloat` for the size of the link account connect button.
- `linkAccountFont`: A `Font` for the link account text.
- `linkAccountFontColor`: A `Color` for the link account text color.
- `chartForegroundColor`: A `Color` for the chart's foreground area.
- `chartForegroundBorderColor`: A `Color` for the chart's foreground border.
- `font`: A `Font` for the chart text.
- `fontColor`: A `Color` for the chart text color.
- `headerFont`: A `Font` for the header text.
- `headerFontColor`: A `Color` for the header text color.

## Example Usage

```swift
import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    var body: some View {
        SLProjectionsChart(
          "Portfolio Growth", // Chart Header
            height: 300,
            linkAccountHeader: "Link Your Account",
            linkAccountForegroundColor: .blue,
            linkAccountBackgroundColor: .gray,
            linkAccountBorderColor: .black,
            linkAccountConnectSize: 20,
            linkAccountFont: .system(size: 14),
            linkAccountFontColor: .white,
            chartForegroundColor: .green,
            chartForegroundBorderColor: .black,
            font: .system(size: 12),
            fontColor: .black,
            headerFont: .system(size: 16, weight: .bold),
            headerFontColor: .black
        )
    }
}

```

# SLSectorBreakdownChart

## Overview

`SLSectorBreakdownChart` is a SwiftUI view that displays a breakdown of a user's portfolio by sector. It includes customizable properties for the chart's appearance and a link account section.

## Initialization

To initialize `SLSectorBreakdownChart`, you can provide the following parameters:

- `chartHeader`: A `String` representing the header for the chart.
- `linkAccountHeader`: A `String` representing the header title for the link account view.
- `linkAccountForegroundColor`: A `Color` for the foreground of the link account view.
- `linkAccountBackgroundColor`: A `Color` for the background of the link account view.
- `linkAccountBorderColor`: A `Color` for the border of the link account view.
- `linkAccountConnectSize`: A `CGFloat` for the size of the link account connect button.
- `linkAccountFont`: A `Font` for the link account text.
- `linkAccountFontColor`: A `Color` for the link account text color.
- `font`: A `Font` for the chart text.
- `fontColor`: A `Color` for the chart text color.
- `headerFont`: A `Font` for the header text.
- `headerFontColor`: A `Color` for the header text color.

## Example Usage

```swift
import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    var body: some View {
        SLSectorBreakdownChart(
            "Diversification by Sector", // Chart Header
            linkAccountHeader: "Add a brokerage account to get a free detailed breakdown of your investments",
            linkAccountForegroundColor: .white,
            linkAccountBackgroundColor: .black,
            linkAccountBorderColor: .white,
            linkAccountConnectSize: 38,
            linkAccountFont: .caption,
            linkAccountFontColor: .white,
            font: .caption,
            fontColor: .primary,
            headerFont: .subheadline,
            headerFontColor: .primary
        )
    }
}
```
