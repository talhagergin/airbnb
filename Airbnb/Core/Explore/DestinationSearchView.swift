import SwiftUI
enum DestinationSearchOptions{
    case location
    case dates
    case guests
}
struct DestinationSearchView: View {
    @Binding var show: Bool
    @State private var destination = ""
    @State private var selectedOption: DestinationSearchOptions = .location
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numGuest = 0
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    withAnimation(.snappy){
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                Spacer()
                
                if !destination.isEmpty{
                    Button("Clear"){
                        destination = ""
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()

        
            VStack(alignment: .leading){
                if selectedOption == .location {
                    Text("Where to?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        TextField("Search destination", text: $destination)
                            .font(.subheadline)
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color(.systemGray4))
                    }
                }
                else {
                    CollapsedPickerView(title: "Where", description: "Add destination")

                }
               
            }
            .padding()
            .frame(height: selectedOption == .location ? 120 : 64)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation(.snappy){ selectedOption = .location}
            }
            
            //date selectionview
            VStack(alignment: .leading) {
                if selectedOption == .dates {
                    Text("When's your trip?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack {
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Divider()
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                } else {
                    Button(action: {
                        withAnimation(.snappy) {
                            selectedOption = .dates
                        }
                    }) {
                        CollapsedPickerView(title: "When", description: "Add dates")
                    }
                    .foregroundStyle(.black)
                }
            }
            .padding()
            .frame(height: selectedOption == .dates ? 180 : 64)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)

            // num guests view
            VStack(alignment:.leading){
                if selectedOption == .guests{
                    Text("Who's coming?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Stepper{
                        Text("\(numGuest) Guests")
                    }onIncrement: {
                        numGuest += 1
                    }onDecrement: {
                        guard numGuest > 0 else{return }
                        numGuest -= 1
                    }
                    
                    
                }else{
                    CollapsedPickerView(title: "Who", description: "Add guests")

                }
            }
            .padding()
            .frame(height: selectedOption == .guests ? 120 : 64)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
            .onTapGesture {
                withAnimation(.snappy){ selectedOption = .guests}
            }
           
               Spacer()
        }
    }
}

#Preview {
    DestinationSearchView(show: .constant(false))
}
struct CollapsibleDestinationViewModifiew: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}

struct CollapsedPickerView: View {
    let title: String
    let description: String
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(description)
            }
            .font(.subheadline)
            .fontWeight(.semibold)
        }
        
    }
}
