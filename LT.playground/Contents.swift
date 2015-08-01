//: Playground - noun: a place where people can play

import UIKit

var num: Int? // まだ初期化されていない

num = 5 // 5 という値に初期化された

// Optional 型の値の取り出し方
if let validNum = num { // num には何らかの値が入っている
	print("num: \(num)")
	print("validNum: \(validNum)")
}
else {
	print("num: \(num)")
}

// 変数をやたらと増やしたくないとき: wild card
if let _ = num {
	print("num: \(num)")
	print("value in num: \(num!)")
}
else {
	print("num: \(num)")
	print("value in num: \(num!)")
}

// return value を Optional にする
let frame = CGRectMake(0, 0, 100, 50)
let label = UILabel(frame: frame)
func setupLabelText (text: String) {
	label.text = text
}

func getLabelText () -> String? {
	return label.text
}

func printLabelText () {
	if let text = getLabelText() {
		print("label.text = " + text)
	}
	else {
		print("label does not have any text")
	}
}

//setupLabelText("Hello, world")
printLabelText()

// 引数を Optional にする
func getBearerTokenByFB (accessToken: String) {
	if let url = NSURL(string: "exampleURL&accessToken=" + accessToken) {
		// API 叩く
		print("\(url)")
	}
	else {
		// エラー処理
	}
}

func getBearerTokenByTwitter (accessToken: String, accessTokenSecret: String) {
	if let url =
		NSURL(string: "exampleURL&accessToken=" + accessToken + "&accessTokenSecret=" + accessTokenSecret) {
		 // API 叩く
		print("\(url)")
	}
	else {
		// エラー処理
	}
}

// 1つにまとめる
func getBearerToken (accessToken: String, accessTokenSecret: String?) {
	var urlStr: String?
	if let validSecret = accessTokenSecret {
		// url for Twitter
		urlStr = "exampleURL&accessToken=" + accessToken +
			"&accessTokenSecret=" + validSecret
	}
	else {
		// url for FB
		urlStr = "exampleURL&accessToken=" + accessToken
	}
	
	if let validUrlStr = urlStr, url = NSURL(string: validUrlStr) {
		// API 叩く
		print("\(url)")
	}
	else {
		// エラー処理
	}
}

// Either 型
enum Either<L, R> {
	case Left (L)
	case Right (R)
	
	func left () -> L? {
		switch self {
		case .Left(let l):
			return l
		case .Right(_):
			return nil
		}
	}
	
	func right () -> R? {
		switch self {
		case .Right(let r):
			return r
		case .Left(_):
			return nil
		}
	}
	
	func left (l: L) -> Either<L, R> {
		return .Left (l)
	}
	
	func right (r: R) -> Either<L, R> {
		return .Right (r)
	}
}

let failurable = Either<Int, NSError>.Left(3)
print("\(failurable.left())")
print("\(failurable.right())")

// lazy var
class someClass: UIViewController {
	lazy var someButton = UIButton()
	lazy var someLabel = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSomeButton()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func setupSomeButton () {
		let frame = CGRectMake(0, 0, 50, 20)
		someButton.frame = frame
		someButton.setTitle("push!", forState: .Normal)
		someButton.addTarget(self, action: "pushedButton:", forControlEvents: .TouchUpInside)
		self.view.addSubview(someButton)
	}
	
	func pushedButton (sender: UIButton) {
		setupSomeLabel("pushed button")
	}
	
	func setupSomeLabel (text: String) {
		let frame = CGRectMake(0, 0, 100, 50)
		someLabel.frame = frame
		someLabel.text = text
		self.view.addSubview(someLabel)
	}
}

