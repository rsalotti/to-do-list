//
//  TDModel.swift
//  TodoList
//
//  Created by Ricardo Salotti on 15/09/25.
//

import SwiftUI

struct TDModel {
    var id = UUID()
    var title: String
    var details: String
    var isCompleted: Bool = false
}

struct TimeLineView: View {
    @State var items: [TDModel] = [
        TDModel(title: "Complete SwiftUI Tutorial", details: "Follow the latest SwiftUI tutorial to enhance your UI building skills and explore new features."),
        TDModel(title: "Build a Simple Calculator", details: "Design and implement a basic calculator using SwiftUI to reinforce your understanding of UI components."),
        TDModel(title: "Create a Custom Date Picker", details: "Develop a custom date picker to add a touch of elegance to your applications."),
        TDModel(title: "Learn about SwiftUI Animations", details: "Explore the world of animations in SwiftUI to make your interfaces more engaging."),
        TDModel(title: "Build a Responsive App", details: "Design a layout that adapts seamlessly to different screen sizes and orientations."),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(items.indices, id: \.self) { id in
                    TaskView(item: items[id])
                        .background(alignment: .topLeading) {
                            GeometryReader { geometry in
                                Rectangle()
                                    .frame(width: 2)
                                    .frame(maxHeight: items[id].isCompleted ? geometry.size.height - 5 : 0)
                                    .offset(y: 23)
                                    .padding(.leading, 12)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.3)) {
                                items[id].isCompleted.toggle()
                            }
                        }
                }
                HStack {
                    Image(systemName: items.allSatisfy{ $0.isCompleted } ? "checkmark.circle.fill" : "circle")
                    Text("Finish")
                    Spacer()
                }
                .foregroundStyle(items.allSatisfy(\.isCompleted) ? .green : .gray)
                .font(.title2)
                .onTapGesture {
                    toggleAllCompletion()
                }
            }
            .padding()
        }
    }
    
    private func toggleAllCompletion() {
        let isCompleted = items.allSatisfy(\.isCompleted)
        updateItemsSequentially(makeTrue: !isCompleted, reverse: isCompleted)
    }
    
    private func updateItemsSequentially(makeTrue: Bool, reverse: Bool) {
        let delayStep = 0.3
        let indices = reverse ? Array(items.indices.reversed()) : Array(items.indices)
        for (offset, index) in indices.enumerated() {
            let delay = Double(offset) * delayStep
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    items[index].isCompleted = makeTrue
                }
            }
        }
    }
}

#Preview {
    TimeLineView(items: [
        TDModel(title: "Complete SwiftUI Tutorial", details: "Follow the latest SwiftUI tutorial to enhance your UI building skills and explore new features."),
        TDModel(title: "Build a Simple Calculator", details: "Design and implement a basic calculator using SwiftUI to reinforce your understanding of UI components."),
        TDModel(title: "Create a Custom Date Picker", details: "Develop a custom date picker to add a touch of elegance to your applications."),
        TDModel(title: "Learn about SwiftUI Animations", details: "Explore the world of animations in SwiftUI to make your interfaces more engaging."),
        TDModel(title: "Build a Responsive App", details: "Design a layout that adapts seamlessly to different screen sizes and orientations."),
    ])
}
