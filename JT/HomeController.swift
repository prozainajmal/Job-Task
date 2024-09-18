//
//  ViewController.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import UIKit
import ShimmerSwift

class HomeController: UIViewController {
    // Create the array with images and text
   
    @IBOutlet weak var mainCollectionView: UICollectionView!
  
  

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
           
           // Bind the ViewModel to update the view when data is available
           setupBindings()
                   
        viewModel.fetchMovies()
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







}


extension  HomeController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return viewModel.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCellCollectionViewCell", for: indexPath) as! GridCellCollectionViewCell
        
        
        let movie = viewModel.movies[indexPath.row]
                cell.configure(with: movie)
       
        
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
       
        return CGSize(width: mainCollectionView.frame.width/2.2, height: 280)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
       
    }
}

