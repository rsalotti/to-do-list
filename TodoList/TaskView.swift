//
//  TaskView.swift
//  TodoList
//
//  Created by Ricardo Salotti on 15/09/25.
//

import SwiftUI

struct TaskView: View {
    var item: TDModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .gray)
                .frame(maxHeight: .infinity, alignment: .top)
                .font(.title2)
            VStack(alignment: .leading) {
                HStack{
                    Text(item.title)
                        .font(.title2)
                        .strikethrough(item.isCompleted)
                    Spacer()
                    Image(systemName: "pencil")
                        .frame(width: 30, height: 30)
                        .background(.thinMaterial, in: Circle())
                        .offset(x: 5, y: -5)
                }
                Text(item.details)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.thinMaterial, in: .rect(cornerRadius: 12))
            .animation(.none, value: item.isCompleted)
            Spacer()
        }
    }
}

#Preview {
    TaskView(item: TDModel(title: "Complete SwiftUI Tutorial", details: "Follow the latest SwiftUI tutorial to enhance your UI building skills and explore new features."))
}


