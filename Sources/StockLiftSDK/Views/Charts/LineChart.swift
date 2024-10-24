//
//  LineChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 16.0, *)
struct LineChart: View {
    let chartData: [ChartData]
    let foregroundColor: Color
    let foregroundBorderColor: Color
    let xAxisFont: Font
    let xAxisFontColor: Color
    let yAxisFont: Font
    let yAxisFontColor: Color
    
    var dateType: DateType
    var component: Calendar.Component?
    
    @State private var selectedElement: ChartData?
    
    init(
        chartData: [ChartData],
        foregroundColor: Color,
        foregroundBorderColor: Color,
        xAxisFont: Font,
        xAxisFontColor: Color,
        yAxisFont: Font,
        yAxisFontColor: Color,
        dateType: DateType = .all,
        component: Calendar.Component? = nil
        //        selectedElement: ChartData? = nil,
    ) {
        self.chartData = chartData
        self.foregroundColor = foregroundColor
        self.foregroundBorderColor = foregroundBorderColor
        self.xAxisFont = xAxisFont
        self.xAxisFontColor = xAxisFontColor
        self.yAxisFont = yAxisFont
        self.yAxisFontColor = yAxisFontColor
        self.dateType = dateType
        self.component = component
        //        self.selectedElement = selectedElement
    }
    
    private var setFormat: Date.FormatStyle {
        var dateFormatStyle: Date.FormatStyle = .dateTime.year()
        switch dateType {
        case .week:
            dateFormatStyle = .dateTime.day().weekday(.abbreviated)
        case .month:
            dateFormatStyle = .dateTime.month(.abbreviated).day()
        case .year:
            dateFormatStyle = .dateTime.month(.abbreviated)
        case .fiveYear:
            break
        case .tenYear:
            break
        case .all:
            break
        }
        return dateFormatStyle
    }
    
    var body: some View {
        Chart(chartData) { data in
            LineMark(x: .value("Date", data.date),
                     y: .value("Value", data.value)
            )
            .foregroundStyle(Gradient(colors: [foregroundBorderColor]))
            .interpolationMethod(.catmullRom)
            
            AreaMark(x: .value("Date", data.date),
                     y: .value("Value", data.value)
            )
            .foregroundStyle(Gradient(colors: [foregroundColor]).opacity(0.25))
            .interpolationMethod(.catmullRom)
            
        }
        .chartXAxis {
            AxisMarks(position: .bottom) { value in
                AxisValueLabel() {
                    if let stringValue = value.as(String.self) {
                        let dateValue = self.encodeDate(stringValue)
                        Text("\(dateValue, format: setFormat)")
                            .font(xAxisFont)
                            .foregroundStyle(xAxisFontColor)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("$\(intValue)")
                            .font(yAxisFont)
                            .foregroundStyle(yAxisFontColor)
                    }
                }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        SpatialTapGesture()
                            .onEnded { value in
                                let element = findElement(location: value.location, proxy: proxy, geometry: geo)
                                if selectedElement?.date == element?.date {
                                    // clear the selection.
                                    selectedElement = nil
                                } else {
                                    selectedElement = element
                                }
                            }
                            .exclusively(before: DragGesture()
                                .onChanged { value in
                                    selectedElement = findElement(location: value.location,
                                                                  proxy: proxy,
                                                                  geometry: geo)
                                })
                    )
            }
        }
        .chartOverlay { proxy in
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    if let selectedElement {
                        // Map date to chart X position
                        let startPositionX = proxy.position(forX: selectedElement.date)!
                        // Offset the chart X position by chart frame
                        let midStartPositionX = startPositionX + geo[proxy.plotAreaFrame].origin.x
                        let lineHeight = geo[proxy.plotAreaFrame].maxY
                        let boxWidth: CGFloat = 100
                        let boxOffset = max(0, min(geo.size.width - boxWidth, midStartPositionX - boxWidth / 2))
                        
                        // Scan line
                        Rectangle()
                            .fill(.quaternary)
                            .frame(width: 2, height: lineHeight)
                            .position(x: midStartPositionX, y: lineHeight / 2)
                        
                        
                        // Data info box
                        VStack(alignment: .leading) {
                            Text("\(encodeDate(selectedElement.date), format: dateType == .year ? .dateTime.year().month() : .dateTime.year().month().day())")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(selectedElement.value, format: .currency(code: "USD"))")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .frame(width: boxWidth, alignment: .leading)
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.background)
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.quaternary.opacity(0.7))
                            }
                            .padding([.leading, .trailing], -8)
                            .padding([.top, .bottom], -4)
                        }
                        .offset(x: boxOffset)
                    }
                }
            }
        }
    }
    
    func findElement(location: CGPoint,
                     proxy: ChartProxy,
                     geometry: GeometryProxy) -> ChartData? {
        // Figure out the X position by offseting gesture location with chart frame
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        // Use value(atX:) to find plotted value for the given X axis position.
        if let date = proxy.value(atX: relativeXPosition) as String? {
            // Find the closest date element.
            var minDistance: TimeInterval = .infinity
            var index: Int? = nil
            for dataIndex in chartData.indices {
                let dateIndex: Date = encodeDate(date)
                let dateDataIndex: Date = encodeDate(chartData[dataIndex].date)
                
                let nthDataDistance = dateDataIndex.distance(to: dateIndex)
                if abs(nthDataDistance) < minDistance {
                    minDistance = abs(nthDataDistance)
                    index = dataIndex
                }
            }
            if let index {
                return chartData[index]
            }
        }
        return nil
    }
    
    
}

