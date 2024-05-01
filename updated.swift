import SwiftUI

struct Assignments: View {
    @State var name = ""
    @State var description = ""
    @State var showingAlert = false
    @State var nameSaveArray:[String] = []
    @State var descriptionSaveArray:[String] = []
    @State var descriptionRetrieve = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
    @State var screenWidth = UIScreen.main.bounds.width
   
    
    
    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    showingAlert = true
                }, label: {
                    Text("Add Assignment")
                })
                .offset(y: 5)
            }
            .alert("Assignment Info", isPresented: $showingAlert) {
                TextField("Assignment Name", text: $name)
                TextField("Assignment Desciption", text: $description)
                Button("OK", role: .cancel) { 
                    
                    nameSaveArray.append(name)
                    
                    descriptionSaveArray.append(description)
                    
                    UserDefaults.standard.set(nameSaveArray, forKey: "name")
                    UserDefaults.standard.set(descriptionSaveArray, forKey: "description")
                }
            }
            Divider()
            NavigationStack {
                Divider()
                List{
                    ForEach(Array(zip(nameSaveArray, descriptionSaveArray)), id: \.0) { item in
                        NavigationLink {
                            Text("\(item.0): \n\(item.1)")
                                .multilineTextAlignment(.leading)
                                .font(.title)
                                .padding(20)
                        } label: {
                            Text("\(item.0): \n\(item.1)")
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    .onDelete { indexSet in
                        nameSaveArray.remove(atOffsets: indexSet)
                        descriptionSaveArray.remove(atOffsets: indexSet)
                        UserDefaults.standard.set(nameSaveArray, forKey: "name")
                        UserDefaults.standard.set(descriptionSaveArray, forKey: "description")
                    }
                    .onMove { indexSet, index in
                        nameSaveArray.move(fromOffsets: indexSet, toOffset: index)
                        descriptionSaveArray.move(fromOffsets: indexSet, toOffset: index)
                        UserDefaults.standard.set(nameSaveArray, forKey: "name")
                        UserDefaults.standard.set(descriptionSaveArray, forKey: "description")
                    }
                }
                .toolbar {
                    EditButton()
                        .font(.title)
                        .frame(width: screenWidth/2 , alignment: .center)
                    
                    
                }
                
                
                
            }
            .onAppear(perform: {
                nameSaveArray = UserDefaults.standard.array(forKey: "name") as! [String]? ?? []
                descriptionSaveArray = UserDefaults.standard.array(forKey: "description") as! [String]? ?? []
            })
        }
    }
    
}
