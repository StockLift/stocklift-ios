# sdk-ios

StockLift iOS SDK

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
