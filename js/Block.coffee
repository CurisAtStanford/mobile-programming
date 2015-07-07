
# Creating a new block
# This class has five fields:
# 	blockID
# 	type
# 	subtype

class Block
	# Types
	@location = "location"

	# Subtypes
	@point = "point"

	# BlockIDs
	@MY_LOCATION = 0
	@MY_AREA = 1

	constructor: (@blockID) ->
		switch @blockID
			when @MY_LOCATION
				createMyLocation()
			when @MY_AREA
				createMyArea()
			else console.log "BAD!"


