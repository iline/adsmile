package
        {
            import flash.display.MovieClip;
            import flash.display.Sprite;
            import flash.display.Loader;
            import flash.display.StageAlign;
            import flash.display.StageScaleMode;
            import flash.display.DisplayObject;
            import flash.events.MouseEvent;
            import flash.events.Event;
            import flash.system.ApplicationDomain;
            import flash.system.LoaderContext;
            import flash.system.Security;
            import flash.net.URLRequest;

            public class Smile extends MovieClip
            {
                private var smileSprite:Sprite;
                private var loader:Loader;
                private var adman:Object;

                function Smile()
                {
                    init();
                    Security.allowDomain("rs.mail.ru");

                    if (stage) initAd();
                    else addEventListener(Event.ADDED_TO_STAGE, initAd);
                }

                private function init():void
                {
                    smileSprite = new Sprite();
                    addChild(smileSprite);

                    smileSprite.graphics.beginFill(0xccff99);
                    smileSprite.graphics.drawCircle(0, 0, 180);
                    smileSprite.graphics.endFill();
                    smileSprite.graphics.beginFill(0x00cc11);
                    smileSprite.graphics.drawCircle(-70, -50, 40);
                    smileSprite.graphics.drawCircle(70, -50, 40);
                    smileSprite.graphics.drawRoundRect(-70, 70, 140, 10, 20);
                    smileSprite.graphics.endFill();

                    smileSprite.x = stage.stageWidth / 2;
                    smileSprite.y = stage.stageHeight / 2;
                    smileSprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
                    smileSprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
                }

                private function onMouseDown(event:MouseEvent):void
                {
                    smileSprite.x += 10;
                    smileSprite.y += 10;
                }

                private function onMouseUp(event:MouseEvent):void
                {
                    smileSprite.x -= 10;
                    smileSprite.y -= 10;
                }

                private function initAd(e:Event = null):void
                {
                    removeEventListener(Event.ADDED_TO_STAGE, initAd);
                    stage.scaleMode = StageScaleMode.NO_SCALE;
                    stage.showDefaultContextMenu = false;
                    stage.align = StageAlign.TOP_LEFT;
                    stage.addEventListener(Event.RESIZE, onResize);

                    loader = new Loader();
                    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
                    var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
                    loader.load(new URLRequest("http://rs.mail.ru/vp/adman2.swf"), context);
                }

                private function onLoadComplete(e:Event):void
                {
                    adman = loader.content;
                    addChild(adman as DisplayObject);
                    onResize();

                    adman.addEventListener("admanMessage", onAdmanEvent);
                    adman.addEventListener("adBannerStarted", onAdmanEvent);
                    adman.addEventListener("adBannerStopped", onAdmanEvent);
                    adman.addEventListener("adTimeLeft", onAdmanEvent);
                    adman.addEventListener("adReady", onAdmanEvent);
                    adman.addEventListener("adLoadFailed", onAdmanEvent);
                    adman.addEventListener("adInitFailed", onAdmanEvent);
                    adman.addEventListener("adError", onAdmanEvent);
                    adman.addEventListener("adStarted", onAdmanEvent);
                    adman.addEventListener("adCompleted", onAdmanEvent);
                    adman.addEventListener("adStopped", onAdmanEvent);
                    adman.addEventListener("adClicked", onAdmanEvent);
                    adman.init(4398,{requestParams:{preview:3}});
                    adman.load();
                }

                private function onAdmanEvent(e:Event):void
                {
                    trace("event from adman:", e.type);
                    if (e.type != "admanMessage") {
                        if (e.type == "adReady") adman.start("preroll");
                    }
                    else {
                        trace(e["message"]);
                    }
                }

                private function onResize(e:Event = null):void
                {
                    if (adman) adman.setSize(stage.stageWidth, stage.stageHeight);
                }
            }
        }
