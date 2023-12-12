//
//  CastView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 22/8/23.
//

import SwiftUI

struct CastView: View {
    let cast: CastProfile
    
    var body: some View {
        VStack {
            AsyncImage(url: cast.photoURL) { img in
                img.resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 120)
        }
            Text(cast.name)
                .foregroundColor(.white)
                .frame(width: 100)
                .lineLimit(1)
        }
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(cast: CastProfile(id: 1, name: "saw", profile_path:
                                    Constants.getMockImageURL() + "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg"))
    }
}
