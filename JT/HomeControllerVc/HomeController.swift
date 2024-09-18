//
//  HomeController.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//
//
//  ViewController.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import UIKit
import ShimmerSwift

class HomeController: UIViewController, UITextFieldDelegate  {
    // Create the array with images and text
   
    @IBOutlet weak var searchbar: UITextField!
    @IBOutlet weak var mainCollectionView: UICollectionView!
  
    private var debounceTimer: Timer?
    private let debounceDelay: TimeInterval = 1
    private let noDataView = NoDataView()
//
////        let myview = UIView()
////        myview.backgroundColor = .systemGray2
////        let shimmerview = ShimmeringView(frame: CGRect(x: 0, y: 30, width: 600, height: 200))
////        view.addSubview(shimmerview)
////        shimmerview.contentView = myview
////
////        shimmerview.isShimmering = true
//
//        // Do any additional setup after loading the view.
//    }

    private let viewModel = MovieViewModel()
     
     

       override func viewDidLoad() {
           super.viewDidLoad()
           
           let nib = UINib(nibName: "GridCellCollectionViewCell", bundle: nil)
               mainCollectionView.register(nib, forCellWithReuseIdentifier: "GridCellCollectionViewCell")
           searchbar.delegate = self
           // Bind the ViewModel to update the view when data is available
           setupBindings()
           setupNoDataView()
        viewModel.fetchMovies()
       }
    
    private func setupNoDataView() {
            noDataView.frame = view.bounds
            noDataView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(noDataView)
            noDataView.isHidden = true // Initially hidden
        }

        private func updateNoDataViewVisibility() {
            print("Movies count: \(viewModel.movies.count)") // Debugging line
            let isEmpty = viewModel.movies.isEmpty
            noDataView.isHidden = !isEmpty
            print("NoDataView isHidden: \(noDataView.isHidden)") // Debugging line
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Cancel previous timer
            debounceTimer?.invalidate()
            
            // Start a new timer
            debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceDelay, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                if let searchTerm = searchbar.text, !searchTerm.isEmpty {
                    self.viewModel.fetchMovies(searchTerm: searchTerm)
                    textField.resignFirstResponder() // Dismiss the keyboard
                }
            }
            
            return true
        }
        private func setupBindings() {
            viewModel.didUpdateMovies = { [weak self] in
                DispatchQueue.main.async {
                    self?.mainCollectionView.reloadData()
                }
            }
            
            viewModel.errorMessage = { [weak self] message in
                DispatchQueue.main.async {
                    self?.showAlert(message: message)
                }
            }
        }
        
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
 
    
    
    
    @IBAction func heartButton(_ sender: UIButton) {
      
//        let favViewController = FavView(nibName: "FavView", bundle: nil)
//
//               // Push the view controller onto the navigation stack
//               navigationController?.pushViewController(favViewController, animated: true)
//
        let newViewController = FavView(nibName: "FavView", bundle: nil)

        // Present the new view controller
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func favButton(_ sender: Any) {
        
    }
    
    
}




extension  HomeController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCellCollectionViewCell", for: indexPath) as! GridCellCollectionViewCell
         
        let movie = viewModel.movies[indexPath.row]
           let isFavorite = viewModel.isFavorite(movie: movie)
           cell.configure(with: movie, isFavorite: isFavorite)
           
           // Handle favorite toggle
           cell.onFavoriteToggle = { [weak self] movie, isFavorite in
               if isFavorite {
                   self?.viewModel.addToFavorites(movie: movie)
               } else {
                   self?.viewModel.removeFromFavorites(movie: movie)
               }
           }
       
        
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
            return 8
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: mainCollectionView.frame.width/2.2, height: 250)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
       
    }
}

