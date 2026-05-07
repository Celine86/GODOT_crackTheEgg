extends Control

var playback:AudioStreamPlaybackPolyphonic
var snd_crack = preload("res://assets/sounds/eggCrack.wav")
var snd_chick = preload("res://assets/sounds/chick.wav")

func _ready():
	RenderingServer.set_default_clear_color(Color.from_rgba8(32,32,32))

func _enter_tree() -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	playback = player.get_stream_playback()
	await get_tree().process_frame
	playback.play_stream(snd_crack, 0, 0, 0.0)

var hatchCount = 0
@onready var eggSprite = $"../AnimatedEgg"

func _process(_delta: float) -> void:
	$eggHatch.text = "Clics: " + str(hatchCount)

func _on_click_button_pressed() -> void:
	if hatchCount >= 200:
		playback.play_stream(snd_chick, 0, 0, 1.0)
		$clickButton.disabled = true
		return
	playback.play_stream(snd_crack, 0, 0, 1.0)
	hatchCount += 5
	if hatchCount % 10 == 0:
		eggSprite.frame += 1
		
