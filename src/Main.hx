package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.geom.Point;
import flash.Lib;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Loader;
import flash.display.LoaderInfo;


import flash.utils.ByteArray;

/**
 * ...
 * @author djoker
 */

class Main extends Sprite 
{
	var inited:Bool;
	var pack:DataPack;


	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		var read:Bool = true;
		
		
		if (read)
		{
			pack = new DataPack();
	        pack.load("assets/pack.txt");
			
		
		
			/*
			var bmp:Bitmap = pack.getBitmap("djoker");
			if (bmp != null)
			{
			 bmp.x = 200;
			 bmp.y = 100;
			 addChild(bmp);
			}
			
			var data:BitmapData = pack.getBitmapData("fire_particle");
			if (data != null)		
			{
			 var bmp:Bitmap = new Bitmap(data);
			 bmp.x = 100;
			 bmp.y = 100;
			 addChild(bmp);
			
			}
			*/
			var bmpdata:BitmapData =bytesToBitmap( pack.getFileData("fire_particle"));
	         if (bmpdata != null)		
			{
			 var bmp:Bitmap = new Bitmap(bmpdata);
			 bmp.x = 100;
			 bmp.y = 100;
			 addChild(bmp);
			
			}
			
			
		//	convertStringToBitmap(	pack.getFileData("fire"));
		
			
			//  trace(pack.getFileStrings("blaster"));
			//  trace(pack.getFileStrings("fire"));
			//	trace(pack.getFileStrings("phoenix"));
			
			
			//pack.dispose();
		//	pack = null;
	 
		} else{
		
		pack = new DataPack();
	    pack.addFile('assets/blaster.xml', 'blaster');
		pack.addFile('assets/openfl.svg', 'openfl');
		pack.addFile('assets/fire_particle.png', 'fire_particle');
		pack.addFile('assets/djoker.jpg', 'djoker');
	
		pack.save("pack.txt");
		pack.dispose();
		pack = null;
		}

	}

	/* SETUP */

	private function bytesToBitmap(ba:ByteArray) :BitmapData
{
	var imgLoader:Loader;
	var bdata:BitmapData = null;
   imgLoader = new Loader();
   trace("set events");
   imgLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
   imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,  function loadData(e:Event):Void
   {
	    trace("copy");
        var bitmap:Bitmap = cast(imgLoader.content, Bitmap);
        bdata = bitmap.bitmapData.clone();
   });
   
   trace("load bytes");
   imgLoader.loadBytes(ba);
   trace("return");

   return bdata;
}

function onProgress( event : ProgressEvent ) : Void
{
	var progress:Int = 0;
	{
    trace("Percent loaded  :" + Math.round(((event.bytesLoaded / event.bytesTotal ) * 100)));     
	progress++;
	}
}


	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
