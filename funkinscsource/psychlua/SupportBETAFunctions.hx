package psychlua;

import flixel.FlxObject;
import flixel.util.FlxAxes;

import openfl.utils.Assets;
import openfl.filters.ShaderFilter;

import lime.app.Application;

import objects.Note;
import objects.Character;
import objects.HealthIcon;

import psychlua.LuaUtils;

import shaders.ColorSwap;

import codenameengine.CustomCodeShader;

using StringTools;

class SupportBETAFunctions
{
    //some kade / psych stuff from blantados, thanks ! (Added for lua, some of kade)
    public static function implement(funk:FunkinLua, game:PlayState)
    {
        //set actors
		funk.set("setActorX", function(x:Int,id:String) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.x = x;
		});
		
		funk.set("setActorScreenCenter", function(id:String, ?pos:String = 'xy') {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			switch(pos.trim().toLowerCase())
			{
				case 'x': shit.screenCenter(X);
				case 'y': shit.screenCenter(Y);
				default: shit.screenCenter(XY);
			}			
		});

		funk.set("setActorAccelerationX", function(x:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].acceleration.x = x;
			else LuaUtils.getActorByName(id).acceleration.x = x;
		});
		
		funk.set("setActorDragX", function(x:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].drag.x = x;
			else LuaUtils.getActorByName(id).drag.x = x;
		});
		
		funk.set("setActorVelocityX", function(x:Int,id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].velocity.x = x;
			else LuaUtils.getActorByName(id).velocity.x = x;		
		});

		funk.set("setActorAlpha", function(alpha:Float,id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].alpha = alpha;
			else LuaUtils.getActorByName(id).alpha = alpha;
		});

		funk.set("setActorVisibility", function(visible:Bool,id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].visible = visible;
			else LuaUtils.getActorByName(id).visible = visible;	
		});

		funk.set("setActorY", function(y:Int, id:String, ?bg:Bool = false) {
			LuaUtils.getActorByName(id).y = y;	
		});

		funk.set("setActorAccelerationY", function(y:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].acceleration.y = y;
			else LuaUtils.getActorByName(id).acceleration.y = y;
		});
		
		funk.set("setActorDragY", function(y:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].drag.y = y;
			else LuaUtils.getActorByName(id).drag.y = y;
		});
		
		funk.set("setActorVelocityY", function(y:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].velocity.y = y;
			else LuaUtils.getActorByName(id).velocity.y = y;
		});
		
		funk.set("setActorAngle", function(angle:Int, id:String, ?bg:Bool = false) {
			if (bg) game.Stage.swagBacks[id].angle = angle;
			else LuaUtils.getActorByName(id).angle = angle;
		});

		funk.set("setActorScale", function(scale:Float,id:String) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.setGraphicSize(Std.int(shit.width * scale));
			shit.updateHitbox();	
		});
		
		funk.set("setActorScaleXY", function(scaleX:Float, scaleY:Float, id:String)
		{
			LuaUtils.getActorByName(id).setGraphicSize(Std.int(LuaUtils.getActorByName(id).width * scaleX), Std.int(LuaUtils.getActorByName(id).height * scaleY));
		});

		funk.set("setActorFlipX", function(flip:Bool, id:String)
		{
			LuaUtils.getActorByName(id).flipX = flip;
		});

		funk.set("setActorFlipY", function(flip:Bool, id:String)
		{
			LuaUtils.getActorByName(id).flipY = flip;
		});

        funk.set("setActorColorRGB", function(id:String, color:String) {
            var actor:FlxSprite = LuaUtils.getActorByName(id);
            var colors = color.split(',');
            var red = Std.parseInt(colors[0]);
            var green = Std.parseInt(colors[1]);
            var blue = Std.parseInt(colors[2]);
            if(actor != null) Reflect.setProperty(actor, "color", FlxColor.fromRGB(red,green,blue));
        });

		funk.set("setActorScroll", function(x:Float,y:Float,id:String) {
            var actor = LuaUtils.getActorByName(id);
            if(LuaUtils.getActorByName(id) != null)
            {
                actor.scrollFactor.set(x,y);
            }
        });

		funk.set("setActorColor", function(id:String,r:Int,g:Int,b:Int,alpha:Int = 255) {
            if(LuaUtils.getActorByName(id) != null)
            {
                Reflect.setProperty(LuaUtils.getActorByName(id), "color", FlxColor.fromRGB(r, g, b, alpha));
            }
        });

		funk.set("setActorLayer", function(id:String, layer:Int) {
            var actor = LuaUtils.getActorByName(id);
            if(actor != null)
            {
                game.remove(actor);
                game.insert(layer, actor);
            }
        });

		//get actors
		funk.set("getActorWidth", function (id:String) {
			return LuaUtils.getActorByName(id).width;
		});

		funk.set("getActorHeight", function (id:String) {
			return LuaUtils.getActorByName(id).height;
		});

		funk.set("getActorAlpha", function(id:String) {
			return LuaUtils.getActorByName(id).alpha;
		});

		funk.set("getActorAngle", function(id:String) {
			return LuaUtils.getActorByName(id).angle;
		});

		funk.set("getActorX", function (id:String, ?bg:Bool = false) {
			if (bg) return game.Stage.swagBacks[id].x;
			else return LuaUtils.getActorByName(id).x;
		});

		funk.set("getCameraZoom", function (id:String) {
			return game.defaultCamZoom;
		});

		funk.set("getActorY", function (id:String, ?bg:Bool = false) {
			if (bg) return game.Stage.swagBacks[id].y;
			else return LuaUtils.getActorByName(id).y;
		});

		funk.set("getActorXMidpoint", function (id:String, ?graphic:Bool = false) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			if (graphic) return shit.getGraphicMidpoint().x;
			return shit.getMidpoint().x;
		});

		funk.set("getActorYMidpoint", function (id:String, ?graphic:Bool = false) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			if (graphic) return shit.getGraphicMidpoint().y;
			return shit.getMidpoint().y;
		});

		funk.set("getActorLayer", function(id:String) {
            var actor = LuaUtils.getActorByName(id);
            if(actor != null) return game.members.indexOf(actor);
            else return -1;
        });

		funk.set("characterZoom", function(id:String, zoomAmount:Float) {
			if(game.modchartCharacters.exists(id) && ClientPrefs.data.characters) {
				var spr:Character = game.modchartCharacters.get(id);
				spr.setZoom(zoomAmount);
			}
			else LuaUtils.getActorByName(id).setZoom(zoomAmount);
		});

		funk.set("tweenColor", function(vars:String, duration:Float, initColor:FlxColor, finalColor:FlxColor, ease:String, ?tag:String) {
			if (game != null){duration = duration / game.playbackRate;}
			if (tag == null){tag = vars+'TweenCol';}
			var penisExam:Dynamic = LuaUtils.tweenPrepare(tag, vars);
			if(penisExam != null) {
				game.modchartTweens.set(tag, FlxTween.color(penisExam, duration, initColor, finalColor, {
					ease: LuaUtils.getTweenEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						game.callOnLuas('onTweenCompleted', [tag]);
						game.modchartTweens.remove(tag);
					}
				}));
			} else {
				FunkinLua.luaTrace('tweenColor: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});

		//and then one that's more akin to psych which has tags first as to not mess up the original
		funk.set("doTweenColor2", function(tag:String, vars:String, duration:Float, initColor:FlxColor, finalColor:FlxColor, ease:String, ?tag:String) {
			if (game != null){duration = duration / game.playbackRate;}
			var penisExam:Dynamic = LuaUtils.tweenPrepare(tag, vars);
			if(penisExam != null) {
				game.modchartTweens.set(tag, FlxTween.color(penisExam, duration, initColor, finalColor, {
					ease: LuaUtils.getTweenEaseByString(ease),
					onComplete: function(twn:FlxTween) {
						game.callOnLuas('onTweenCompleted', [tag]);
						game.modchartTweens.remove(tag);
					}
				}));
			} else {
				FunkinLua.luaTrace('doTweenColor2: Couldnt find object: ' + vars, false, false, FlxColor.RED);
			}
		});

		funk.set("enablePurpleMiss", function(id:String,toggle:Bool) {
			LuaUtils.getActorByName(id).doMissThing = toggle;
		});

		//tweens
		funk.set("tweenCameraPos", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {x: toX, y: toY}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenCameraAngle", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {angle: toAngle}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenCameraZoom", function(toZoom:Float, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {zoom: toZoom}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudPos", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {x: toX, y: toY}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenHudAngle", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {angle: toAngle}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudZoom", function(toZoom:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {zoom: toZoom}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenPos", function(id:String, toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, y: toY}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosQuad", function(id:String, toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, y: toY}, time, {ease: FlxEase.quadInOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosXAngle", function(id:String, toX:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, angle: toAngle}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosYAngle", function(id:String, toY:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {y: toY, angle: toAngle}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenAngle", function(id:String, toAngle:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {angle: toAngle}, time, {ease: FlxEase.linear, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenCameraPosOut", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {x: toX, y: toY}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenCameraAngleOut", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {angle: toAngle}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenCameraZoomOut", function(toZoom:Float, time:Float, ease:String, onComplete:String) {
			FlxTween.tween(FlxG.camera, {zoom: toZoom}, time, {ease: LuaUtils.getTweenEaseByString(ease), onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudPosOut", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {x: toX, y: toY}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenHudAngleOut", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {angle: toAngle}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudZoomOut", function(toZoom:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {zoom: toZoom}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenPosOut", function(id:String, toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, y: toY}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosXAngleOut", function(id:String, toX:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, angle: toAngle}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosYAngleOut", function(id:String, toY:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {y: toY, angle: toAngle}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenAngleOut", function(id:String, toAngle:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {angle: toAngle}, time, {ease: FlxEase.cubeOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenCameraPosIn", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {x: toX, y: toY}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenCameraAngleIn", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(FlxG.camera, {angle: toAngle}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenCameraZoomIn", function(toZoom:Float, time:Float, ease:String, onComplete:String) {
			FlxTween.tween(FlxG.camera, {zoom: toZoom}, time, {ease: LuaUtils.getTweenEaseByString(ease), onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudPosIn", function(toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {x: toX, y: toY}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});
						
		funk.set("tweenHudAngleIn", function(toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {angle: toAngle}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenHudZoomIn", function(toZoom:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.camHUD, {zoom: toZoom}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,["camera"]);}}});
		});

		funk.set("tweenPosIn", function(id:String, toX:Int, toY:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, y: toY}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosXAngleIn", function(id:String, toX:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {x: toX, angle: toAngle}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenPosYAngleIn", function(id:String, toY:Int, toAngle:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {y: toY, angle: toAngle}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenAngleIn", function(id:String, toAngle:Int, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {angle: toAngle}, time, {ease: FlxEase.cubeIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenFadeIn", function(id:String, toAlpha:Float, time:Float, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {alpha: toAlpha}, time, {ease: FlxEase.circIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenFadeInBG", function(id:String, toAlpha:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.Stage.swagBacks[id], {alpha: toAlpha}, time, {ease: FlxEase.circIn, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenFadeOut", function(id:String, toAlpha:Float, time:Float, ease:String, onComplete:String) {
			FlxTween.tween(LuaUtils.getActorByName(id), {alpha: toAlpha}, time, {ease: LuaUtils.getTweenEaseByString(ease), onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenFadeOutBG", function(id:String, toAlpha:Float, time:Float, onComplete:String) {
			FlxTween.tween(game.Stage.swagBacks[id], {alpha: toAlpha}, time, {ease: FlxEase.circOut, onComplete: function(flxTween:FlxTween) { if (onComplete != '' && onComplete != null) {funk.call(onComplete,[id]);}}});
		});

		funk.set("tweenFadeOutOneShot", function(id:String, toAlpha:Float, time:Float) {
			FlxTween.tween(LuaUtils.getActorByName(id), {alpha: toAlpha}, time, {type: FlxTweenType.ONESHOT});
		});

		funk.set("RGBColor", function (r:Int,g:Int,b:Int, alpha:Int = 255) {
			return FlxColor.fromRGB(r, g, b, alpha);
		});

		//masking!
		funk.set("addClipRect", function(obj:String, x:Float, y:Float, width:Float, height:Float) {
			var split:Array<String> = obj.split('.');
			var object:Dynamic = LuaUtils.getObjectDirectly(split[0]);
			if(split.length > 1) {
				object = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}

			if(object != null) {
				var swagRect = (object.clipRect != null ? object.clipRect : new FlxRect());
				swagRect.x = x;
				swagRect.y = y;
				swagRect.width = width;
				swagRect.height = height;

				object.clipRect = swagRect;
				return true;
			}
			FunkinLua.luaTrace("addClipRect: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});

		funk.set("setClipRectAngle", function(obj:String, degrees:Float) {
			var daRect:FlxRect = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop([obj, 'clipRect']), 'clipRect');

			if(daRect != null) {
				daRect.getRotatedBounds(degrees);

				var split:Array<String> = obj.split('.');
				var object:FlxSprite = LuaUtils.getObjectDirectly(split[0]);
				if(split.length > 1) {
					object = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
				}

				object.clipRect = daRect;
				return true;
			}
			FunkinLua.luaTrace("setClipRectAngle: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});

		funk.set("objectColorTransform", function(obj:String, color:String) {
			var spr:Dynamic = LuaUtils.getObjectDirectly(obj);

			if(spr != null) {
				spr.useColorTransform = true;

				var daColor:String = color;
				if(!color.startsWith('0x')) daColor = '0xff'+color;

				var r, g, b, a:Int = 255;

				daColor = daColor.substring(2);

				r = Std.parseInt('0x' + daColor.substring(2,4));
				g = Std.parseInt('0x' + daColor.substring(4,6));
				b = Std.parseInt('0x' + daColor.substring(6,8));
				a = Std.parseInt('0x' + daColor.substring(0,2));

				spr.setColorTransform(0, 0, 0, 1, r, g, b, a);
			}
		});

		funk.set("objectColorTween", function(obj:String, duration:Float, color:String, color2:String, ?ease:String = 'linear') {
			var spr:Dynamic = LuaUtils.getObjectDirectly(obj);

			if(spr != null) {
				var colorNum:Int = Std.parseInt(color);
				if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

				var colorNum2:Int = Std.parseInt(color2);
				if(!color2.startsWith('0x')) colorNum2 = Std.parseInt('0xff' + color2);

				FlxTween.color(spr, duration, colorNum, colorNum2, {ease: LuaUtils.getTweenEaseByString(ease)});
			}
		});

		funk.set("inBetweenColor", function(color:String, color2:String, diff:Float, ?remove0:Bool = false) {
			var colorNum:Int = Std.parseInt(color);
			if(!color.startsWith('0x')) colorNum = Std.parseInt('0xff' + color);

			var colorNum2:Int = Std.parseInt(color2);
			if(!color2.startsWith('0x')) colorNum2 = Std.parseInt('0xff' + color2);

			var color = FlxColor.interpolate(colorNum, colorNum2, diff);
			var daColor = color.toHexString();

			if (remove0)
				daColor = daColor.substring(2);

			return daColor;
		});

		funk.set("setCamFollow", function(x:Float, y:Float) {
			game.isCameraOnForcedPos = true;
			game.camFollow.setPosition(x, y);
		});

		funk.set("offCamFollow", function(id:String) {
			game.isCameraOnForcedPos = false;
		});

		funk.set("snapCam", function(x:Float, y:Float) {
			game.isCameraOnForcedPos = true;
			game.charCam = null;
			game.forceChangeOnTarget = true;
			game.cameraTargeted = '';
			
			var camPosition:FlxObject = new FlxObject(0, 0, 1, 1);
			camPosition.setPosition(x, y);
			FlxG.camera.focusOn(camPosition.getPosition());
		});

		funk.set("resetSnapCam", function(id:String) {
			//The string does absolutely nothing
			game.isCameraOnForcedPos = false;
			game.forceChangeOnTarget = false;
			game.cameraTargeted = 'dad';
		});

		funk.set("shakeCam", function (i:Float, d:Float) {
			FlxG.camera.shake(i, d);
		});

		funk.set("shakeHUD", function (i:Float, d:Float) {
			game.camHUD.shake(i, d);
		});

		funk.set("setCamZoom", function(zoomAmount:Float) {
			FlxG.camera.zoom = zoomAmount;
		});

		funk.set("addCamZoom", function(zoomAmount:Float) {
			FlxG.camera.zoom += zoomAmount;
		});

		funk.set("addHudZoom", function(zoomAmount:Float) {
			game.camHUD.zoom += zoomAmount;
		});

		funk.set("getArrayLength", function(obj:String) {
			var shit:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			return shit.length;
		});

		funk.set("getMapLength", function(obj:String) {
			var split:Array<String> = obj.split('.');
			var shit:Map<String, Dynamic> = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			if(split.length > 1)
			{
				shit = Reflect.getProperty(Type.resolveClass(split[0]), split[1]);

				if (shit == null)
					shit = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}
	
			var daArray:Array<String> = [];

			for (key in shit.keys())
				daArray.push(key);
			
			return daArray.length;
		});

		funk.set("getMapKeys", function(obj:String, ?getValue:Bool = false) {
			var split:Array<String> = obj.split('.');
			var shit:Map<String, Dynamic> = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			if(split.length > 1)
			{
				shit = Reflect.getProperty(Type.resolveClass(split[0]), split[1]);

				if (shit == null)
					shit = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}

			var daArray:Array<String> = [];

			for (key in shit.keys())
				daArray.push(key);

			if (getValue)
			{
				for (i in 0...daArray.length)
					daArray[i] = shit.get(daArray[i]);
			}
			
			return daArray;
		});

		funk.set("getMapKey", function(obj:String, valName:String) {
			var split:Array<String> = obj.split('.');
			var shit:Map<String, Dynamic> = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			if(split.length > 1)
			{
				shit = Reflect.getProperty(Type.resolveClass(split[0]), split[1]);

				if (shit == null)
					shit = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}

			return shit[valName];
		});

		funk.set("setMapKey", function(obj:String, valName:String, val:Dynamic) {
			var split:Array<String> = obj.split('.');
			var shit:Map<String, Dynamic> = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			if(split.length > 1)
			{
				shit = Reflect.getProperty(Type.resolveClass(split[0]), split[1]);

				if (shit == null)
					shit = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}

			shit[valName] = val;
		});

		funk.set("removeObject", function(id:String) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			game.removeObject(shit);
		});

		funk.set("addObject", function(id:String) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			game.addObject(shit);
		});

		funk.set("animationSwap", function(char:String, anim1:String, anim2:String) {
			var shit = LuaUtils.getObjectDirectly(char);

			if (shit.animation.getByName(anim1) != null)
			{
				var oldRight = shit.animation.getByName(anim1).frames;
				shit.animation.getByName(anim1).frames = shit.animation.getByName(anim2).frames;
				shit.animation.getByName(anim2).frames = oldRight;
			}
		});

		funk.set("destroyObject", function(id:String, ?bg:Bool = false) {
			if (bg){
				game.Stage.destroyObject(game.Stage.swagBacks[id]);
			}else{
				var shit:Dynamic = LuaUtils.getObjectDirectly(id);
				game.destroyObject(shit);
			}
		});

		funk.set("removeGroupObject", function(obj:String, index:Int = 0) {
			var shit:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			shit.forEach(function(spr:Dynamic)
			{			
				if (spr.ID == index)		
					game.removeObject(spr);
			});
		});

		funk.set("destroyGroupObject", function(obj:String, index:Int = 0) {
			//i have no idea if this works.... it works
			var shit:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			shit.forEach(function(spr:Dynamic)
			{			
				if (spr.ID == index)		
					spr.destroy();
			});
		});

		funk.set("changeAnimOffset", function(id:String , x:Float, y:Float) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.addOffset(x, y); // it may say addoffset but it actually changes it instead of adding to the existing offset so this works.
		});

		funk.set("getDominantColor", function(sprite:String){
			var shit:Dynamic = LuaUtils.getObjectDirectly(sprite);

			var coolColor = FlxColor.fromInt(CoolUtil.dominantColor(shit));
			var daColor = coolColor.toHexString();

			return daColor;
		});

		funk.set("changeDadIcon", function(id:String) {
			game.iconP2.changeIcon(id);
		});

		funk.set("changeBFIcon", function(id:String) {
			game.iconP1.changeIcon(id);
		});

		funk.set("changeIcon", function(obj:String, iconName:String) {
			var split:Array<String> = obj.split('.');
			var object:HealthIcon = LuaUtils.getObjectDirectly(split[0]);
			if(split.length > 1) {
				object = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
			}

			if(object != null) {
				object.changeIcon(iconName);
				return true;
			}
			FunkinLua.luaTrace("changeIcon: Icon " + obj + " doesn't exist!", false, false, FlxColor.RED);
			return false;
		});

		funk.set("removeLuaIcon", function(tag:String) {
			if(!game.modchartIcons.exists(tag)) {
				return;
			}
			
			var pee:HealthIcon = game.modchartIcons.get(tag);
			pee.kill();
			LuaUtils.getTargetInstance().remove(pee, true);
			pee.destroy();
			game.modchartIcons.remove(tag);
		});

		funk.set("changeDadIconNew", function(id:String) {
			game.iconP2.changeIcon(id);
		});

		funk.set("changeBFIconNew", function(id:String) {
			game.iconP1.changeIcon(id);
		});

		funk.set("setWindowPos",function(x:Int = 0, y:Int = 0) {
			Application.current.window.x = x;
			Application.current.window.y = y;
		});

		funk.set("getWindowX",function() {
			return Application.current.window.x;
		});

		funk.set("getWindowY",function() {
			return Application.current.window.y;
		});

		funk.set("resizeWindow",function(Width:Int,Height:Int) {
			Application.current.window.resize(Width,Height);
		});
		
		funk.set("getScreenWidth",function() {
			return Application.current.window.display.currentMode.width;
		});

		funk.set("getScreenHeight",function() {
			return Application.current.window.display.currentMode.height;
		});

		funk.set("getWindowWidth",function() {
			return Application.current.window.width;
		});

		funk.set("getWindowHeight",function() {
			return Application.current.window.height;
		});

		funk.set("arrayContains", function(obj:String, value:Dynamic) {
			var leArray:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			if (leArray.contains(value))
				return true;

			return false;
		});

		funk.set("setOffset", function(id:String, x:Float, y:Float) {
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.offset.set(x, y);
		});

		funk.set("updateHealthbar", function(dadColor:String = "", bfColor:String = ""){
			if (!ClientPrefs.data.healthColor) return;
			// ALREADY CONTAINS # JUST ADD THE REST OF THE CODE (FFFFFF / 000000 / 30DB01)
			var opponent:String;
			var player:String;

			if (dadColor == "" || dadColor == null || dadColor == '')
				opponent = game.dad.iconColor;
			else
				opponent = dadColor;

			if (bfColor == "" || bfColor == null || bfColor == '')
				player = game.boyfriend.iconColor;
			else
				player = bfColor;

			var flxStringUsageBool:Bool = ((opponent.contains('#') || opponent.contains('#FF') || opponent.contains('0x')) || 
				(player.contains('#') || player.contains('#FF') || player.contains('0x')));
			
			if (PlayState.SONG.oldBarSystem)
			{
				if (!ClientPrefs.data.gradientSystemForOldBars)
				{
					if (flxStringUsageBool) {
						game.healthBar.createFilledBar((game.opponentMode ? FlxColor.fromString(player) : FlxColor.fromString(opponent)), 
							(game.opponentMode ? FlxColor.fromString(opponent) : FlxColor.fromString(player)));
					}
					else {
						game.healthBar.createFilledBar((game.opponentMode ? CoolUtil.colorFromString(player) : CoolUtil.colorFromString(opponent)), 
							(game.opponentMode ? CoolUtil.colorFromString(opponent) : CoolUtil.colorFromString(player)));
					}
				}
				else
				{
					if (flxStringUsageBool) 
						game.healthBar.createGradientBar([FlxColor.fromString(player), FlxColor.fromString(opponent)], 
							[FlxColor.fromString(player), FlxColor.fromString(opponent)]);
					else
						game.healthBar.createGradientBar([FlxColor.fromString(player), FlxColor.fromString(opponent)], 
							[FlxColor.fromString(player), FlxColor.fromString(opponent)]);
				}
				game.healthBar.updateBar();
			}
			else
			{
				if (flxStringUsageBool) {
					game.healthBarNew.setColors(FlxColor.fromString(opponent), FlxColor.fromString(player));
					game.healthBarHitNew.setColors(FlxColor.fromString(opponent), FlxColor.fromString(player));
				}
				else {
					game.healthBarNew.setColors(CoolUtil.colorFromString(opponent), CoolUtil.colorFromString(player));
					game.healthBarHitNew.setColors(CoolUtil.colorFromString(opponent), CoolUtil.colorFromString(player));
				}
			}
		});

		funk.set("getScared", function(id:String) {
			game.Stage.swagBacks[id].swapDanceType();
		});

		funk.set("getStageOffsets", function (char:String, value:String) {
			switch (char)
			{
				case 'boyfriend' | 'bf':
					return (value == 'y' ? game.Stage.bfYOffset : game.Stage.bfXOffset);
				case 'gf':
					return (value == 'y' ? game.Stage.gfYOffset : game.Stage.gfXOffset);
				case 'mom':
					return (value == 'y' ? game.Stage.momYOffset : game.Stage.momXOffset);
				default:
					return (value == 'y' ? game.Stage.dadYOffset : game.Stage.dadXOffset);
			}
		});

		funk.set("cacheCharacter", function(character:String = 'bf', ?superCache:Bool = false){
			game.cacheCharacter(character, superCache);
		});

		//change individual values
		funk.set("changeHue", function(id:String, hue:Int) {
			var newShader:ColorSwap = new ColorSwap();
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.shader = newShader.shader;
			newShader.hue = hue / 360;
		});

		funk.set("changeSaturation", function(id:String, sat:Int) {
			var newShader:ColorSwap = new ColorSwap();
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.shader = newShader.shader;
			newShader.saturation = sat / 100;
		});

		funk.set("changeBrightness", function(id:String, bright:Int) {
			var newShader:ColorSwap = new ColorSwap();
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.shader = newShader.shader;
			newShader.brightness = bright / 100;
		});

		//change as a group. you should probably use this one
		funk.set("changeHSB", function(id:String, hue:Int = 0, sat:Int = 0, bright:Int = 0) {
			var newShader:ColorSwap = new ColorSwap();
		
			var shit:Dynamic = LuaUtils.getObjectDirectly(id);
			shit.shader = newShader.shader;
			newShader.hue = hue / 360;
			newShader.saturation = sat / 100;
			newShader.brightness = bright / 100;
		});

		funk.set("changeGroupHue", function(obj:String, hue:Int) {
			var shit:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj);

			shit.forEach(function(thing:Dynamic)
			{
				var newShader:ColorSwap = new ColorSwap();
				newShader.hue = hue / 360;
				thing.shader = newShader.shader;
			});
		});

		funk.set("changeGroupMemberHue", function(obj:String, index:Int, hue:Int) {
			var shit:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(), obj)[index];

			if(Std.isOfType(Reflect.getProperty(LuaUtils.getTargetInstance(), obj), FlxTypedGroup))
				shit = Reflect.getProperty(LuaUtils.getTargetInstance(), obj).members[index];

			var newShader:ColorSwap = new ColorSwap();
			newShader.hue = hue / 360;
			shit.shader = newShader.shader;

		});

		funk.set("changeNotes", function(style:String, character:String, ?postfix:String = "") {
			switch (character)
			{
				case 'boyfriend' | 'bf':
					game.notes.forEach(function(daNote:Note)
					{
						if (daNote.mustPress)
						{
							if (daNote.noteType != "")
								game.callOnScripts('onNoteChange', [style, postfix]); //i really don't wanna use this but I will if I have to
							else
								daNote.reloadNote(style, postfix);
						}
					});
				default:
					game.notes.forEach(function(daNote:Note)
					{
						if (!daNote.mustPress)
						{
							if (daNote.noteType != "")
								game.callOnScripts('onNoteChange', [style, postfix]); //i really don't wanna use this but I will if I have to
							else
								daNote.reloadNote(style, postfix);
						}
					});
			}
		});

		funk.set("changeNotes2", function(style:String, character:String, ?postfix:String = "") {
			for (i in 0...game.unspawnNotes.length)
			{
				var daNote = game.unspawnNotes[i];
				switch (character)
				{
					case 'boyfriend' | 'bf':
						if (daNote.mustPress)
							daNote.reloadNote(style, postfix);
					default:
						if (!daNote.mustPress)
							daNote.reloadNote(style, postfix);
				}
			}
		});

		funk.set("changeIndividualNotes", function(style:String, i:Int, ?postfix:String = "") {
			game.unspawnNotes[i].reloadNote(style, postfix);
		});

		funk.set("playStrumAnim", function(isDad:Bool, id:Int, time:Float = 0) {
			if (!ClientPrefs.data.LightUpStrumsOP && isDad) return;
			if (time > 0) game.strumPlayAnim(isDad, id, time / 1000 / game.playbackRate);	
			else game.strumPlayAnim(isDad, id, Conductor.stepCrochet * 1.25 / 1000 / game.playbackRate);
		});

		// shader bullshit
		funk.set("setActorWaveCircleShader", function(id:String, ?speed:Float = 3, ?frequency:Float = 10, ?amplitude:Float = 0.25) {
			if (LuaUtils.getObjectDirectly(id, false) != null)
			{

				var funnyShader:shaders.FunkinSourcedShaders.WaveCircleEffect = new shaders.FunkinSourcedShaders.WaveCircleEffect();
                funnyShader.waveSpeed = speed;
                funnyShader.waveFrequency = frequency;
                funnyShader.waveAmplitude = amplitude;
                FunkinLua.lua_Shaders.set(id, funnyShader);
                
				LuaUtils.getObjectDirectly(id, false).shader = funnyShader.shader;
			}

            if(LuaUtils.getActorByName(id) != null)
            {
                var funnyShader:shaders.FunkinSourcedShaders.WaveCircleEffect = new shaders.FunkinSourcedShaders.WaveCircleEffect();
                funnyShader.waveSpeed = speed;
                funnyShader.waveFrequency = frequency;
                funnyShader.waveAmplitude = amplitude;
                FunkinLua.lua_Shaders.set(id, funnyShader);
                
                LuaUtils.getActorByName(id).shader = funnyShader.shader;
            }
        });
        
        funk.set("setActorNoShader", function(id:String) {
			if (LuaUtils.getObjectDirectly(id, false) != null)
			{
				FunkinLua.lua_Shaders.remove(id);
                LuaUtils.getObjectDirectly(id, false).shader = null;
			}

            if(LuaUtils.getActorByName(id) != null)
            {
                FunkinLua.lua_Shaders.remove(id);
                LuaUtils.getActorByName(id).shader = null;
            }
        });

        funk.set("initShaderFromSource", function(name:String, classString:String) {

            if (!ClientPrefs.data.shaders)
                return;

            var shaderClass = Type.resolveClass('shaders.'+classString);
            if (shaderClass != null)
            {
                var shad = Type.createInstance(shaderClass, []);
                FunkinLua.lua_Shaders.set(name, shad);
                Debug.logInfo('created shader: '+name+', shader from classString: shaders.'+classString);
            }
            else 
            {
                Application.current.window.alert("Unknown Shader: " + classString,"Shader Not Found!");
            }
        });
        funk.set("setActorShader", function(actorStr:String, shaderName:String) {
            if (!ClientPrefs.data.shaders)
                return;
			
            var shad = FunkinLua.lua_Shaders.get(shaderName);
			var actor = LuaUtils.getActorByName(actorStr);
			var spr:FlxSprite = game.getLuaObject(actorStr);
	
			if(spr==null){
				var split:Array<String> = actorStr.split('.');
				spr = LuaUtils.getObjectDirectly(split[0]);
				if(split.length > 1) {
					spr = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split), split[split.length-1]);
				}
			}

			if (shad != null)
			{
				if (spr != null)
					spr.shader = Reflect.getProperty(shad, 'shader');
				if (actor != null)
					actor.shader = Reflect.getProperty(shad, 'shader');
				
				if (actor == null && spr == null) Debug.logInfo('Actor and spr are both null!');
			}
        });

        funk.set("setShaderProperty", function(shaderName:String, prop:String, value:Dynamic) {
            if (!ClientPrefs.data.shaders)
                return;
            var shad = FunkinLua.lua_Shaders.get(shaderName);

            if(shad != null)
            {
				Reflect.setProperty(shad, prop, value);
            }
        });

		funk.set("getShaderProperty", function(shaderName:String, prop:String) {
            if (!ClientPrefs.data.shaders)
                return;
            var shad = FunkinLua.lua_Shaders.get(shaderName);

            if(shad != null)
            {
				Reflect.getProperty(shad, prop);
            }
        });

        funk.set("tweenShaderProperty", function(tag:String, shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", startVal:Null<Float> = null) {
            if (!ClientPrefs.data.shaders)
                return;
            var shad = FunkinLua.lua_Shaders.get(shaderName);
            var ease = LuaUtils.getTweenEaseByString(easeStr);
			var startValue:Null<Float> = startVal;
			if (startValue == null) startValue = Reflect.getProperty(shad, prop);

            if(shad != null)
            {
                game.modchartTweens.set(tag, 
					PlayState.tweenManager.num(startValue, value, time, {
					ease: ease,
					onUpdate: function(tween:FlxTween) {
						var ting = FlxMath.lerp(startValue, value, ease(tween.percent));
                    	Reflect.setProperty(shad, prop, ting);
					}, 
					onComplete: function(tween:FlxTween) {
						Reflect.setProperty(shad, prop, value);
						game.callOnLuas('onTweenCompleted', [tag]);
						game.modchartTweens.remove(tag);
					}})
				);
                //trace('set shader prop');
            }
        });

		funk.set("setCameraShader", function(camStr:String, shaderName:String) {
            if (!ClientPrefs.data.shaders)
                return;
            var cam = LuaUtils.getCameraByName(camStr);
            var shad = FunkinLua.lua_Shaders.get(shaderName);

            if(cam != null && shad != null)
            {
                cam.shaders.push(new ShaderFilter(Reflect.getProperty(shad, 'shader'))); //use reflect to workaround compiler errors
                cam.shaderNames.push(shaderName);
                cam.cam.setFilters(cam.shaders);
                //trace('added shader '+shaderName+" to " + camStr);
            }
        });
        funk.set("removeCameraShader", function(camStr:String, shaderName:String) {
            if (!ClientPrefs.data.shaders)
                return;
            var cam = LuaUtils.getCameraByName(camStr);
            if (cam != null)
            {
                if (cam.shaderNames.contains(shaderName))
                {
                    var idx:Int = cam.shaderNames.indexOf(shaderName);
                    if (idx != -1)
                    {
                        cam.shaderNames.remove(cam.shaderNames[idx]);
                        cam.shaders.remove(cam.shaders[idx]);
                        cam.cam.setFilters(cam.shaders); //refresh filters
                    }
                    
                }
            }
        });

		funk.set("createCustomShader", function(id:String, file:String, glslVersion:String = '120'){
			var funnyCustomShader:CustomCodeShader = new CustomCodeShader(file, glslVersion);
			FunkinLua.lua_Custom_Shaders.set(id, funnyCustomShader);
		});

		funk.set("setActorCustomShader", function(id:String, actor:String){
			var funnyCustomShader:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(id);
			if (LuaUtils.getActorByName(actor) != null)
				LuaUtils.getActorByName(actor).shader = funnyCustomShader;
			if (LuaUtils.getObjectDirectly(actor, false) != null)
				LuaUtils.getObjectDirectly(actor, false).shader = funnyCustomShader;
		});

		funk.set("setActorNoCustomShader", function(actor:String){
			if (LuaUtils.getActorByName(actor) != null)
				LuaUtils.getActorByName(actor).shader = null;
			if (LuaUtils.getObjectDirectly(actor, false) != null)
				LuaUtils.getObjectDirectly(actor, false).shader = null;
		});

		funk.set("setCameraCustomShader", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(id);
			LuaUtils.cameraFromString(camera).setFilters([new ShaderFilter(funnyCustomShader)]);
		});

		funk.set("pushShaderToCamera", function(id:String, camera:String){
			var funnyCustomShader:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(id);
			#if (flixel >= "5.4.0")
				LuaUtils.cameraFromString(camera)._filters.push(new ShaderFilter(funnyCustomShader));
			#else
				@:privateAccess
				LuaUtils.cameraFromString(camera)._filters.push(new ShaderFilter(funnyCustomShader));
			#end
		});

		funk.set("setCameraNoCustomShader", function(camera:String){
			LuaUtils.cameraFromString(camera).setFilters(null);
		});

		funk.set("getCustomShaderProperty", function(id:String, property:String) {
			var funnyCustomShader:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(id);
			return funnyCustomShader.get(property);
		});

		funk.set("setCustomShaderProperty", function(id:String, property:String, value:Dynamic) {
			var funnyCustomShader:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(id);
			funnyCustomShader.set(property, value);
		});

		//Custom shader made by me (glowsoony)
		funk.set("tweenCustomShaderProperty", function(tag:String, shaderName:String, prop:String, value:Dynamic, time:Float, easeStr:String = "linear", startVal:Null<Float> = null) {
            if (!ClientPrefs.data.shaders)
                return;
            var shad:CustomCodeShader = FunkinLua.lua_Custom_Shaders.get(shaderName);
            var ease = LuaUtils.getTweenEaseByString(easeStr);
			var startValue:Null<Float> = startVal;
			if (startValue == null) startValue = shad.get(prop);

            if(shad != null)
            {
				game.modchartTweens.set(tag, 
					PlayState.tweenManager.num(startValue, value, time, {
					onUpdate: function(tween:FlxTween){
						var ting = FlxMath.lerp(startValue, value, ease(tween.percent));
                    	shad.set(prop, ting);
					}, ease: ease, 
					onComplete: function(tween:FlxTween) {
						shad.set(prop, value);
						game.callOnLuas('onTweenCompleted', [tag]);
						game.modchartTweens.remove(tag);
					}})
				);
                //trace('set shader prop');
            }
        });
    }
}