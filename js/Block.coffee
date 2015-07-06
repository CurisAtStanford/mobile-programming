###
Creating a new block 
This class has five fields:
	blockID
	type
	subtype
	info
	name
###


class Block
	###
	Types
	###
	@location = "location"

	###
	Subtypes
	###
	@point = "point"

	###
	blockIDs
	###
	@MY_LOCATION = 0
	@MY_AREA = 1

	constructor: (@blockID, @info) ->
		
		switch @blockID
			when @MY_LOCATION
				createMyLocation()
			when @MY_AREA
				createMyArea()
			else console.log "BAD!"

	###
	Methods that don;t need to be accessed 
	by the client
	###
	createMyLocation: ->

