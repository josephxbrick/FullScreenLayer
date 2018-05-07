class exports.FullScreenLayer extends Layer
	constructor: (@options = {}) ->
		super _.defaults @options,
			backgroundColor: ""
		@dpr = 1
		@originX = 0
		@originY = 0
		@size = Screen.size
		
		Events.wrap(document).addEventListener "webkitfullscreenchange", (event) =>
			@dpr = Framer.CurrentContext.devicePixelRatio
			Framer.Device.contentScale = 1/@dpr
			
		Screen.onResize =>
			@width = Screen.width * @dpr
			@height = Screen.height * @dpr
			
		@getFullScreenPermission()

	getFullScreenPermission: ->
		return if Utils.isAndroid() is false
		# make fullScreenButton
		backing = new Layer
			size: Screen.size
			backgroundColor: "white"
		fullScreenButton = new Layer
			width: 300
			height: 80
			backgroundColor: "dodgerblue"
			borderRadius: 10
			parent: backing
		txt = new TextLayer
			width: fullScreenButton.width
			textAlign: "center"
			fontSize: 26
			color: "white"
			parent: fullScreenButton
			y: Align.center
			text: "Tap for Fullscreen"
		fullScreenButton.point = Align.center
		backing.bringToFront()
		fullScreenButton.onTap -> 
			document.documentElement.webkitRequestFullscreen()
			@parent.destroy()
