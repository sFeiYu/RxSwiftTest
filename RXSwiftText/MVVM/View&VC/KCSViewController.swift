//
//  KCSViewController.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/8/26.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import UIKit
import SnapKit

class KCSViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "mine_charisma_back_p"), style: .plain, target: self, action: #selector(didTapBackButton))
            var backButtonImage = UIImage(named: "mine_charisma_back_p")
            backButtonImage = backButtonImage?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.leftBarButtonItem?.image = backButtonImage
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:16),NSAttributedString.Key.foregroundColor:UIColor.colorCustom(hexString: "22242a")]
        let imgBg = UIImage.colorToImage(color: UIColor.white)
        self.navigationController?.navigationBar.setBackgroundImage(imgBg, for: .default)
        self.navigationController?.navigationBar.shadowImage = imgBg
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //启用右滑返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc func didTapBackButton() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
