//
//  ExampleWidget.swift
//  ExampleWidget
//
//  Created by i0240 on 17.02.2023.
//

import WidgetKit
import SwiftUI
//import Intents

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
//        let nameText = UserDefaults(suiteName: "group.m4w")?.string(forKey: "userName") ?? ""
//        let textColorString = UserDefaults(suiteName: "group.m4w")?.string(forKey: "colorTextName") ?? "black"
//        let backColorString = UserDefaults(suiteName: "group.m4w")?.string(forKey: "colorBack") ?? "white"
//        let textColor = Color(textColorString)
//        let backColor = Color(backColorString)
//        let futureDate = Date().addingTimeInterval(3600 * 24 * 7)
//
        SimpleEntry(date: Date(), nameText: "Placeholder Text", textColor: .white, backColor: .blue, futureDate: Date().addingTimeInterval(3600))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
//        let nameText = UserDefaults(suiteName: "group.m4w")?.string(forKey: "userName") ?? ""
//        let textColorString = UserDefaults(suiteName: "group.m4w")?.string(forKey: "colorTextName") ?? "black"
//        let backColorString = UserDefaults(suiteName: "group.m4w")?.string(forKey: "colorBack") ?? "white"
//        let textColor = Color(textColorString)
//        let backColor = Color(backColorString)
//        let futureDate = UserDefaults(suiteName: "group.m4w")?.object(forKey: "futureDate") as? Date
        
        let entry = SimpleEntry(date: Date(), nameText: "Placeholder text", textColor: .white, backColor: .blue, futureDate: Date().addingTimeInterval(3600))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let nameText = UserDefaults(suiteName: "group.m4w")?.string(forKey: "userName") ?? ""
        let textColorData = UserDefaults(suiteName: "group.m4w")?.data(forKey: "colorTextName") ?? Data()
        let textColor = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(textColorData) as? Color ?? Color.black
        let backColorData = UserDefaults(suiteName: "group.m4w")?.data(forKey: "colorBack") ?? Data()
        let backColor = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(backColorData) as? Color ?? Color.white
        let userDefailts = UserDefaults.standard
        let futureDate = userDefailts.object(forKey: "futureDate") as? Date ?? Date()
//        let futureDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        
        entries.append(SimpleEntry(date: Date(), nameText: nameText, textColor: textColor, backColor: backColor, futureDate: futureDate))

        let refreshDate = Calendar.current.startOfDay(for: Date().addingTimeInterval(24 * 60 * 60))
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var nameText: String
    var textColor: Color
    var backColor: Color
    var futureDate: Date
}

struct ExampleWidgetEntryView : View {
    let entry: Provider.Entry
//    let size: WidgetFamily

    var body: some View {
        VStack {
            Text(entry.nameText)
                .foregroundColor(entry.textColor)
                .padding()
                .background(entry.backColor)
                .cornerRadius(10)
                .font(.system(size: 14))
            Text(Calendar.current.startOfDay(for: Date().addingTimeInterval(24 * 60 * 60)), style: .relative)
            Text(getRemainingTime(entry: entry))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .background(entry.backColor)
        .foregroundColor(entry.textColor)
        .padding()
    }
    
    func getRemainingTime(entry: SimpleEntry) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: entry.futureDate)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        if days > 0 {
            return "\(days)d \(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}

struct ExampleLargeWidgetEntryView : View {
    let entry: Provider.Entry
//    let size: WidgetFamily

    var body: some View {
        VStack {
            Text(entry.nameText)
                .foregroundColor(entry.textColor)
                .padding()
                .background(entry.backColor)
                .cornerRadius(10)
                .font(.system(size: 20))
            Text(Calendar.current.startOfDay(for: Date().addingTimeInterval(24 * 60 * 60)), style: .relative)
            Text(getRemainingTime(entry: entry))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .background(entry.backColor)
        .foregroundColor(entry.textColor)
        .padding()
    }
    
    func getRemainingTime(entry: SimpleEntry) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: Date(), to: entry.futureDate)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        if days > 0 {
            return "\(days)d \(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}

@main
struct WidgetsBudle: WidgetBundle {
    var body: some Widget {
        ExampleWidget()
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

struct ExampleLargeWidget: Widget {
    let kind: String = "ExampleLargeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ExampleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Data")
        .description("Displays user-selected text, text color, background color, and future date.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct ExampleWidget_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWidgetEntryView(entry: SimpleEntry(date: Date(), nameText: "text", textColor: Color.black, backColor: Color.white, futureDate: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
