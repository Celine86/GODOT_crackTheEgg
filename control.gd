extends Control

func _ready():
	RenderingServer.set_default_clear_color(Color.from_rgba8(0,0,0))

var hatchCount = 0
#eggSprite est assignée quand le node est prêt, la variable référence le node AnimatedEgg situé dans le parent.
@onready var eggSprite = $"../AnimatedEgg"

func _process(_delta: float) -> void:
	$eggHatch.text = "Clics: " + str(hatchCount)

func _on_click_button_pressed() -> void:
	if hatchCount >= 200:
		$clickButton.disabled = true
		return
	hatchCount += 10
	#Si hatchCount est divisible par 10 sans reste alors on incrémente eggSprite.frame d'1i
	if hatchCount % 10 == 0:
		eggSprite.frame += 1
		
