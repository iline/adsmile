## **Инструкция по внедрению библиотеки рекламы Adman.**

Для интеграции рекламной системы Mail.ru Group с играми и приложениями Vkontakte,
необходимо интегрировать в приложение adman c вызовом рекламного места в приложении или игре.
Инструкция по внедрению adman во вложении, при инициализации adman,
необходимо передавать id = 2060 и дополнительные GET параметры _SITEID=276&content_id={},
где content_id - уникальный идентификатор контента (приложения/игра).

#### **1. Загрузка библиотеки.**
Прежде чем использовать библиотеку, её необходимо сначала загрузить в приложение.
Перед загрузкой библиотеки необходимо разрешить доступ к приложению с домена библиотеки:

* Разрешить доступ к приложению с домена баблиотеки:
```actionscript
Security.allowDomain("rs.mail.ru");
```

Загружать библиотеку надо в собственный домен приложения, чтобы избежать конфликта 
определений классов. После завершения загрузки надо получить ссылку на экземпляр библиотеки и 
добавить либо непосредственно сам экземпляр, либо объект loader в список отображения.

* Загрузить библиотеку в приложение и получить ссылку на экземпляр библиотеки:
```actionscript
private var loader:Loader;
private var adman:Object;
```
```actionscript
private function initAd(e:Event = null):void
{
    ...
    loader = new Loader();
    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
    var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
    loader.load(new URLRequest("http://rs.mail.ru/vp/adman2.swf"), context);
}
```

* Добавить экземпяр библиотеки или ссылку на него в список отображения:
```actionscript
private function onLoadComplete(e:Event):void
{
    adman = loader.content;
    addChild(adman as DisplayObject);
}
```

#### **2. Инициализация библиотеки.** 
После загрузки библиотеки её надо инициализировать, вызвав метод init и передав в него id-слота:
```actionscript
adman.init(2060);
```
#### **3. Запуск секций.**
В случае успешной загрузки и обработки данных библиотека распространит событие adReady. 
После получения этого события надо установить желаемый размер области рекламы и можно 
запускать показ рекламы, вызывая метод start и передавая в него название секции:
```actionscript
adman.addEventListener("adReady",onAdReady);
adman.load();

private function onAdReady(e:Event):void
{
    adman.setSize(500,500);
    adman.start(“preroll”);
}
```
