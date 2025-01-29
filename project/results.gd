extends Node2D

var scores = [6] #B O G P I Y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for score in get_tree().get_nodes_in_group("scoreText"):
		score.text = "?"
	scores = [0,0,0,0,0,0]
	set_inkling_visibility()
	tally_scores()
	
func tally_scores():
	for c in Splathello.squareColors:
		for r in c:
			match r:		#TEMP This will work differently for 2P
				"blue":
					scores[0] += 1
				"orange":
					scores[1] += 1
				"green":
					scores[2] += 1
				"pink":
					scores[3] += 1
				"indigo":
					scores[4] += 1
				"yellow":
					scores[5] += 1
				_:
					pass
		

func _displayScore(pColor):
	match pColor:
		"Blue":
			%Blue_score.text = str(scores[0])
		"Orange":
			%Orange_score.text = str(scores[1])
		"Green":
			%Green_score.text = str(scores[2])
		"Pink":
			%Pink_score.text = str(scores[3])
		"Indigo":
			%Indigo_score.text = str(scores[4])
		"Yellow":
			%Yellow_score.text = str(scores[5])
		_:
			pass

func set_inkling_visibility():
	#Set all visible
	for inkling in get_tree().get_nodes_in_group("scoreInkling"):
		inkling.visible = false
	for text in get_tree().get_nodes_in_group("scoreText"):
		text.visible = false
		
	if Splathello.numPlayers == 4: #There are so many better ways to do this, but oh well
		update_visible("blue", true)
		update_visible("orange", true)
		update_visible("green", true)
		update_visible("pink", true)
		
	else: #if 2
		print(Splathello.playerColors)
		match Splathello.playerColors:
			1:
				update_visible("green")
				update_visible("pink")
			2:
				update_visible("indigo")
				update_visible("yellow")
			_:
				update_visible("blue")
				update_visible("orange")

func update_visible(color, tf = true):
	match color:
		"blue":
			%InklingBlue.visible = tf
			%BlueScore.visible = tf
		"orange":
			%InklingOrange.visible = tf
			%OrangeScore.visible = tf
		"green":
			%InklingGreen.visible = tf
			%GreenScore.visible = tf
		"pink":
			%InklingPink.visible = tf
			%PinkScore.visible = tf
		"indigo":
			%OctolingIndigo.visible = tf
			%IndigoScore.visible = tf
		"yellow":
			%OctolingYellow.visible = tf
			%YellowScore.visible = tf
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _delete_self():
	queue_free()
