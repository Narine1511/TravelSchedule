import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack {
            Color("ypDark")
                .ignoresSafeArea()
            ZStack(alignment: .bottomLeading) {
                Image(story.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            /*.padding(.horizontal, 8)*/
            .padding(.top, 60)
            .padding(.bottom, 40)
        }
            
            }
            
        }
        
        #Preview {
            StoryView(story: .story1)
        }
