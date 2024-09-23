//
//  BarLineChart.swift
//  Stocklift
//
//  Created by Christopher Hicks on 11/16/22.
//  Copyright © 2022 StockLift Inc. All rights reserved.
//

import SwiftUI
import Charts

@available(iOS 13.0, *)
struct BarLineChart: View {
    @State var selectedElement: (ChartData?, ChartData?)?
    let portfolioChartData: [ChartData]
    let sp500ChartData: [ChartData]
    let dateType: DateType
    
    @available(iOS 16.0, *)
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
        VStack {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(portfolioChartData) { data in
                        LineMark(x: .value("Date", data.date),
                                 y: .value("Value", data.value)
                        )
                        .foregroundStyle(Gradient(colors: [Color.appYellow, Color.yellow]))
                        .interpolationMethod(.catmullRom)
                    }
                    ForEach(sp500ChartData) { data in
                        BarMark(x: .value("Date", data.date),
                                y: .value("Value", data.value)
                        )
                        .foregroundStyle(Gradient(colors: [Color.appBlue, Color.blue]))
                        .opacity(0.6)
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { value in
                        AxisValueLabel() {
                            if let stringValue = value.as(String.self) {
                                let dateValue = self.encodeDate(stringValue)
                                Text("\(dateValue, format: setFormat)")
                                    .appFontRegular(size: 10, color: .gray)
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisValueLabel() {
                            if let intValue = value.as(Int.self) {
                                Text("\(intValue)%")
                                    .appFontRegular(size: 10)
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
                                        let element = findElement(location: value.location,
                                                                  proxy: proxy,
                                                                  geometry: geo)
                                        if selectedElement?.0?.date == element.0?.date {
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
                          let startPositionX = proxy.position(forX: selectedElement.1?.date ?? "")!
                        // Offset the chart X position by chart frame
                        let midStartPositionX = startPositionX + geo[proxy.plotAreaFrame].origin.x
                        let lineHeight = geo[proxy.plotAreaFrame].maxY
                        let boxWidth: CGFloat = 175
                        let boxOffset = max(0, min(geo.size.width - boxWidth, midStartPositionX - boxWidth / 2))

                        // Scan line
                        Rectangle()
                          .fill(.quaternary)
                          .frame(width: 2, height: lineHeight)
                          .position(x: midStartPositionX, y: lineHeight / 2)
                          
                          // Data info box
                          VStack {
                              HStack(alignment: .center) {
                                  Circle().fill(Color.appYellow).frame(width: 8, height: 8)
                                  Text("\(encodeDate(selectedElement.0?.date ?? ""), format: .dateTime.year().month().day())")
                                      .font(.caption)
                                      .foregroundStyle(.secondary)
                                  Text("\(self.setSymbol(selectedElement.0?.value.amountToPercent() ?? ""))")
                                      .font(.caption)
                                      .foregroundColor(.primary)
                                  
                                  Spacer()
                              }
                              .padding(.bottom, 4)
                              
                              HStack(alignment: .center) {
                                  Circle().fill(Color.appBlue).frame(width: 8, height: 8)
                                  Text("\(encodeDate(selectedElement.1?.date ?? ""), format: .dateTime.year().month().day())")
                                      .font(.caption)
                                      .foregroundStyle(.secondary)
                                  Text("\(self.setSymbol(selectedElement.1?.value.amountToPercent() ?? ""))")
                                      .font(.caption)
                                      .foregroundColor(.primary)
                                  
                                  Spacer()
                              }
                            
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

            } else {
                Text("Please update your phone")
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
    }
    
    
    @available(iOS 16.0, *)
    func findElement(location: CGPoint,
                     proxy: ChartProxy,
                     geometry: GeometryProxy) -> (ChartData?, ChartData?) {
        // Figure out the X position by offseting gesture location with chart frame
        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        // Use value(atX:) to find plotted value for the given X axis position.
        if let date = proxy.value(atX: relativeXPosition) as String? {
            // Find the closest date element.
            var minDistance: TimeInterval = .infinity
            var index: Int? = nil
            for dataIndex in portfolioChartData.indices {
                let dateIndex: Date = encodeDate(date)
                let dateDataIndex: Date = encodeDate(portfolioChartData[dataIndex].date)
                let nthDataDistance = dateDataIndex.distance(to: dateIndex)
                if abs(nthDataDistance) < minDistance {
                    minDistance = abs(nthDataDistance)
                    index = dataIndex
                }
            }
            if let index {
                return (portfolioChartData[index], sp500ChartData[index])
            }
        }
        return (nil, nil)
    }

}
