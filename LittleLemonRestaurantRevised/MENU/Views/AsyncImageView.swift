//
//  AsyncImageView.swift
//  LittleLemonRestaurantRevised
//
//  Created by idevF on 13.05.2023.
//

import SwiftUI

struct AsyncImageView: View {
//    let item: JSONMenu.MenuItem
    let item: MenuItemEntity
    
    var body: some View {
        AsyncImage(url: URL(string: item.entityImage)) { phase in
            if let image = phase.image {
                image // Displays the loaded image.
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            } else if phase.error != nil {
                Text("There was an error loading the image.")
                    .font(.system(.footnote, design: .rounded, weight: .ultraLight))
            } else {
                ProgressView()
                    .tint(Color("secondaryOne"))
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
   
    static var previews: some View {
        AsyncImageView(item: MenuItemEntity.example(context))
    }
}
