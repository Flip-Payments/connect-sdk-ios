# FlipConnectSDK

[![Build Status](https://www.bitrise.io/app/e2ffa72d64f58e17/status.svg?token=qyJOAroLehBPTj5D4g7clA)](https://www.bitrise.io/app/e2ffa72d64f58e17) [![codecov](https://codecov.io/gh/Flip-Payments/connect-sdk-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/Flip-Payments/connect-sdk-ios) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Flip-Payments/connect-sdk-ios/master/LICENSE) [![Github Version](https://img.shields.io/github/release/Flip-Payments/connect-sdk-ios.svg)](https://github.com/Flip-Payments/connect-sdk-ios/releases) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/FlipConnectSDK.svg)](http://cocoadocs.org/docsets/FlipConnectSDK/) ![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)

Veja mais aqui: [FlipConnectSDK Reference](http://cocoadocs.org/docsets/FlipConnectSDK/)

## Como funciona

A FlipConnectSDK funciona recebendo **ClientId** e **ClientSecret** para abrir uma página web para logar exatamente como na autenticação do Facebook e do Google. O usuário irá logar no nosso ambiente e, caso seja bem sucedido, o usuário será redirecionado para a aplicação usando a previamente configurada **RedirectURI**.

Quando a aplicação abre, a SDK irá procurar por parâmetros válidos na URI, para que então possa fazer requisições para recuperar o **access token**, o **refresh token** e a **account key**.

Com essas informações você será capaz de acessar as informações do usuário!

## Instalação

### Carthage

Coloque isto no seu Cartfile:

```yaml
github "Flip-Payments/connect-sdk-ios" ~> 0.0.4
```

e então rode o seguinte comando:

```sh
carthage update
```

### Cocoapods

Acrescente ao seu  `Podfile`

```ruby
target 'MyApplication' do
  use_frameworks!
  pod 'FlipConnectSDK', '~> 0.0.4'
end
```

## Usabilidade

### Configuração

No seu projeto, clique na aba "informação" e selecione Url Types. No campo `identifier`, é obrigatório que o nome seja **FlipConnectSDK**, e na URL Schemes você deve colocar o esquema que foi configurado para seu Merchant URI, por exemplo:

Se a Merchant URI registrada é `flipConnect://application` sua Url Schemes deve ser **flipConnect**; em outras palavras, tudo **antes de** `://` é sua Url Scheme.

![Url Schema Creation](img/urlTypes.png)

No seu `Info.plist` você deve acrescentar os **ClientID**, **ClientSecret**, **PublicTokenAPI** e **RedirectURI** registrados em nossa API. Eles serão usados pela SDK para o redirecionamento de nossa página de login:

```xml
<key>FlipConnectSDK</key>
<dict>
  <key>RedirectURI</key>
  <string>flipConnect://application</string>
  <key>ClientSecret</key>
  <string>FD5A0D34-878D-483B-9CC0-573DFB82A75B</string>
  <key>ClientID</key>
  <string>D7F667C8-199F-6B10-B53A-0BCDDEFADB31</string>
  <key>PublicTokenAPI</key>
  <string>5FFZ67B941DAACCDCB1888CDC97FA8F7</string>
</dict>
```
O resultado final será algo parecido com isto:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>FlipConnectSDK</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>flipConnect</string>
			</array>
		</dict>
	</array>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>FlipConnectSDK</key>
	<dict>
	<key>RedirectURI</key>
	<string>flipConnect://application</string>
	<key>ClientSecret</key>
	<string>FD5A0D34-878D-483B-9CC0-573DFB82A75B</string>
	<key>ClientID</key>
	<string>D7F667C8-199F-6B10-B53A-0BCDDEFADB31</string>
	<key>PublicTokenAPI</key>
	<string>5FFZ67B941DAACCDCB1888CDC97FA8F7</string>
	</dict>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
</dict>
</plist>

```
### ViewController

O login terá início aqui. Alguma ação irá ativar a página de login; se tudo funcionar corretamente, a página web irá redirecionar de volta para a aplicação.

Você pode usar seu próprio botão ou usar o nosso.

No seu ViewController importe a SDK:

```swift
import FlipConnectSDK
```

### Logar com o botão

```swift
class ViewController: UIViewController {

    var flipLogin: FCLogin!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            flipLogin = try FCLogin.shared()

            let loginBtn = flipLogin.loginWithButton(center: view.center, frame: CGRect(x: 0, y: 0, width: 180, height: 40), color: .darkGray, title: "FlipConnect Login")
            view.addSubview(loginBtn)

        } catch {
            print(error)
        }
    }
}
```
O botão parecerá com algum destes:

![Login Button](img/buttonLogin.png)

### Logar com openLoginURL

```swift
class ViewController: UIViewController {

    var flipLogin: FCLogin!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            flipLogin = try FCLogin.shared()
        } catch {
            print(error)
        }
    }

    @IBAction func printCookies(_ sender: UIButton) {
        self.flipLogin.loginButtonClicked()
    }
}
```

### AppDelegate

Após um login bem sucedido, o redirecionamento passará por aqui com alguma informação de login, porém apenas depois do método `handleRedirect(fromURL: URL)` funcionar sem problemas é que nós seremos capazes de recuperar o **Token Data**.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        do {
            let loginFlip = try FCLogin.shared()
            loginFlip.handleRedirect(fromURL: url) { error in
                guard error == nil else {
                    print(error!)
                    return
                }

                // DO SOMETHING
            }
        } catch {
            print(error)
        }
        
        return true
    }
}
```

Você deverá ser capaz de usar o **Token** e a **AccountKey** se digitar o seguinte:

```swift
var accessToken: String? = UserDefaults.standard.accessToken
var accountKey: String? = UserDefaults.standard.accountKey
```

### Refresh Token

Se o token expirar, basta fazer a implemntação que segue. Se algum erro retornar, é porque a requisição foi mal-sucedida

```swift
do {
	loginFlip = try FCLogin.shared()

	loginFlip.refreshToken() { err in
		guard err == nil else {
			print("refresh with no success")
			print(err!)
			return
		}
		print("Tokens Refreshed")
		print("NewToken: \(String(describing: UserDefaults.standard.accessToken))")
		print("NewAccessKey: \(String(describing: UserDefaults.standard.accountKey))")
	}

} catch {
	print(error)
}

```

### Verificar o Token

Se algum erro retornar, será porque o token verificado é inválido

```swift
do {
	loginFlip = try FCLogin.shared()

	loginFlip.verifyToken() { err in
		guard err == nil else {
			print("no success verifying")
			print(err!)
			return
		}
		print("Tokens successfully verified")
	}

} catch {
	print(error)
}
```

## Contribuições

Pull Requests serão muito bem-vindos!

## Problemas

Algum problema, dúvida ou sugestão? [Abra uma issue!](https://github.com/Flip-Payments/connect-sdk-ios/issues/new)
