//
//  HomeViewController.swift
//  ProductsAppTestTask
//
//  Created by Javier Heisecke on 2023-01-23.
//

import UIKit
import SwinjectStoryboard

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeViewModelProtocol?
    var productList: ProductsList?
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupObservables()
        fetchData()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController {
    
    private func fetchData() {
        viewModel?.getAllProducts()
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    
    private func setupObservables() {
        viewModel?.allProducts.observeNext(with: { [weak self] productList in
            guard let productList = productList else { return }
            if productList.count > 0 {
                self?.productList = productList
            }
            self?.collectionView.reloadData()
        })
        .dispose(in: bag)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell()}
        
        guard let product = productList?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.configure(product: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = productList?[indexPath.row]
        performSegue(withIdentifier: "goToProductDetail", sender: nil)
    }
    
}

extension HomeViewController {
    
    override func show(_ vc: UIViewController, sender: Any?) {
        guard let vc = vc as? ProductDetailViewController else { return }
        vc.product = selectedProduct
        self.navigationController?.show(vc, sender: nil)
    }
}
