<img src="https://i.gyazo.com/11190570e98e16e002c5c6acd21b854b.png" align="center" width="200" >

# FTAuth SDK 

## Особенности

- Авторизация и регистрация пользователей
- Возможность авторизации через Facebook, Google и Apple
- Настройка полей обязательных для регистрации
- Вывод ошибок валидации или ошибок с сервера в виде подписи к полям с возможностью настройки отображения ошибок через всплывающий алерт или вывод в консоль
- Готовые классы UI объектов

***
  
## Requirements
- Xcode 11+
- Swift 5+
- iOS 13.2+
  
***

## Первоначальные настройки ТОЛЬКО для авторизации с помощью AppleID

1. В Apple Developer Account cоздайте явный идентификатор приложения в разделе [Identifiers](https://developer.apple.com/account/resources/identifiers/list)

2. В настройках созданного идентификатора включите возможность использования **Sign In with Apple**:
<img src="https://i.gyazo.com/1d76c5d827b5cfc2e5514364900826e1.png" align="center" width="500">

3. Создайте profiles в разделе [Profiles](https://developer.apple.com/account/resources/profiles/list)

4. В Xcode во вкладке **Signing & Capabilities**, добавитье **Capability**  *"Sign In With Apple"*:
<img src="https://i.gyazo.com/b0a6b241a11c0b3d65f7be230efb1c18.png" align="center" width="500">
  
***

## Установка

### Вручную:
1. Перенесите ***FTAuth.framework*** в папку проекта
2. Установите необходимые параметры копирования в проект (установите флажки "Copy items if needed", "Create groups" и выберите целевой объект):
<img src="https://i.gyazo.com/52bd2e756bf3a049d4ac035bd74e19d9.png" align="center" width="500">   

3. В ***Build Phases*** добавьте ***FTAuth.framework*** в ***Embed Frameworks***:
<img src="https://i.gyazo.com/f59a32f7243bfb5670d74a6a31bead72.png" align="center" width="500">

### С помощью **CocoaPods**:

1. Добавьте 
``` pod 'FTAuth', :git => "https://github.com/GTimofey/FTAuth.git"``` в свой **Podfile**.
2. Запустите ```pod install```.
3. Во время установки потребуется ввести логин и пароль для доступа к приватному репозиторую.
  
  ***
## Последовательность действий при использовании FTAuth для авторизации и регистрации:
1. Импорт модуля ***FTAuth***
2. Установка URL для обращения к серверу (Обязательно)
2. Добавление UI элементов необходимых для авторизации и регистрации и установка классов этих элементов (Обязательно)
3. Настройка отображения ошибок валидации и серверных ошибок (Не обязательно)
4. Настройка ***FTAuth*** (определение обязательных элементов, отображение индикатора загрузки, настройка дополнительных данных *Payload* отправляемых на сервер и т.д.) (Не обязательно)
5. Настройка замыкания для выполнения действий перед запросом на сервер, после успешного запроса и после неудачного запроса (Обязательно)
  
Нчальная настройка SDK
1. import ***FTAuth***:
```swift
import FTAuth
```

2. Установка URL для обращения к серверу: 

Установку URL-адреса необходимо производить перед использованием SDK, например, внутри функции ***didFinishLaunchingWithOptions*** в ***AppDelegate***
```swift
FTAuth.setAuthSerevrURL("http://00.00.198.200:3001")
```
  
  ***
## Подключение UI элементов  

### UITextFields

| Тип UITextField | Описание |
| ------ | ------ |
| ***Авторизация*** ||
| FTAuthEmailTextField | Для ввода email при авторизации |
| FTAuthPasswordTextField | Для ввода пароля при авторизации | 
| ***Регистрация*** ||
| FTRegistrationNameTextField | Для ввода произвольного именя при регистрации |
| FTRegistrationFirstNameTextField | Для ввода имени при регистрации |
| FTRegistrationLastNameTextField | Для ввода фамилии при регистрации |
| FTRegistrationEmailTextField | Для ввода email при регистрации |
| FTRegistrationPasswordTextField | Для ввода пароля при регистрации |
| FTRegistrationConfirmPasswordTextField | Для подтверждения при регистрации |
| FTRegistrationPhoneTextField | Для ввода номера телефона при регистрации |

 + #### Для подключения текстовых полей необходимо:
1. перейти к **Stiryboard***
2. выбрать  **UITextField***
3. открыть вкладку **Identity Inspector**
4. В графе **Class** установить класс, соответствующий назначению этого ***UITextField***
5. В графе **Modul** установить значение ***FTAuth***

<img src="https://i.gyazo.com/c3b4a883bcf380dd3619cd0c8f6b2be2.jpg" align="center" width="500">

  + #### Особенности FTAuthTextFields элементов и примеры использования
  + Каждый FTAuthTextField имеет публичную переменную ***descriptionLbl*** - меткe, для вывода ошибок валидации или ошибок с сервера. 
  Её свойства можно переопределять. обратившись к ней через IBOutlet конкретного поля.  ()
```swift
@IBOutlet weak var emailTF: FTAuthEmailTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.descriptionLbl.textColor = .blue
    }
```
**Результат**  
<img src="https://i.gyazo.com/02c4a26f5e2f053adb41b911f00c551f.png" align="center" width="500">  
  + Каждый FTAuthTextField имеет публичный метод ***setVerticalLocationOfDescription(_ verticalLocationOfDescription: CGFloat?)***. Функция, меняет вертикальное расстояние от центра текстового поля до центра descriptionLbl. По умолчанию descriptionLbl расположен под текстовым полем.
```swift
@IBOutlet weak var emailTF: FTAuthEmailTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.setVerticalLocationOfDescription(-25)
    }
```
**Результат**  
<img src="https://i.gyazo.com/eb9576cfa2124c00a8ea2f6cf1c5b433.png" align="center" width="500">

  + В классе ***FTRegistrationPhoneTextField*** существует публичное свойство ***phoneMask*** типа ***PhoneMask***, предназначеное для назначения маски ввода телефонного номера.

| Значение ***PhoneMask*** | Описание | Вид маски | Валидация |
| ------ | ------ | ------ | ------ |
| **.x_xxx_xxx_xxxx** | Маска для номеров международного формата с кодом страны из одной цифры | "+X (XXX) XXX-XXXX" | Согласно маске |
| **.xx_xxx_xxx_xxxx** | Маска для номеров международного формата с кодом страны из двух цифр | "+XX (XXX) XXX-XXXX" | Согласно маске |
| **.plus** | Универсальная маска для номеров междунраднодного формата без резделителей. | "+XXXXXXXXXXXXXXXXXXXX" | Больше одинадцати (11) символов |
| **.customMask(mask: String)** | Пользовательская маска телефонного номера. Маска должна быть задана с учетом последовательной замены всех символов *"X"* введенными пользователем цифрами, остальные символы маски сохранят своё положение. | *mask* | Согласно маске |
| **.none** | Ввод телефонного номера без маски | "" | Без валидации |

Обращение к свойству ***phoneMask*** происходит через экземпляр ***FTRegistrationPhoneTextField***.

```swift
@IBOutlet weak var phoneTF: FTRegistrationPhoneTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF.phoneMask = .customMask(mask: "X_(XXX)_XXX_XX_XX")
    }
```
**Результат**  
<img src="https://i.gyazo.com/1cf93759bc15d7bc3ba413fedd6d51f3.png" align="center" width="500">

+ В классе ***FTRegistrationPhoneTextField*** существует публичное свойство ***prefix*** типа ***String***, предназначеное для добавления символов перед введенным пользователем номером до отправки на сервер. 
Значение в свойстве ***prefix*** не учитывается при валидации. 
Обращение к свойству ***prefix*** происходит через экземпляр ***FTRegistrationPhoneTextField***.

```swift
@IBOutlet weak var phoneTF: FTRegistrationPhoneTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF.prefix = "+7"
    }
```

***
  
### UIButtons

| Тип UIButtons | Описание |
| ------ | ------ |
| ***Авторизация по email*** |
| FTAuthLoginBtn | По нажатию запускается процесс авторизации |
| ***Авторизация через сторонние аккаунты*** |
| FTAuthFacebookBtn | По нажатию запускается авторизация через Facebook| 
| FTAuthGoogleBtn | По нажатию запускается авторизация через Google | 
| FTAuthAppleBtn | По нажатию запускается процесс авторизация через Apple | 
| ***Регистрация*** |
| FTAuthRegistrationBtn | По нажатию запускается процесс регистрации |
| ***Выход из аккаунта*** |
| FTAuthLogoutBtn | По нажатию запускается процесс выхода из аккаунта | 
| ***Дополнительные кнопки*** |
| FTCheckerAcceptanceOfTerms | Для подтверждения согласия пользователя с условиями использования приложения |

+ #### Для подключения кнопок необходимо:
1. перейти к **Stiryboard***
2. выбрать  **UIButton***
3. открыть вкладку **Identity Inspector**
4. В графе **Class** установить соответствующий назначению этого ***UIButton***
5. В графе **Modul** установить значение ***FTAuth***

<img src="https://i.gyazo.com/fdcd99a523d3bbf3d4f337b1dae522c7.jpg" align="center" width="500">

  + #### Особенности FTAuthButtons элементов и примеры использования
    + ***FTAuthGoogleBtn*** и ***FTAuthFacebookBtn***:
      + По нажатию на кнопки ***FTAuthFacebookBtn*** и  ***FTAuthGoogleBtn*** открывается авторизации в соответвующем в WKWebView. Для отмены можно просто смахнуть этот экран вправо.  
    После авторизации пользователя в этом дополнительном окне, процесс авторизации на сервере произойдет автоматически.
    + ***FTAuthAppleBtn***:
       + Для использования ***FTAuthAppleBtn*** необходимо выполнитель все пункты из раздела ***Начальные установки (требуются только для авторизации с помощью AppleID)***
    + ***FTCheckerAcceptanceOfTerms***:
      + Используется для подтвеждения пользователя с условиями использования приложения или иными правилами.
      + Имеет публичные переменные **checked: Bool**, **imageOn: UIImage?**, **imageOff: UIImage?** и публичную функцю **set(checked: Bool, imageOn: UIImage, imageOff: UIImage)**
      + **checked** - переменная указывающая, в каком состоянии находится чекер. По умолчанию - false
      + **imageOn** - изображение для чекера в включенном положении. По умолчанию - nil
      + **imageOff** - изображение для чекера в выключенном положении. По умолчанию - nil
      + **set(checked: Bool, imageOn: UIImage, imageOff: UIImage)** - функция для настройки начального состояния и изображений чекера
      + по нажатию на чекер он меняет состояние **checked** на противоположное и изображение, на соответствующее состоянию **checked**
      + Если изображения для **imageOn** и **imageOff** не установлены, то изображение (**.image**), установленное для чекера в состоянии **checked = false** становится бледным, в состоянии **checked = true** обычного цвета.
```swift
  @IBOutlet weak var checker: FTCheckerAcceptanceOfTerms!
    override func viewDidLoad() {
        super.viewDidLoad()
        checker.set(checked: false, imageOn: .add, imageOff: .remove)
        checker.checked = true
        checker.imageOn = .checkmark
        checker.imageOff = .add
    } 
```
  
***  
## Дополнительные настройки FTAuth
***FTAuth*** имеет следующие публичные элементы: 

| Публичный элемент FTAuth | Описание |
| ------ | ------ |
| ***Переменные*** |
| **errorOutputType: ErrorOutputType? = .log** | Для определения типа вывода ошибок в приложение. По умолчанию = **.log.** |
| **requiredElements = [TypeElement]()** | Для определения списка элементов, являющихся обязательными для процесса регистрации. Запрос на регистрацию не будет отправлен, если указанные в списке поля не будут заполнены валидными данными |
| **generalVerticalLocationOfDescription: CGFloat?** | Для изменения вертикального расположение **descriptionLbl** сразу для всех FTAuthTextFields текущего контроллера |
| **webView: UIView?** | Для определения UIView элемента, внутри которого будет оторажен экран для авторизации через Facebook или Google |
| **showSpinner** | Для отображения или скрытия индикатора загрузки во время запросов. |
| **activityIndicator: UIActivityIndicatorView?** | Для настройки индикатора загрузки, оторажаемого во время запроса |
| **backgroundColorOfActivityIndicator: UIColor?** | Для определения цвета фона для индикатора загрузки |
| **authPayload: [String: AnyObject]?** | Списко дополнительных данных, которые необходимо передать на сервер в запросе авторизации |
| **registrationPayload: [String: AnyObject]?** | Списко дополнительных данных, которые необходимо передать на сервер в запросе регистрации |
| ***Функции*** | 
| **setAuthSerevrURL(_ url: String)** | Устанавливает URL сервера авторизации |
| **loginWithApple(_ identityToken: String)** | Принимает токен авторизации через *Facebook* и авторизует пользователя. Перед запросом на сервер срабатывается **startLogin**, в случает успешного запроса **successLogin**, при неудачном запросе **failureLogin**. |
| **getSessionToken() -> String?** | Возвращает текущий **session-token** |
| **getProviderToken() -> String?** | Возвращает текущий **provider-token** |
| **setProviderToken(_ providerToken: String)** | Устанавливает занчение текущего **session-token**, если он был получен вне ***FTAuth*** |
| **setSessionToken(_ sessionToken: String)** | Устанавливает занчение текущего **provider-token**, если он был получен вне ***FTAuth*** |
| **settingDescriptionLabel(textColor: UIColor? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment? = nil, backgroundColor: UIColor? = nil, attributedText: NSAttributedString? = nil, lineBreakMode: NSLineBreakMode? = nil, adjustsFontSizeToFitWidth: Bool? = nil, minimumScaleFactor: CGFloat? = nil, numberOfLines: Int? = nil, highlightedTextColor: UIColor? = nil, isHighlighted: Bool? = nil, shadowColor: UIColor? = nil, shadowOffset: CGSize? = nil)** | Для изменения основных настроек отображения **descriptionLbl.** сразу для всех FTAuthTextFields текущего контроллера |
| ***Замыкания*** | 
| **startLogin: (() -> Void)?** | Срабатывает непосредственно перед отправкой запроса авторизации |
| **startRegistration: (() -> Void)?** | Срабатывает непосредственно перед отправкой запроса регистрации |
| **startLogout: (() -> Void)?** | Срабатывает непосредственно перед отправкой запроса завершения сессии |
| **completionHandlerLogin: ((_ completionHandler: (Result<AuthResponseModel, FTErrorModel>)) -> Void)?** | Срабатывает непосредственно после получения ответа на запрос авторизации |
| **completionHandlerRegistration: ((_ completionHandler: (Result<AuthResponseModel, FTErrorModel>)) -> Void)?** | Срабатывает непосредственно после получения ответа на запрос регистрации |
| **completionHandlerLogout: ((_ completionHandler: (Result<ResponseModel, FTErrorModel>)) -> Void)?** | Срабатывает непосредственно после получения ответа на запрос завершения сессии |

+ ### Настройки отображения ошибок (***errorOutputType, generalVerticalLocationOfDescription***)  
1. Настройка отображения ошибок производится путем указания типа вывода для статической переменной ***errorOutputType*** класса ***FTAuth***.
В ***FTAuth*** предусмотрено два типа вывода ошибок: ***.log*** и ***.alert*** 

| Тип вывода ошибок | Описание |
| ------ | ------ |
| .log | Выводит ошибки в консоль. Установлен по умолчанию |
| .alert | Выводит ошибка с помощью алерта | 

```swift
FTAuth.errorOutputType = .alert
```

**Примечание** 
Ошибки валидации выводятся в descriptionLbl текстового поля не зависимо от установленного типа вывода ошибок.
Если в ключе ошибки, вернувшейся с сервера, указано конкретное поле, к которому она относится, то message ошибки будет выведен в descriptionLbl этого поля не зависимо от установленного типа вывода ошибок.  


2. Для изменения вертикального расположения всех ***descriptionLbl*** текущего контроллера необходимо изменить значение публичной переменной ***generalVerticalLocationOfDescription***.  
```swift
FTAuth.generalVerticalLocationOfDescription = 0
```
**Результат**:  
<img src="https://i.gyazo.com/9db616184a8446a295aca4471409454e.png" align="center" width="500">  


3. Изменение основных настроек отображения **descriptionLbl.** сразу для всех FTAuthTextFields текущего контроллера производится с помощью метода  **settingDescriptionLabel**.

Полный вид функции **settingDescriptionLabel**:
```swift
settingDescriptionLabel(textColor: UIColor? = nil, 
                        font: UIFont? = nil, 
                        textAlignment: NSTextAlignment? = nil, 
                        backgroundColor: UIColor? = nil, 
                        attributedText: NSAttributedString? = nil, 
                        lineBreakMode: NSLineBreakMode? = nil, 
                        adjustsFontSizeToFitWidth: Bool? = nil, 
                        minimumScaleFactor: CGFloat? = nil, 
                        numberOfLines: Int? = nil, 
                        highlightedTextColor: UIColor? = nil, 
                        isHighlighted: Bool? = nil, 
                        shadowColor: UIColor? = nil, 
                        shadowOffset: CGSize? = nil)
```
Нет необходимости изменять каждое значение, изменяйте только те свойства, которые вас интересуют:
```swift
FTAuth.settingDescriptionLabel(
                        textColor: .green, 
                        textAlignment: .right, 
                        backgroundColor: .gray, 
                        shadowColor: .red, 
                        shadowOffset: CGSize(width: 1, height: 1))
```
**Результат**:  

<img src="https://i.gyazo.com/2cf6973551f2f396b83428655b7b03d6.png" align="center" width="500">



+ ### Определение списка элементов, являющихся обязательными для процесса регистрации (***requiredElements***)
***requiredElements*** - является массивом элементов типа ***TypeElement***. 

***TypeElement*** - это перечисление всех типов полей для регистрации доступных в ***FTAuth***. 
***TypeElement*** может принимть следующие значения: *none*, *name*, *firstName*, *lastName*, *email*, *password*, *confirmPassword*,*phone*, *accept*)
Обязательными могут быть все поля или только несколько полей.

**Пример использования ***requiredElements*** в случае, когда все используемые поля являются обязательными**
```swift
FTAuth.requiredElements = [ .email, .password, .confirmPassword, .phone, .firstName, .lastName, .accept]
```
**Результат**:  
<img src="https://i.gyazo.com/a1dd55dfbc90fd04d4505bca5e8874f1.png" align="center" width="500">  


**Пример использования ***requiredElements*** в случае, когда только некоторые используемые поля являются обязательными**
```swift
FTAuth.requiredElements = [.email, .password, .confirmPassword, .accept]
```
**Результат**:  
<img src="https://i.gyazo.com/2565c8139f97d0a1837f2da306e201fd.png" align="center" width="500">  


+ ### Определение области отображения экрана авторизации через *Facebook; или *Google* (***webView***)
При нажатии на ***FTAuthFacebookBtn*** и ***FTAuthGoogleBtn*** открывается **WebView** для авториизации. 
По умолчанию **WebView** будет иметь размеры **view** текущего контроллера и будет добавлен поверх этого **view**.
  
<img src="https://i.gyazo.com/1fb62df830662ee03ab8ad9ba81fa6d9.png" align="center" width="500">  

Область отображения **WebView** можно изменить установив значение ***webView***. 
В примере ниже область отображения webView меняется на верхнюю половину экрана. 
```swift
let rectUpperHalf = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height / 2)
let viewUpperHalf = UIView(frame: rectUpperHalf)
view.addSubview(viewUpperHalf)
FTAuth.webView = viewUpperHalf
```

**Результат**:  
<img src="https://i.gyazo.com/d165e97b6900735b754fb4a987f1b77f.png" align="center" width="500">  

Чтобы убарть **WebView** с экрана нужно сделать свайп вправо или завершить авторизацию.


+ ### Настройка индикатора загрузки (***showSpinner, activityIndicator, backgroundColorOfActivityIndicator***) 
1. По умолчанию в ***FTAuth*** включено отображения индикатора загрузки во время запросов. 
Чтобы скрыть индикатор загрузки нужно установить для переменной ***showSpinner*** значение ***false***
```swift
FTAuth.showSpinner = false
```

2. Свойств индикатора загрузки изменяются через свойство ***activityIndicator***.
```swift
FTAuth.activityIndicator = UIActivityIndicatorView(style: .large)
FTAuth.activityIndicator?.color = .blue
```

3. Так же можно установить цвет фона индикатора загрузки через свойство ***backgroundColorOfActivityIndicator***.
```swift
FTAuth.backgroundColorOfActivityIndicator = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 0.2)
```

+ ### Отправка дополнительных данных (***authPayload, registrationPayload***)

Чтобы отправить на сервер вместе с запросом авторизации или регистрации данные, которые нельзя получить из предоставленных ***FTAuth*** полей,
можно добавить их с помощью свойств ***authPayload*** и ***registrationPayload*** соответственно.
Эти свойства имеют тип **[String: AnyObject]**, и заполняется ключами и значениями, которые ожидает получить сервер.
Данные должны быть добавлены до отправки самого запроса, например, в замыкании ***startLogin*** или ***startRegistration***.

```swift
FTAuth.startLogin = {
    FTAuth.authPayload = ["gender": "woman" as AnyObject, "age": 25 as AnyObject]
}
```

**Примечание**:
Добавить можно только простые типы. Мультимедиа файлы не будут обработаны.


+ ### Получение и установка токенов (***getSessionToken, getProviderToken, setSessionToken, setProviderToken, loginWithApple***)

1. Функция **getSessionToken() -> String?** возвращает строку с **session_token**, если он уже получен или **nil**, если **session_token** не получен.
```swift
let sessionToken = FTAuth.getSessionToken()
```
2. Функция **getProviderToken() -> String?** возвращает строку с **provider_token**, если он уже получен или **nil**, если **provider_token** не получен.
```swift
let providerToken = FTAuth.getProviderToken()
```
3. Функция **setSessionToken(_ sessionToken: String)** позволяет установить **session_token***, если они был получен вне ***FTAuth***.
```swift
FTAuth.setSessionToken(sessionToken)
```
4. Функция **setProviderToken(_ providerToken: String)** позволяет установить **provider_token***, если они был получен вне ***FTAuth***.
```swift
FTAuth.setProviderToken(providerToken)
```
5. Функция **loginWithApple(_ identityToken: String)** принимает токен авторизации через *Apple* и авторизует пользователя на сервере. Замыкания **startLogin**, **successLogin**, **failureLogin** срабатывают так же, как и при обычном запросе.
```swift
FTAuth.loginWithApple(appleIdentityToken)
```

+ ###  Замыкания 
  +  #### Замыкания, срабатывающие перед запросами (***startLogin, startRegistration, startLogout***)
  
Замыкание **startLogout** срабатывает после отчистки значений ***session_token*** и ***provider_token*** в **FTAuth**
```swift
FTAuth.startLogin = {
    FTAuth.authPayload = ["gender": "woman" as AnyObject, "age": 25 as AnyObject]
}

FTAuth.startRegistration = {
    FTAuth.registrationPayload = ["gender": "woman" as AnyObject, "age": 25 as AnyObject]
}

FTAuth.startLogout = {
    print("Start logout")
}
```

  +  #### Замыкания, срабатывающие после получения ответа на запрос (***completionHandlerLogin, completionHandlerRegistration, completionHandlerLogout***)

```swift
FTAuth.completionHandlerLogin = { [weak self] result in
    guard let `self` = self else { return }
    switch result {
    case .success(_):
        self.performSegue(withIdentifier: "mainScreen", sender: nil)
    case .failure(_):
        break
    }
}


FTAuth.completionHandlerRegistration = { [weak self] result in
guard let `self` = self else { return }
    switch result {
    case .success(_):
        self.performSegue(withIdentifier: "mainScreen", sender: nil)
    case .failure(let error):
        if error.key == "email" && error.message == "exists" {
            DispatchQueue.main.async {
                self.showMessage(title: "Oops!", message: "This email is already registered")
            }
        }
    }
}

FTAuth.completionHandlerLogout = { [weak self] result in
guard let `self` = self else { return }
    switch result {
    case .success(_), .failure(_):
        self.performSegue(withIdentifier: "authScreen", sender: nil)
    }
}
```

  +  #### Модели используемые в замыканиях после получения ответа на запрос (***AuthResponseModel, ResponseModel, FTErrorModel***)

| Свойства модели | Тип | Описание |
| ------ | ------ | ------ |
| ***AuthResponseModel*** |
| success | Bool? | Содержит значение, указывающее на успешность запроса |
| errors | [FTErrorModel]? | Содержит массив ошибок запроса |
| provider_token | String? | Содержит токен провайдера |
| session_token | String? | Содержит токен сессии|
| ***АResponseModel*** |
| success | Bool? | Содержит значение, указывающее на успешность запроса |
| errors | [FTErrorModel]? | Содержит массив ошибок запроса |
| FTAuthAppleBtn | success | По нажатию запускается процесс авторизация через Apple | 
| ***FTErrorModel*** |
| key | String? | Содержит ключ ошибки. Например в случае, если ошибка отностися к конкретному свойству |
| message | String? | Содержит текст ошибки с описанием проблемы | 


### API Документация

[Mobile API спецификация](https://docs.google.com/spreadsheets/d/1uKBGsNgds9ovyJngjirpdJqrBXQ2EnStmWZTNCRiYtY/edit?usp=sharing)

<img src="https://i.gyazo.com/27f9e2ba8112245aee6ce1baf12159a7.png" align="center" width="1000"> 
<img src="https://i.gyazo.com/db04951db9a264e21ddfac1f1c10cee5.png" align="center" width="1000"> 
<img src="https://i.gyazo.com/ebf188f7e6ea19355b844cb6ccd47174.png" align="center" width="1000"> 


