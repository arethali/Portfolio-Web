extends CanvasLayer
var loading_scene_file = "res://Scripts/loading.tscn"
var main_scene = "res://Scripts/Main.tscn"
var prog_bar : ProgressBar
var percent_label : Label
var loaded = false
var _progress: Array = []
var load_status = 0
var fade_anim : AnimationPlayer
var scene_instance
var instantiated = false
var in_loading = false



func _ready():
	set_process(false)
	
	
func load_scene():
	
	#print("in_loading = true")
	#SceneTransitions.fade_to_load()
	#await get_tree().process_frame
	if instantiated == false:
		var loading_scene = load(loading_scene_file)
		scene_instance = loading_scene.instantiate()
		get_tree().root.call_deferred("add_child", scene_instance)
		instantiated = true
	#print(scene_instance)
	#await get_tree().create_timer(.5).timeout
	ResourceLoader.load_threaded_request(main_scene, "", true)
	#driving
	prog_bar = scene_instance.get_node("Control/ProgressBar")
	#percent_label = scene_instance.get_node("Label")
	fade_anim = scene_instance.get_node("AnimationPlayer")
	#remove_child($Button)
	#
	set_process(true)
	return

#


func _process(delta):
	if loaded == true:
		load_main()
		return
		

	load_status = ResourceLoader.load_threaded_get_status(main_scene, _progress)
	print(load_status)
	match load_status:
		0,2:
			print_debug("ERROR: Loading Failed")
			#percent_label.text = "failed"
			get_tree().quit()
			#return
		1:
			var progress = _progress[0]
			#await get_tree().process_frame
			#percent_label.text = str(int(progress * 100)) + "%"
			prog_bar.value = progress * 100
			#print(str(int(progress * 100)) + "%")
			#print(prog_bar.value)
		3:
			loaded = true
			#return
	
	#print(loaded)
	#set_process(false)
		
			


func load_main():
	set_process(false)
	#print("loaded = true")
	#await get_tree().process_frame
	fade_anim.play("Fade_out")
	await fade_anim.animation_finished
#fade_anim.stop()
	#print("animfinished")
	await get_tree().process_frame
	scene_instance.queue_free()
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(main_scene))
	#
	#loaded = false
	#print(GlobalVars.current_level)
	print("finished")
	print("on", Audio.audio_on)
	return
