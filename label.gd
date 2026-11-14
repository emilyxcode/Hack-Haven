extends Control

@onready var label: Label = $"."


var lines: Array[String] = [
"Thou art Lancelot....",
"Lancelot...reborn...",
"as a lowly slime",
"Use arrow keys to move.",
"You must find...",
"Guinevere" ]

func _ready() -> void:
	label.modulate.a = 0.0 # Start invisible
	play_text_loop()

func play_text_loop() -> void:
	for line in lines:
		# 1. Set the new text while invisible
		label.text = line

		# 2. Fade In
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1, 2)
		await tween.finished

		# 3. Wait while visible
		await get_tree().create_timer(2).timeout

		# 4. Fade Out
		tween = create_tween()
		tween.tween_property(label, "modulate:a", 0.1, 2)
		await tween.finished
