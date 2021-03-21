extends Spatial



func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Main_World.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_HTP_pressed():
	$Main/Main.visible = false
	$Help.visible = true


func _on_Button_pressed():
	$Main/Main.visible = true
	$Help.visible = false
