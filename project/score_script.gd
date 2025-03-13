extends VBoxContainer

var scores = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scores = [0,0,0,0,0,0,0,0]

func _increase_score(teamNum):
	Main.correctTeam = teamNum
	var inc = Main.pointsToAdd
	if scores[teamNum - 1] + inc < 0:
		scores[teamNum - 1] = 0
	else:
		scores [teamNum - 1] += inc
	var btn = "Team%d" % teamNum
	get_node(btn).get_child(0).get_node("Score").text = str(scores[teamNum - 1])
	
	Main.pointsToAdd = 1
		
	%TheyShoot.visible = true

func _set_points_to_add(pts):
	Main.pointsToAdd = pts
	
func _miss(): #Give points to losing team(s)
	#get current lowest score
	var lowestScore = scores.min()
	for i in range(0,scores.size()):
		#if team has that score, _increase_score(teamNum)
		if scores[i] == lowestScore:
			_increase_score(i+1) #TeamNum starts from 1
	%TheyShoot.visible = false
			
func _score():
	_increase_score(Main.correctTeam)
	%TheyShoot.visible = false
	
func _close_score():
	%TheyShoot.visible = false

#Subtract 2 from leading team
func _minusTwo() -> void:
	var highestScore = scores.max()
	for i in range(0,scores.size()):
		#if team has that score, _increase_score(teamNum)
		Main.pointsToAdd = -2
		if scores[i] == highestScore:
			_increase_score(i+1) #TeamNum starts from 1

	%TheyShoot.visible = false
