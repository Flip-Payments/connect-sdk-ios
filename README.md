# FlipConnectSDK

[![Build Status](https://www.bitrise.io/app/e2ffa72d64f58e17/status.svg?token=qyJOAroLehBPTj5D4g7clA)](https://www.bitrise.io/app/e2ffa72d64f58e17) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Flip-Payments/connect-sdk-ios/master/LICENSE) [![Github Version](https://img.shields.io/github/release/Flip-Payments/connect-sdk-ios.svg)](https://github.com/Flip-Payments/connect-sdk-ios/releases) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/FlipConnectSDK.svg)](http://cocoadocs.org/docsets/FlipConnectSDK/) ![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)

Veja mais aqui: [FlipConnectSDK Reference](http://cocoadocs.org/docsets/FlipConnectSDK/)

## Como funciona

A FlipConnectSDK funciona recebendo **ClientId** e **ClientSecret** para abrir uma página web para logar exatamente como na autenticação do Facebook e do Google. O usuário irá logar no nosso ambiente e, caso seja bem sucedido, o usuário será redirecionado para a aplicação usando a previamente configurada **RedirectURI**.

Quando a aplicação abre, a SDK irá procurar por parâmetros válidos na URI, para que então possa fazer requisições para recuperar o **access token**, o **refresh token** e a **account key**.

Com essas informações você será capaz de acessar as informações do usuário!

## Instalação

### Carthage

Coloque isto no seu Cartfile:

```yaml
github "Flip-Payments/connect-sdk-ios" ~> 0.2
```

e então rode o seguinte comando:

```sh
carthage update
```
**OBS:** O Carthage irá baixar dois frameworks o `FlipConnectSDK.framework` e `FingerPrint_iOS.framework`, ambos devem ser colocados no seu app para que funcione corretamente.

### Cocoapods

Acrescente ao seu  `Podfile`

```ruby
target 'MyApplication' do
  use_frameworks!
  pod 'FlipConnectSDK', '~> 0.2'
end
```

### Instalação manual

Para instalar manualmente a SDK é necessário baixar ambos os Frameworks [desta pasta](https://github.com/Flip-Payments/connect-sdk-ios/tree/master/Frameworks) e colocar em Embedded Binaries como na imagem abaixo:

![Manual Installation](./img/installManual.png)

Depois é necessário baixar o script [remove_unused_archs.sh](https://raw.githubusercontent.com/Flip-Payments/connect-sdk-ios/master/scripts/remove_unused_archs.sh) e adicionar em `Build Phases > Run Script` o seguinte comando: `bash "${SRCROOT}/remove_unused_archs.sh"` (lembrando que neste caso o script está no root do projeto, se o seu script estiver em outra pasta é necessário informar o caminho desta pasta) como na imagem abaixo:

![Run Script](./img/runManualScript.png)

Estes passos são necessários para rodar o script manual porque ambos os frameworks contém todos as arquiteturas dentro dele, mas a loja da Apple não permite publicar o app com as arquiteturas de simulador, por isso este post script garante a remoção destas arquiteturas para que a publicação ocorra sem problemas.

## Usabilidade

### Configuração

No seu projeto, clique na aba "informação" e selecione Url Types. No campo `identifier`, é obrigatório que o nome seja **FlipConnectSDK**, e na URL Schemes você deve colocar o esquema que foi configurado para seu Merchant URI, por exemplo:

Se a Merchant URI registrada é `flipConnect://application` sua Url Schemes deve ser **flipConnect**; em outras palavras, tudo **antes de** `://` é sua Url Scheme.

![Url Schema Creation](img/urlTypes.png)

### Inicialização

É necessário inicialiar a classe de login na abertura do app no `AppDelegate.swift`, para isso é necessário colar o código abaixo. O parâmetro fingerPrintID é opcional, deve ser passado apenas se quiser passar dados para o anti-fraude.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = FCConfiguration(
            apiToken: "AA3AD9FD402E913C51625C494FCB39D1",
            clientID: "5149B5B2-0463-4752-A8A0-C37D639A1FE4",
            clientSecret: "AF3A9D34-978A-483A-9BB0-462DFB82A75A",
            redirectURI: "flipconnect://application",
            fingerPrintID: "a470458a-7845-4380-c5ad-a7a28548b243"
        )
        do {
            _ = try FCLogin.shared(configuration: config)
        } catch {
            print(error)
        }
        return true
    }
```

Após esta inicialização, se for passado o `fingerPrintID`, o `fingerPrintSessionID` será *setado* e você poderá acessá-lo chamando o `UserDefaults` como no exemplo abaixo:

```swift
if let fingerPrintSessionID = UserDefaults.standard.fingerPrintSessionID {
    print(fingerPrintSessionID)
}
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

### Enviando dados de FingerPrint para o anti-fraude

Com o FingerPrintID sendo enviado na inicialização da classe `FCLogin`, enviar dados para o anti-fraude é muito simples, basta colocar permissões no seu app para o usuário liberar acesso aos contatos e o mesmo para localização.

**OBS:** Lembre-se que a Apple pode encrencar com a publicação do seu app se ele pedir permissão ao usuário de dados que são desnecessários para o app, não vale pedir acesso aos contatos do seu usuário se o seu app não faz nada com os contatos dele, não é mesmo?

Para pedir as permissões de acesso para o usuário basta acrescentar estas linhas no `Info.plist`:

![Privacy Access](./img/privacyAccess.png)

### Transferência de Dados para Perfil temporário

Se desejar transferir os dados de cadastro que já tem em sua base para facilitar o cadastro e a transição do usuário para o nosso sistema, você pode usar a variável `temporaryProfile` para preencher os dados cadastrais do usuário.

Para utilizar basta atribuir um valor do tipo `TemporaryProfile` a variável `temporaryProfile` da classe `FCLogin`:

```swift
class ViewController: UIViewController {

    var flipLogin: FCLogin!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            flipLogin = try FCLogin.shared()

	    let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let birthdate = formatter.date(from: "1997/12/17")
            
            let personalData = PersonalData(birthdate: birthdate, genderType: .masculine, country: "br", dependentCount: 3)!
            let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
            let vehicle2 = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
            let document = Document(documentType: .cpf, documentNumber: "12345678901")!
            let phone = Phone(phoneType: .mobile, fullNumber: "26113328")!
            let phone2 = Phone(phoneType: .home, fullNumber: "26113328")!
            let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
            let address2 = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
            
            let temporaryProfile = TemporaryProfile()
            temporaryProfile.addresses = [address, address2]
            temporaryProfile.documents = [document]
            temporaryProfile.personalData = personalData
            temporaryProfile.phones = [phone, phone2]
            temporaryProfile.vehicles = [vehicle, vehicle2]

	    flipLogin.temporaryProfile = temporaryProfile
        } catch {
            print(error)
        }
    }

    @IBAction func printCookies(_ sender: UIButton) {
        self.flipLogin.loginButtonClicked()
    }
}
```

Ou na chamada do método `loginWithButton()`:

```swift
class ViewController: UIViewController {

    var flipLogin: FCLogin!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            flipLogin = try FCLogin.shared()

	    let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let birthdate = formatter.date(from: "1997/12/17")
            
            let personalData = PersonalData(birthdate: birthdate, genderType: .masculine, country: "br", dependentCount: 3)!
            let vehicle = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
            let vehicle2 = Vehicle(licensePlate: "LNY-4266", licensePlateCity: "Rio de Janeiro", licensePlateState: "RJ", licensePlateCountry: "br")!
            let document = Document(documentType: .cpf, documentNumber: "12345678901")!
            let phone = Phone(phoneType: .mobile, fullNumber: "26113328")!
            let phone2 = Phone(phoneType: .home, fullNumber: "26113328")!
            let address = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
            let address2 = Address(street: "Conde de Bonfim", number: "800", addressType: .work, city: "Rio de Janeiro", state: "RJ", country: "br")!
            
            let temporaryProfile = TemporaryProfile()
            temporaryProfile.addresses = [address, address2]
            temporaryProfile.documents = [document]
            temporaryProfile.personalData = personalData
            temporaryProfile.phones = [phone, phone2]
            temporaryProfile.vehicles = [vehicle, vehicle2]

	    let btn = flipLogin.loginWithButton(center: view.center, temporaryProfile: temporaryProfile)

	    view.addSubview(btn)
        } catch {
            print(error)
        }
    }

    @IBAction func printCookies(_ sender: UIButton) {
        self.flipLogin.loginButtonClicked()
    }
}
```

Com isso a tela de cadastro irá se abrir com os dados já preenchidos no ato do cadastro do usuário.

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
