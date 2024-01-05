//
//  StarbucksWidget.swift
//  StarbucksWidget
//
//  Created by DEV IOS on 2024/01/05.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct StarbucksWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        ZStack {
            Color("starbucksGreen")
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Image("icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Starbucks")
                        .bold()
                        .foregroundColor(.white)
                        .font(.callout)
                    Spacer()
                }
                .padding(EdgeInsets(top: 30,
                                    leading: 20,
                                    bottom: 10,
                                    trailing: 0))
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 17)
                HStack {
                    VStack(spacing: 10) {
                        Spacer()
                        Image("cup")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.hello")!) {
                            Text("사이렌오더")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    Spacer()
                    VStack(spacing: 10) {
                        Spacer()
                        Image("card")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.hello")!) {
                            Text("페이")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    Spacer()
                    VStack(spacing: 10) {
                        Spacer()
                        Image("coupon")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.hello")!) {
                            Text("쿠폰")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    Spacer()
                    VStack(spacing: 10) {
                        Spacer()
                        Image("bag")
                            .resizable()
                            .frame(width: 35, height: 35)
                        Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.hello")!) {
                            Text("온라인 스토어")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 10,
                                    leading: 15,
                                    bottom: 0,
                                    trailing: 15))
//                .background(.red)
            }
        }
    }
}

struct StarbucksWidget: Widget {
    let kind: String = "StarbucksWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            StarbucksWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("즐겨찾기")
        .description("스타벅스의 주요 기능을\n간편하고 빠르게 이용할 수 있어요.")
        .supportedFamilies([.systemMedium])
    }
}

struct StarbucksWidget_Previews: PreviewProvider {
    static var previews: some View {
        StarbucksWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
