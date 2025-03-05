//
//  ToDoListView .swift
//  ADHD Green
//
//  Created by Fereshte Ehsani on 03/03/25.
//

import SwiftUI

struct ToDoListView: View {
    @State private var taskTitle: String = ""
    @State private var taskNote: String = ""
    @State private var selectedDate: Date = Date()
    @State private var tasks: [Task] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("To Do List")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 10)
                
                Form {
                    // بخش افزودن کار جدید
                    Section(header: Text("New Task")) {
                        TextField("Enter task title", text: $taskTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextEditor(text: $taskNote)
                            .frame(height: 100)
                            .border(Color.gray, width: 0.5)
                            .cornerRadius(5)
                            .padding(.top, 5)
                        
                        DatePicker("Select Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        
                        // دکمه افزودن وظیفه
                        Button(action: saveTask) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add Task")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 0.36, green: 0.47, blue: 0.42))
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        // لیست کارهای ثبت‌شده
                        Section(header: Text("Your Tasks")) {
                            List {
                                ForEach(tasks) { task in
                                    VStack(alignment: .leading) {
                                        Text(task.title)
                                            .font(.headline)
                                        Text(task.note)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Text("📅 \(task.date.formatted(date: .abbreviated, time: .shortened))")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .onDelete(perform: deleteTask) // قابلیت حذف وظایف
                            }
                        }
                    }
                }
            }
        }
    }
    
    // تابع ذخیره وظایف
    func saveTask() {
        let newTask = Task(title: taskTitle, note: taskNote, date: selectedDate)
        tasks.append(newTask)
        taskTitle = ""
        taskNote = ""
        selectedDate = Date()
    }
    
    // تابع حذف وظایف
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // مدل داده‌ای برای ذخیره وظایف
    struct Task: Identifiable {
        var id = UUID()
        var title: String
        var note: String
        var date: Date
    }
    
    struct ToDoListView_Previews: PreviewProvider {
        static var previews: some View {
            ToDoListView()
        }
    }
}
