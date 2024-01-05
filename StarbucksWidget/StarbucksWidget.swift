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
            Color.black.opacity(0.3)
            VStack {
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
                .padding(.leading, 20)
                Divider()
                    .padding([.leading, .trailing], 20)
                Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.hello")!) {
                    Text("123")
                        .frame(width: 200, height: 50)
                        .background(.red)
                }
                
                Link(destination: URL(string: "myapp://com.mino.starbucks.Starbucks.bye")!) {
                    Text("123")
                        .frame(width: 200, height: 50)
                        .background(.red)
                }
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
