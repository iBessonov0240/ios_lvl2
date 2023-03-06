//
//  ExampleWidgetView.swift
//  ExampleWidgetView
//
//  Created by i0240 on 06.03.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.m4w")!
        let nameText = userDefaults.string(forKey: "userName") ?? ""
        let textColorData = userDefaults.data(forKey: "colorTextName") ?? Data()
        let textColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(textColorData)) as? Color ?? .black
        let backColorData = userDefaults.data(forKey: "colorBack") ?? Data()
        let backColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(backColorData)) as? Color ?? .white
        let futureDate = userDefaults.object(forKey: "futureDate") as? Date ?? Date().addingTimeInterval(86400)
        
        return SimpleEntry(date: Date(), nameText: nameText, textColor: textColor, backColor: backColor, futureDate: futureDate)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.m4w")!
        let nameText = userDefaults.string(forKey: "userName") ?? ""
        let textColorData = userDefaults.data(forKey: "colorTextName") ?? Data()
        let textColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(textColorData)) as? Color ?? .black
        let backColorData = userDefaults.data(forKey: "colorBack") ?? Data()
        let backColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(backColorData)) as? Color ?? .white
        let futureDate = userDefaults.object(forKey: "futureDate") as? Date ?? Date().addingTimeInterval(86400)
        
        let entry = SimpleEntry(date: Date(), nameText: nameText, textColor: textColor, backColor: backColor, futureDate: futureDate)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.m4w")!
        let nameText = userDefaults.string(forKey: "userName") ?? ""
        let textColorData = userDefaults.data(forKey: "colorTextName") ?? Data()
        let textColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(textColorData)) as? Color ?? .black
        let backColorData = userDefaults.data(forKey: "colorBack") ?? Data()
        let backColor = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(backColorData)) as? Color ?? .white
        let futureDate = userDefaults.object(forKey: "futureDate") as? Date ?? Date().addingTimeInterval(86400)
        
        let entry = SimpleEntry(date: Date(), nameText: nameText, textColor: textColor, backColor: backColor, futureDate: futureDate)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

private func widgetFont(for family: WidgetFamily) -> Font {
    switch family {
    case .systemSmall:
        return .system(size: 12, weight: .regular, design: .default)
    case .systemMedium:
        return .system(size: 16, weight: .regular, design: .default)
    case .systemLarge:
        return .system(size: 24, weight: .bold, design: .default)
    default:
        return .system(size: 16, weight: .regular, design: .default)
    }
}

private func timeRemaining(until date: Date) -> String {
    let interval = date.timeIntervalSince(Date())
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.day, .hour, .minute]
    guard let timeRemaining = formatter.string(from: interval) else {
        return ""
    }
    return "Time Remaining: \(timeRemaining)"
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var nameText: String
    var textColor: Color
    var backColor: Color
    var futureDate: Date
}

//struct PlaceholderView : View {
//    var body: some View {
//        Text("Placeholder View")
//    }
//}

struct ExampleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text(entry.nameText)
                    .font(widgetFont(for: WidgetFamily.systemSmall))
                    .foregroundColor(entry.textColor)
                    .padding()
                
                Text(timeRemaining(until: entry.futureDate))
                    .font(widgetFont(for: WidgetFamily.systemSmall))
                    .foregroundColor(entry.textColor)
                    .padding()
            }
            .widgetURL(URL(string: "widget-preview://"))
        }
    }
}

struct ExampleMediumWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text(entry.nameText)
                    .font(widgetFont(for: WidgetFamily.systemMedium))
                    .foregroundColor(entry.textColor)
                    .padding()
                
                Text(timeRemaining(until: entry.futureDate))
                    .font(widgetFont(for: WidgetFamily.systemMedium))
                    .foregroundColor(entry.textColor)
                    .padding()
            }
            .widgetURL(URL(string: "widget-preview://"))
        }
    }
}

struct ExampleLargeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text(entry.nameText)
                    .font(widgetFont(for: WidgetFamily.systemLarge))
                    .foregroundColor(entry.textColor)
                    .padding()
                
                Text(timeRemaining(until: entry.futureDate))
                    .font(widgetFont(for: WidgetFamily.systemLarge))
                    .foregroundColor(entry.textColor)
                    .padding()
            }
            .widgetURL(URL(string: "widget-preview://"))
        }
    }
}

@main
struct WidgetsBundle: WidgetBundle {
    var body: some Widget {
        ExampleWidget()
        ExampleMediumWidget()
        ExampleLargeWidget()
    }
}

struct ExampleWidget: Widget {
    let kind: String = "ExampleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExampleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Data")
        .description("Displays user-selected text, text color, background color, and future date.")
        .supportedFamilies([.systemSmall])
    }
}

struct ExampleMediumWidget: Widget {
    let kind: String = "ExampleMediumWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExampleMediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Data")
        .description("Displays user-selected text, text color, background color, and future date.")
        .supportedFamilies([.systemMedium])
    }
}

struct ExampleLargeWidget: Widget {
    let kind: String = "ExampleLargeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExampleLargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Data")
        .description("Displays user-selected text, text color, background color, and future date.")
        .supportedFamilies([.systemLarge])
    }
}

struct ExampleWidget_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWidgetEntryView(entry: SimpleEntry(date: Date(), nameText: "text", textColor: .white, backColor: .blue, futureDate: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
