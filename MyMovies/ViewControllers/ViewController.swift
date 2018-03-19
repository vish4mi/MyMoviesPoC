//
//  ViewController.swift
//  MyMovies
//
//  Created by Vishal on 17/03/18.
//  Copyright © 2018 Vishal Bhadade. All rights reserved.
//

import UIKit
import CoreStore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoreData()
        launchMoviesGrid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCoreData() -> Void {
        do {
            try CoreStore.addStorageAndWait()
        } catch {
        }
    }
    
    func launchMoviesGrid() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moviesViewController = MoviesGridCollectionViewController(nibName: "MoviesGridCollectionViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: moviesViewController)
        appDelegate.window?.rootViewController = navigationController
    }

}

