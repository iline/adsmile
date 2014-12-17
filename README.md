## **Инструкция по внедрению библиотеки рекламы Adman.**

Для интеграции медиарекламы с играми и приложениями ВКонтакте,
необходимо интегрировать в приложение adman c вызовом рекламного ролика в приложении или игре.

При инициализации adman необходимо передавать id = 2060 (обязательно) и GET параметр content_id = xxxxx,
где content_id - id вашего приложения ВКонтакте. Его вы можете найти в настройках приложения.

#### **1. Подготовка.**

* Разрешите доступ к приложению с домена баблиотеки:
```as3
Security.allowDomain("rs.mail.ru");
```


* Загрузите библиотеку в приложение и получите ссылку на экземпляр библиотеки:
```as3
private var loader:Loader;
private var adman:Object;
```
```as3
private function initAd(e:Event = null):void
{
    ...
    loader = new Loader();
    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
    var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
    loader.load(new URLRequest("http://rs.mail.ru/vp/adman2.swf"), context);
}
```

* Добавьте экземпяр библиотеки или ссылку на него в список отображения:
```as3
private function onLoadComplete(e:Event):void
{
    adman = loader.content;
    addChild(adman as DisplayObject);
}
```

#### **2. Инициализация библиотеки.** 
После загрузки библиотеки её надо инициализировать, вызвав метод init, и передать в него id вашего приложения (хххххх):
```as3
adman.init(2060, {requestParams: {content_id: xxxxx}});
```
#### **3. Запуск рекламного ролика.**
В случае успешной загрузки и обработки данных, библиотека распространит событие adReady. 
После получения этого события необходимо установить желаемый размер области рекламы и запустить
 показ рекламы, вызывая метод start и передавая в него название секции:
```as3
adman.addEventListener("adReady",onAdReady);
adman.load();

private function onAdReady(e:Event):void
{
    adman.setSize(500,500);
    adman.start(“preroll”);
}
```
#### **4. Компиляция приложения.** 
Рекомендуем использовать:  [flex compiler](http://www.adobe.com/devnet/flex/flex-sdk-download.html)
```bash
mxmlc Smile.as -output ../build/Smile.swf
```
