# StockLift iOS SDK

To obtain an access token create an account at [stocklift.sdk.co](https://sdk-stocklift-9a545489079b.herokuapp.com). Currently we are developing the other platform sdk's and accepting new members. Please email us after you have created an account to see about obtaining access and how we can further work together.

## Setup

1. Initialize the StockLiftSDK configuration object with your access token in your App Delegate

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

3. Import StockLiftSDK, create a SLCharts instance, and set a height

There is a horizontal and vertical alignment option. The SLCharts object defaults to showing all the available charts. You can also customize it to only show the charts you want.

Available Charts are:

`SLChartType`

- sectorDiversification
- benchmarkPerformance
- projectionsPerformance
- geoDiversification
- topHoldings
- portfolioSummary

_Example Horizontal_

```swift
SLCharts()
    .frame(height: UIScreen.main.bounds.height * 0.40)
```

_Example Vertical_

Height parameter is not needed but there is an optional `verticalChartHeights: CGFloat` to set the chart heights.

```swift
SLCharts(axis: .vertical)
```

_Example Custom Charts_

```swift
SLCharts([.geoDiversification, .benchmarkPerformance, .sectorDiversification])
     .frame(height: 320)
```

Majority of all the UI is customizable. Look at the docs or Package files to see what is available.

```swift
    // CHARTS to show
    public var chartViews: [SLChartType]
    // Vertical or Horizontal
    public var axis: SLChartAxis
    // Vertical Alignment Chart Heights
    public var verticalChartHeights: CGFloat

    // Header
    public var projectionsChartHeader: String
    public var benchmarkChartHeader: String
    public var sectorChartHeader: String
    public var geoDiversificationChartHeader: String
    public var topHoldingsChartHeader: String
    public var portfolioSummaryChartHeader: String

    // Link Account
    public var linkAccountHeader: String
    public var linkAccountForegroundColor: Color
    public var linkAccountBackgroundColor: Color
    public var linkAccountBorderColor: Color
    public var linkAccountConnectSize: CGFloat
    public var linkAccountFont: Font
    public var linkAccountFontColor: Color
    public var linkAccountButtonFont: Font
    public var linkAccountButtonColor: Color
    public var linkAccountButtonFontColor: Color
    public var linkAccountButtonText: String

    // Chart
    public var gainColor: Color
    public let lossColor: Color
    public var height: CGFloat
    public var chartForegroundColor: Color
    public var chartForegroundBorderColor: Color
    public var xAxisFont: Font
    public var xAxisFontColor: Color
    public var yAxisFont: Font
    public var yAxisFontColor: Color
    public var headerFont: Font
    public var headerFontColor: Color
    public var subHeaderFont: Font
    public var subHeaderFontColor: Color
    public var sectorDetailFont: Font
    public var sectorDetailFontColor: Color
    public var sp500Colors: [Color] // Benchmark Chart
    public var portfolioColors: [Color] // Benchmark Chart
    public var buttonColor: Color
    public var buttonFontColor: Color
    public var buttonFont: Font
    public var sectorHeaderFont: Font // Sector Details Breakdown
    public var sectorHeaderFontColor: Color // Sector Details Breakdown
    public var sectorSubHeaderFont: Font // Sector Details Breakdown
    public var sectorSubHeaderFontColor: Color // Sector Details Breakdown
    public var assetDefaultColor: Color // Sector Details Breakdown
    public var symbolFont: Font // Sector Details Breakdown &
    public var nameFont: Font // Sector Details Breakdown &

    // Card Background
    public var cardBackgroundColor: Color
    public var cardCornerRadius: CGFloat
    public var cardShadow: Bool

    // Disclaimer Font
    public var disclaimerTitleFont: Font
    public var disclaimerBodyFont: Font
```
