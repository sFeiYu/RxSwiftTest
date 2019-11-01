//
//  GitHubNetworkService.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/11/1.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import UIKit

//扩展String
extension String {
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}

class GitHubNetworkService: KCSBaseViewModel {
    
    func usernameAvailable(username:String) -> Observable<Bool> {
        //通过检查这个用户的GitHub主页是否存在来判断用户是否存在
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { pair in
                return pair.response.statusCode == 404
                 }
        .catchErrorJustReturn(false)
    }
    
    func signup(username:String, password:String) -> Observable<Bool> {
        let signupResult = arc4random() % 3 == 0 ? false : true
        return Observable.just(signupResult)
            .delay(.milliseconds(1500), scheduler: MainScheduler.instance)
    }
}
