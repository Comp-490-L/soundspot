//
//  PlayerView.swift
//  soundspot
//
//  Created by James Maturino on 10/17/21.
//

import Foundation
import SwiftUI
import AVFoundation


struct PlayerView : View
{
	@StateObject var viewModel : PlayerViewModel
    
    
    var body: some View
    {
        
        VStack
        {
            if(viewModel.trackList[viewModel.trackIndex].pictureData == nil && !viewModel.trackList[viewModel.trackIndex].pictureDownloaded){
                Image("defaultTrackImg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 1)
					.padding(20)
            }else{
				if let data = viewModel.trackList[viewModel.trackIndex].pictureData{
					if let uiImage = UIImage(data: data){
						Image(uiImage: uiImage)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.shadow(radius: 1)
							.padding(20)
					}
				}
            }
            
            Text(viewModel.trackList[viewModel.trackIndex].title)
                .foregroundColor(Color.gray)
				.padding()
				.font(.title2)
				.lineLimit(1)
           
           
            ZStack
            {
                VStack{
                    PlayerSlider(viewModel: viewModel)
                    HStack{
                        Text(viewModel.progress)
                        Spacer()
                        Text(viewModel.trackLength)
                    }.padding(.leading).padding(.trailing)
                    PlayerControllers(viewModel: viewModel)
        
                }
            }
        }.onAppear{
            viewModel.onEvent(event: MusicPlayerEvent.Launched) 
        }.background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    struct PlayerSlider : View {
        @ObservedObject var viewModel : PlayerViewModel
        var body: some View{
            Slider(value: Binding<Double>(
                get: {viewModel.progressPercentage},
                set: {
                    viewModel.onEvent(event: MusicPlayerEvent.DraggingSlider)
                    viewModel.progressPercentage = $0
                }
            ),
                   in: 0 ... 100, step: 1){
                // if dragging ended update music player
                if !$0 {
                       viewModel.onEvent(event: MusicPlayerEvent.SliderChanged)
                   }
            }.padding(.leading).padding(.trailing)
        }
    }
    
    struct PlayerControllers : View {
        @ObservedObject var viewModel : PlayerViewModel
        var body: some View{
            HStack
            {
                Button(action: {viewModel.onEvent(event: MusicPlayerEvent.ShufflePressed)
                    }, label: {
                        Image(systemName: viewModel.isShuffle ? "shuffle.circle.fill" : "shuffle.circle").resizable()
                        .foregroundColor(.purple)
                }).frame(width: 70, height: 70, alignment: .center)
                
                Button(action: {
                    viewModel.onEvent(event: MusicPlayerEvent.PreviousPressed)
                },  label: {
                    Image("previousTrack").resizable()
                }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.gray.opacity(0.2))
                   
                
                Button(
                    action: {viewModel.onEvent(event: MusicPlayerEvent.PlayPausePressed)},
                       label: {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .foregroundColor(Color.pink)
                }).frame(width: 70, height: 70, alignment: .center)
                
                Button(action: {
                    viewModel.onEvent(event: MusicPlayerEvent.NextPressed)
                }, label: {
                    Image("nextTrack").resizable()
                }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.gray.opacity(0.2))
                
                Button(action: {viewModel.onEvent(event: MusicPlayerEvent.LikePressed)
                    }, label: {
                        Image(systemName: viewModel.isLiked ? "heart.fill" : "heart").resizable()
                        .foregroundColor(.purple)
                }).frame(width: 70, height: 70, alignment: .center)
            }
        }
    }
}











struct PlayerView_Previews: PreviewProvider {
     
    static func getMusicModel() ->  Array<Track>{
		let model = Track(id: "", name: "music Name", link: "", trackDownloaded: false, pictureLink: nil, pictureDownloaded: false, pictureData: nil, isLiked: true, owner: true, streams: 22)
        
        var list = Array<Track>()
        list.append(model)
        return list
    }
    
    static var previews: some View {
    
    let list = PlayerView_Previews.getMusicModel()
		PlayerView(viewModel: PlayerViewModel.instancePlayTracks(tracksList: list, index: 0))
                .previewDevice("iPhone 13 Pro")
    }
}


