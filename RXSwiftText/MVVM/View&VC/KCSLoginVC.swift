//
//  KCSLoginVC.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/8/26.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import UIKit
import SnapKit

class KCSLoginVC: KCSViewController {

    @IBOutlet weak var lblTitle: UILabel!    
    @IBOutlet weak var txfPhone: UITextField!
    @IBOutlet weak var btnGetCode: UIButton!
    @IBOutlet weak var txfCode: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    let btnWechat = UIButton(type: .custom)
    let btnQQ = UIButton(type: .custom)
    
    
    /*
    
    //数据
    let existData = KCSPhoneExistData()
    let codeMakeData = KCSAuthCodeMakeVestData()
    let loginData = KCSPhoneLoginVestData()
    let registerData = KCSPhoneRegisterVestData()
    let thirdExistData = KCSAuthorizeUserExistVestData()
    let thirdLoginData = KCSAuthorizeUserLoginVestData()
    let thirdRegisterData = KCSAuthorizeUserRegisterVestData()

    var notifUtil:KCSNotificationUtil?
 */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI();
//        loadData();
//        autoLogin()
        /*
        KCSUtils.showPrivacyPolicyAlert {
            
        }
 */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func loadUI() -> Void {
        
        txfPhone.keyboardType = .numberPad;
        txfCode.keyboardType = .numberPad
  
        btnGetCode.layer.cornerRadius = 18;
        btnGetCode.layer.masksToBounds = true;
        btnGetCode.setTitle("验证码", for: .normal)
//        btnGetCode.addTarget(self, action: #selector(getCodeAction(btn:)), for: .touchUpInside)
        
        btnLogin.setBackgroundImage(UIImage.colorToImage(color: UIColor.colorCustom(hexString: "CB47FD")), for: .normal)
//        btnLogin.addTarget(self, action: #selector(loginAction(btn:)), for: .touchUpInside)
        
        let vwCenter = UIView()
        self.view.addSubview(vwCenter)

        let lblLeft = UILabel()
        self.view.addSubview(lblLeft)
        lblLeft.text = "登录即表示你同意"
        lblLeft.textColor = UIColor.colorCustom(hexString: "#BBBBBB")
        lblLeft.font = UIFont.systemFont(ofSize: 12)

        let btnUserAgreement = UIButton.init(type: .custom)
        self.view.addSubview(btnUserAgreement)
        btnUserAgreement.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnUserAgreement.setTitle("音友用户协议", for: .normal)
        btnUserAgreement.setTitleColor(UIColor.colorCustom(hexString: "CB47FD"), for: .normal)
        btnUserAgreement.setTitleColor(UIColor.colorCustom(hexString: "CB47FD", alpha: 0.5), for: .highlighted)
//        btnUserAgreement.addTarget(self, action: #selector(userAgreementAction), for: .touchUpInside)

        let lblRight = UILabel()
        self.view.addSubview(lblRight)
        lblRight.text = "和"
        lblRight.textColor = UIColor.colorCustom(hexString: "#BBBBBB")
        lblRight.font = UIFont.systemFont(ofSize: 12)

        let btnPrivacy = UIButton.init(type: .custom)
        self.view.addSubview(btnPrivacy)
        btnPrivacy.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnPrivacy.setTitle("隐私协议", for: .normal)
        btnPrivacy.setTitleColor(UIColor.colorCustom(hexString: "CB47FD"), for: .normal)
        btnPrivacy.setTitleColor(UIColor.colorCustom(hexString: "CB47FD", alpha: 0.5), for: .highlighted)
//        btnPrivacy.addTarget(self, action: #selector(privacyAction), for: .touchUpInside)
        
        self.view.addSubview(btnWechat)
        btnWechat.setBackgroundImage(UIImage(named: "lgwechat"), for: .normal)
//        btnWechat.addTarget(self, action: #selector(wechatAction(btn:)), for: .touchUpInside)
        btnWechat.isHidden = true
        
        self.view.addSubview(btnQQ)
        btnQQ.setBackgroundImage(UIImage(named: "lgqq"), for: .normal)
//        btnQQ.addTarget(self, action: #selector(QQAction(btn:)), for: .touchUpInside)
        btnQQ.isHidden = true

        vwCenter.snp.makeConstraints { [weak self](make) in
            make.centerX.equalTo((self?.view.snp.centerX)!)
        }

        lblLeft.snp.makeConstraints { (make) in
            make.left.equalTo(vwCenter.snp.left)
            make.bottom.equalTo(self.view.snp.bottom).offset(-13-IPHONEX_INSETS().bottom)
        }

        btnUserAgreement.snp.makeConstraints { (make) in
            make.left.equalTo(lblLeft.snp.right)
            make.centerY.equalTo(lblLeft.snp.centerY)
        }

        lblRight.snp.makeConstraints { (make) in
            make.left.equalTo(btnUserAgreement.snp.right)
            make.centerY.equalTo(lblLeft.snp.centerY)
        }

        btnPrivacy.snp.makeConstraints { (make) in
            make.left.equalTo(lblRight.snp.right)
            make.centerY.equalTo(lblLeft.snp.centerY)
            make.right.equalTo(vwCenter.snp.right)
        }
        
        btnWechat.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(80)
            make.bottom.equalTo(lblLeft.snp.top).offset(-15)
        }
        
        btnQQ.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-80)
            make.bottom.equalTo(lblLeft.snp.top).offset(-15)
        }
        
//        if (UMSocialManager.default()?.isInstall(.wechatSession))! {
//            btnWechat.isHidden = false
//        }
//
//        if (UMSocialManager.default()?.isInstall(.QQ))! {
//            btnQQ.isHidden = false
//        }
        
    }

    /*
    //MARK: - 业务
    func loadData() -> Void {
        lblTitle.text = "音友";
        
        notifUtil = KCSNotificationUtil(vc: self)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tapGes)
    }
    
    func startTimer() -> Void {
        
        
        let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).share(replay: 1)
        timer.map{$0 >= 60 ? "验证码":"\(60-$0)s"}
            .bind(to: btnGetCode.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        timer.map{$0 >= 60}
            .bind(to: btnGetCode.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        
        timer.map{$0 >= 60}.subscribe(onNext: { [weak self](isOver) in
            if isOver {
                //通过重新创建，释放前面的包裹
                self?.disposeBag = DisposeBag()
            }
            }).disposed(by: disposeBag)
        
//        if codeTimer != nil {
//            codeTimer?.invalidate()
//            codeTimer = nil
//        }
//        btnGetCode.isUserInteractionEnabled = false
//        self.count = 60;
//        codeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleTime), userInfo: nil, repeats: true)
//        btnGetCode.setTitle("\(self.count)s", for: .normal)
    
    }
    
//    @objc func handleTime() -> Void {
//        self.count = self.count - 1
//        if self.count == 0 {
//            codeTimer?.invalidate()
//            codeTimer = nil
//            btnGetCode.isUserInteractionEnabled = true
//            btnGetCode.setTitle("验证码", for: .normal)
//        }else{
//            btnGetCode.setTitle("\(self.count)s", for: .normal)
//        }
//    }
    
    func autoLogin() -> Void {
        PersonInfoManager.shareInfo.getLocalInfo()
        if (PersonInfoManager.shareInfo.memberID?.count)! > 0 &&
            PersonInfoManager.shareInfo.passWord.count > 0{
            KCSUtils.showLoading(onView:self.view)
            self.txfPhone.text = PersonInfoManager.shareInfo.phoneNumber
            requestLogin(loginCheckType: "2", passWord: PersonInfoManager.shareInfo.passWord, isValid:"Yes")
        }else if PersonInfoManager.shareInfo.userID.count > 0 &&
                 PersonInfoManager.shareInfo.unionID.count > 0 &&
                 PersonInfoManager.shareInfo.userType.count > 0 &&
                 PersonInfoManager.shareInfo.memberID!.count > 0{
            KCSUtils.showLoading(onView:self.view)
            thirdLogin(userId: PersonInfoManager.shareInfo.userID, unionid: PersonInfoManager.shareInfo.unionID, userType: PersonInfoManager.shareInfo.userType, isValid: "Yes")
        }
    }
    
    /** 完善资料登录 */
    func completeLogin() -> Void {
        requestLogin(loginCheckType: "2", passWord: PersonInfoManager.shareInfo.passWord, isValid:"No")
    }
    
    //MARK: - Actions
    
    @objc func tapAction() -> Void {
        if txfPhone.isFirstResponder {
            txfPhone.resignFirstResponder()
        }
        if txfCode.isFirstResponder {
            txfCode.resignFirstResponder()
        }
    }
    
    @objc func getCodeAction(btn:UIButton) -> Void {
        if txfPhone.text?.count != 11 ||
            txfPhone.text?.count == 0 {
            UIView.markToast("请输入正确的手机号码")
            return
        }
        UIView.markToast("点击了")
        startTimer()
        requestPhoneExist()
        
    }
    
    @objc func loginAction(btn:UIButton) -> Void {
        
        if txfPhone.text?.count != 11 ||
            txfPhone.text?.count == 0 {
            UIView.markToast("请输入正确的手机号码")
            return
        }

        if txfCode.text?.count == 0 {
            UIView.markToast("请输入验证码")
            return
        }
        let userdefaults = UserDefaults.standard
        userdefaults.set("", forKey: DEFMemberId)
        userdefaults.set("", forKey: DEFUserID)
        userdefaults.set("", forKey: DEFUserType)
        userdefaults.set("", forKey: DEFUserUnionId)
        userdefaults.synchronize()
        
        if self.existData.PhoneNumberExist == "Have" {
            //登录
            requestLogin(loginCheckType: "1", passWord: "", isValid:"No")
        }else if self.existData.PhoneNumberExist == "None" {
            //注册
           requestRegister()
        }else{
            if self.existData.PhoneNumberExist.count == 0 {
                UIView.markToast("请点击验证码")
            }
        }
        
    }
    
    @objc func userAgreementAction() -> Void {
        let vc = KCSWebVC(urlStr: kH5URL + URLUserAgreement)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func privacyAction() -> Void {
        let vc = KCSWebVC(urlStr: kH5URL + URLPrivacyAgreement)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func wechatAction(btn:UIButton) -> Void {
        self.txfPhone.text = ""
        let userdefaults = UserDefaults.standard
        userdefaults.set("", forKey: DEFMemberId)
        userdefaults.set("", forKey: DEFPhoneNumber)
        userdefaults.set("", forKey: DEFPassword)
        userdefaults.synchronize()
        authLogin(platformType: .wechatSession)
    }
    
    @objc func QQAction(btn:UIButton) -> Void {
        self.txfPhone.text = ""
        let userdefaults = UserDefaults.standard
        userdefaults.set("", forKey: DEFMemberId)
        userdefaults.set("", forKey: DEFPhoneNumber)
        userdefaults.set("", forKey: DEFPassword)
        userdefaults.synchronize()
        authLogin(platformType: .QQ)
    }
    
    //MARK: - Requests
    //手机号码是否存在
    func requestPhoneExist() -> Void {
        let phoneNum = "(+86)"+txfPhone.text!
        existData.requstPhoneExist(phoneNumber: phoneNum) { [weak self](error) in
            if error != nil{
                UIView.markToast("网络有问题，请检查网络或重新启动")
            }
            if (self?.existData.isSuccess)! {
                if self?.existData.PhoneNumberExist == "Have" {
                    //登录
                    self?.requestCodeMake(authType: "5")
                }else if self?.existData.PhoneNumberExist == "None" {
                    //注册
                    self?.requestCodeMake(authType: "1")
                }
                
            }else{
                UIView.markToast(self?.existData.returnText)
            }
        }
    }
    
    //验证码产生
    func requestCodeMake(authType:String?) -> Void {
        let phoneNum = "(+86)"+txfPhone.text!
        codeMakeData.requstAuthCodeMakeVest(phoneNumber: phoneNum, authType: authType, memberID: "") { [weak self](error) in
            if (self?.codeMakeData.isSuccess)! {
                
            }else{
                 UIView.markToast(self?.codeMakeData.returnText)
            }
        }
    }
    
    //登录
    func requestLogin(loginCheckType:String?, passWord:String?, isValid:String?) -> Void {
        KCSUtils.showLoading(onView: self.view)
        let phoneNum = "(+86)"+txfPhone.text!
        loginData.requstPhoneLoginVest(phoneNumber: phoneNum, loginCheckType: loginCheckType, passWord: passWord, loginAuthCode: txfCode.text, isValid: isValid) { [weak self](error) in
            
            KCSUtils.stopLoading(onView: self?.view)
            if (self?.loginData.isSuccess)! {
                if self?.loginData.PerfectInfoFlag == "No" {
                    let completeVC = KCSCompleteVC()
                    completeVC.loginHandle = { [weak self] in
                        self?.completeLogin()
                    }
                    self?.navigationController?.pushViewController(completeVC, animated: true)
                }else if self?.loginData.PerfectInfoFlag == "Yes" {
                    self?.navigationController?.pushViewController(KCSMainTabbar(), animated: true)
                }
                
            }else{
               
                UIView.markToast(self?.loginData.returnText)
            }
        }
    }
    
    func requestRegister() -> Void {
        let phoneNum = "(+86)"+txfPhone.text!
        KCSUtils.showLoading(onView: self.view)
        registerData.requstPhoneRegisterVest(phoneNumber: phoneNum, authCode: txfCode.text) { [weak self](error) in
            KCSUtils.stopLoading(onView: self?.view)
            if (self?.registerData.isSuccess)! {
                UIView.markToast("注册成功")
                let completeVC = KCSCompleteVC()
                completeVC.loginHandle = { [weak self] in
                    self?.completeLogin()
                }
                self?.navigationController?.pushViewController(completeVC, animated: true)
            }else{
                UIView.markToast(self?.registerData.returnText)
            }
        }
    }
    
    func authLogin(platformType:UMSocialPlatformType) -> Void {
        UMSocialManager.default()?.getUserInfo(with: platformType, currentViewController: self, completion: { (result, error) in
            if error == nil {
                KCSUtils.showLoading(onView: self.view)
                let userInfo:UMSocialUserInfoResponse = result as! UMSocialUserInfoResponse
                if platformType == .QQ{
                    KCSRequestManager.requestQQUnionid(accessToken: userInfo.accessToken, handler: { (unionid) in
                        if unionid.count > 0{
                            self.thirdExist(userId: userInfo.openid, unionid: unionid, userType: "QQ", nickName: userInfo.name)
                        }else{
                            KCSUtils.stopLoading(onView: self.view)
                            UIView.markToast("授权失败，请重试：UnionID")
                        }
                    })
                }else if platformType == .wechatSession {
                    self.thirdExist(userId: userInfo.openid, unionid: userInfo.uid, userType: "WeChat", nickName: userInfo.name)
                }
                
            }else{
                UIView.markToast("授权失败，请重试")
            }
        })
    }
    
    func thirdExist(userId:String?,
                    unionid:String?,
                    userType:String?,
                    nickName:String?) -> Void {
        thirdExistData.requstAuthorizeUserExistVest(userID: userId, unionID: unionid, userType: userType) { [weak self](error) in
            if (self?.thirdExistData.isSuccess)! {
                if self?.thirdExistData.AuthorizeUserExist == "Have" {
                    /** 登录 */
                    self?.thirdLogin(userId: userId, unionid: unionid, userType: userType, isValid: "No")
                }else if self?.thirdExistData.AuthorizeUserExist == "None"{
                    /** 注册 */
                    if self?.thirdExistData.AuthorizeRegEnable == "yes"{
                        self?.thirdRegister(userId: userId, unionid: unionid, userType: userType, nickName: nickName, isValid: "No")
                    }
                }
            }else{
                KCSUtils.stopLoading(onView: self?.view)
                UIView.markToast(self?.thirdExistData.returnText)
            }
        }
    }
    
    func thirdLogin(userId:String?,
                    unionid:String?,
                    userType:String?,
                    isValid:String?) -> Void {
        thirdLoginData.requstAuthorizeUserLoginVest(userID: userId, unionID: unionid, userType: userType, isValid: isValid) { [weak self](error) in
            KCSUtils.stopLoading(onView: self?.view)
            if (self?.thirdLoginData.isSuccess)! {
                if self?.thirdLoginData.PerfectInfoFlag == "No" {
                    let completeVC = KCSCompleteVC()
                    completeVC.loginHandle = { [weak self] in
                        self?.thirdLogin(userId: userId, unionid: unionid, userType: userType, isValid: "No")
                    }
                    self?.navigationController?.pushViewController(completeVC, animated: true)
                }else if self?.thirdLoginData.PerfectInfoFlag == "Yes" {
                    self?.navigationController?.pushViewController(KCSMainTabbar(), animated: true)
                }
            }else{
                KCSUtils.stopLoading(onView: self?.view)
                UIView.markToast(self?.thirdLoginData.returnText)
            }
        }
    }
   
    func thirdRegister(userId:String?,
                       unionid:String?,
                       userType:String?,
                       nickName:String?,
                       isValid:String?) -> Void {
        thirdRegisterData.requstAuthorizeUserRegisterVest(userID: userId, unionID: unionid, userType: userType, nickName: nickName) { [weak self](error) in
            KCSUtils.stopLoading(onView: self?.view)
            if (self?.thirdRegisterData.isSuccess)! {
                UIView.markToast("注册成功")
                let completeVC = KCSCompleteVC()
                completeVC.loginHandle = { [weak self] in
                    self?.thirdLogin(userId: userId, unionid: unionid, userType: userType, isValid: "No")
                }
                self?.navigationController?.pushViewController(completeVC, animated: true)
            }else{
                UIView.markToast(self?.thirdRegisterData.returnText)
            }
        }
    }
    
 */

    

}
