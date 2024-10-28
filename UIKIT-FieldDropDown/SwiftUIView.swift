//
//  SwiftUIView.swift
//  UIKIT-FieldDropDown
//
//  Created by Samuel on 10/25/24.
//

import SwiftUI

struct SwiftUIView: View {

        @State private var textFieldValue: String = ""
        @State private var secondTextFieldValue: String = ""
        @State private var dataSource: [Any] = []
        @State private var showDropDown = false
        @State private var dropDownType: DropDownType = .tf
        @State private var selectedFrame: CGRect = .zero
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) {
                    CustomTextField(placeholder: "Enter name", text: $textFieldValue, onEditingChanged: {
                        dropDownType = .tf
                        dataSource = ["Fitz3", "Samuel", "Maxwell"]
                        showDropDown.toggle()
                    })
                    .overlay(GeometryReader { geometry in
                        Color.clear.onAppear {
                            selectedFrame = geometry.frame(in: .global)
                        }
                    })
                    
                    CustomTextField(placeholder: "Enter number", text: $secondTextFieldValue, onEditingChanged: {
                        dropDownType = .secondTf
                        dataSource = [4, 2, 8, 10, 45, 2,5, 5,6,7, 2]
                        showDropDown.toggle()
                    })
                    .overlay(GeometryReader { geometry in
                        Color.clear.onAppear {
                            selectedFrame = geometry.frame(in: .global)
                        }
                    })
                }
                .padding()
                
                if showDropDown {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                showDropDown = false
                            }
                        }
                    
                    DropDownList(dataSource: dataSource, selectedFrame: selectedFrame) { selectedItem in
                        withAnimation {
                            showDropDown = false
                        }
                        switch dropDownType {
                            case .tf:
                                textFieldValue = "\(selectedItem)"
                            case .secondTf:
                                secondTextFieldValue = "\(selectedItem)"
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
    
    struct CustomTextField: View {
        var placeholder: String
        @Binding var text: String
        var onEditingChanged: () -> Void
        
        var body: some View {
            TextField(placeholder, text: $text, onEditingChanged: { isEditing in
                if isEditing {
                    onEditingChanged()
                }
            })
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
    
    struct DropDownList: View {
        var dataSource: [Any]
        var selectedFrame: CGRect
        var onSelect: (Any) -> Void
        
        var body: some View {
            DropDownTableViewWrapper(dataSource: dataSource, onSelect: onSelect)
                .frame(width: selectedFrame.width, height: min(CGFloat(dataSource.count) * 50, 200))
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 10)
                .position(x: selectedFrame.midX, y: selectedFrame.maxY + 50)
        }
    }
    
    struct DropDownTableViewWrapper: UIViewControllerRepresentable {
        var dataSource: [Any]
        var onSelect: (Any) -> Void
        
        func makeUIViewController(context: Context) -> UITableViewController {
            let tableViewController = UITableViewController()
            tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableViewController.tableView.delegate = context.coordinator
            tableViewController.tableView.dataSource = context.coordinator
            return tableViewController
        }
        
        func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
            context.coordinator.dataSource = dataSource
            uiViewController.tableView.reloadData()
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self, onSelect: onSelect)
        }
        
        class Coordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
            var parent: DropDownTableViewWrapper
            var dataSource: [Any]
            var onSelect: (Any) -> Void
            
            init(_ parent: DropDownTableViewWrapper, onSelect: @escaping (Any) -> Void) {
                self.parent = parent
                self.dataSource = parent.dataSource
                self.onSelect = onSelect
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return dataSource.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = "\(dataSource[indexPath.row])"
                return cell
            }
            
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let selectedItem = dataSource[indexPath.row]
                onSelect(selectedItem)
            }
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 50
            }
        }
    }

#Preview {
    SwiftUIView()
}
