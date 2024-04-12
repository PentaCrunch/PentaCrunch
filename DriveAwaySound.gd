extends AudioStreamPlayer2D

var fade_duration = 5.0 #aika, jonka kuluessa ääni vaimenee loppua kohti
var fade_timer = 0.0
var initial_volume_db = -20.0 # alkuperäinen äänenvoimakkuus dB:ssä

func _ready():
	set_volume_db(initial_volume_db)

func _process(delta):
	if is_playing():
		fade_timer += delta
		if fade_timer >= fade_duration:
			fade_timer = fade_duration #Varmistetaan, ettei aika ylity fade_durationin
		#Pienentää äänenvoimakkuutta eksponentiaalisesti ajan myötä
		volume_db = initial_volume_db + (1.0 - (fade_timer / fade_duration)) * (-initial_volume_db)
