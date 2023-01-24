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
    var activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservables()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.setEnabledCart()
    }
    
    @objc func clearCart() {
        self.simpleAlert(
            title: "Clear Cart",
            message: "You will be removing \(AppData.cart.products.count) products off you cart",
            completion: { [weak self] _ in
                guard let self else { return }
                self.viewModel?.clearCart()
            }
        )
    }
    
    @objc func logout() {
        self.setRootViewController("Login")
    }
    
}

//MARK: Set up

extension HomeViewController {
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "cart"), style: .plain, target: self, action: #selector(clearCart))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout-icon"), style: .plain, target: self, action: #selector(logout))
        configActivityIndicator()
        setupCollectionView()
    }
    
    private func configActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.color = UIColor(named: "brand-font")
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel?.getAllProducts()
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    
    private func setupObservables() {
        viewModel?.enableCart.bind(to: navigationItem.rightBarButtonItem!.reactive.isEnabled)

        viewModel?.allProducts.observeNext(with: { [weak self] productList in
            self?.activityIndicator.stopAnimating()
            guard let productList = productList else { return }
            if productList.count > 0 {
                self?.productList = productList
            }
            self?.collectionView.reloadData()
        })
        .dispose(in: bag)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionViewID", for: indexPath)
            guard let typedHeaderView = headerView as? HeaderCollectionView
            else { return headerView }
            return typedHeaderView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Navigation

extension HomeViewController {
    
    override func show(_ vc: UIViewController, sender: Any?) {
        guard let vc = vc as? ProductDetailViewController else { return }
        vc.product = selectedProduct
        self.navigationController?.show(vc, sender: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
        let size = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size - 25, height: size - 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
