extends Control

func _ready():
	RenderingServer.set_default_clear_color(Color.from_rgba8(32,32,32))

var playback:AudioStreamPlaybackPolyphonic

func _enter_tree() -> void:
	# Create an audio player
	var player = AudioStreamPlayer.new()
	add_child(player)
	# Create a polyphonic stream so we can play sounds directly from it
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	# Get the polyphonic playback stream to play sounds
	playback = player.get_stream_playback()
#Source : https://forum.godotengine.org/t/best-proper-way-to-do-ui-sounds-hover-click/39081

var hatchCount = 0
#eggSprite est assignée quand le node est prêt, la variable référence le node AnimatedEgg situé dans le parent.
@onready var eggSprite = $"../AnimatedEgg"

func _process(_delta: float) -> void:
	$eggHatch.text = "Clics: " + str(hatchCount)

func _on_click_button_pressed() -> void:
	if hatchCount >= 200:
		playback.play_stream(preload('res://assets/sounds/chick.mp3'), 0, 0, randf_range(1, 1))
		$clickButton.disabled = true
		return
	hatchCount += 5
	#Si hatchCount est divisible par 10 sans reste alors on incrémente eggSprite.frame d'1i
	if hatchCount % 10 == 0:
		eggSprite.frame += 1
		playback.play_stream(preload('res://assets/sounds/eggCrack.mp3'), 0, 0, randf_range(2.5, 2.5))
		
