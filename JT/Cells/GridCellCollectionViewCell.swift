//
//  GridCellCollectionViewCell.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import UIKit
import SDWebImage
class GridCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var decriptionText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
    private var isFavorite: Bool = false
    private var movie: Movie?
    var onFavoriteToggle: ((Movie, Bool) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func configure(with movie: Movie) {
//        decriptionText.text = movie.trackName
//        currencyLabel.attributedText = TextHelper().formattedText(text: (movie.currency ?? "") + " \(movie.trackPrice ?? 0)")
//        
//        imageView.sd_setImage(with: URL(string: movie.artworkUrl100 ?? ""), placeholderImage: UIImage(named: "placeholder"))
//       }

    func configure(with movie: Movie, isFavorite: Bool) {
            self.movie = movie
            self.isFavorite = isFavorite
            decriptionText.text = movie.trackName
            currencyLabel.attributedText = TextHelper().formattedText(text: (movie.currency ?? "") + " \(movie.trackPrice ?? 0)")
            
            imageView.sd_setImage(with: URL(string: movie.artworkUrl100 ?? ""), placeholderImage: UIImage(named: "placeholder"))
            
            updateFavoriteButton()
        }
    private func updateFavoriteButton() {
        let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favButton.setImage(favoriteImage, for: .normal)
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let movie = movie else { return }
        isFavorite.toggle()
        onFavoriteToggle?(movie, isFavorite)
        updateFavoriteButton()
    }
}
