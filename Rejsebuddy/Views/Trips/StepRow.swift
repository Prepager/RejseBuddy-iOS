import SwiftUI

struct StepRow: View {
    var step: RPStep
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack {
                    Text(step.origin.time)
                        .bold()
                        .foregroundColor(step.origin.rtTime == nil ? nil : Color.red)
                        .strikethrough(step.origin.rtTime != nil, color: Color.red)
                        .frame(width: 70)
                    
                    if step.origin.rtTime != nil {
                        Text(step.origin.rtTime!).bold()
                    }
                }.frame(width: 70)
                
                Text(step.origin.name)
            }
            
            HStack(alignment: .center) {
                if step.type != "WALK" {
                    Text("").frame(width: 70)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                Text(step.name)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(.white)
                            }
                            .background(Color.blue)
                            .cornerRadius(4)
                            
                            Image(systemName: "arrow.right")
                            
                            Text(step.getLineDirection())
                        }
                        
                        HStack {
                            Image(systemName: "stopwatch").font(.footnote)
                            Text(step.getDuration().prettyPrint())
                                .font(.footnote)
                                .padding(.trailing, 8)
                            
                            Image(systemName: "xmark.circle").font(.footnote)
                            Text(
                                String(step.getStops()) + " " +
                                NSLocalizedString("Stops", comment: "")
                            ).font(.footnote)
                        }
                    }
                } else {
                    Image(systemName: "hare.fill")
                        .frame(width: 70)
                        .foregroundColor(.gray)
                    
                    Text(step.notes.text.replacingOccurrences(of: ";", with: " "))
                        .font(.caption)
                }
            }
            
            HStack(alignment: .bottom) {
                VStack {
                    Text(step.destination.time)
                        .bold()
                        .foregroundColor(step.destination.rtTime == nil ? nil : Color.red)
                        .strikethrough(step.destination.rtTime != nil, color: Color.red)
                        .frame(width: 70)
                    
                    if step.destination.rtTime != nil {
                        Text(step.destination.rtTime!).bold()
                    }
                }.frame(width: 70)
                
                Text(step.destination.name)
            }
        }.padding([.top, .bottom], 8)
    }
}

struct StepRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("@wip")
        //StepRow()
    }
}
