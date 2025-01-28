extends Node2D

var p1Score
var p2Score
var p3Score
var p4Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%P1_score.text = "?"
	%P2_score.text = "?"
	%P3_score.text = "?"
	%P4_score.text = "?"
	p1Score = 0
	p2Score = 0
	p3Score = 0
	p4Score = 0
	tally_scores()
	
func tally_scores():
	for c in Splathello.squareColors:
		for r in c:
			match r:		#TEMP This will work differently for 2P
				"blue":
					p1Score += 1
				"orange":
					p2Score += 1
				"green":
					p3Score += 1
				"pink":
					p4Score += 1
				_:
					pass
		

func _displayScore(pNum):
	match pNum:
		1:
			%P1_score.text = str(p1Score)
		2:
			%P2_score.text = str(p2Score)
		3:
			%P3_score.text = str(p3Score)
		4:
			%P4_score.text = str(p4Score)
		_:
			pass
