#Copyright (c) 2020 Martin Senges
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
#and associated documentation files (the "Software"), to deal in the Software without restriction, 
#including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
#and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
#subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all copies or substantial 
#portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
#TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
#IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
#WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
#OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

#Contact:
#	Itch.io: Martin Senges
#	Twitter: @MartinSenges
#	Youtube: Martin Senges
#	Email: business@martin-senges.eu

#Version: 1.0



#This source code can be used in projects made with Godot Engine (https://godotengine.org). 
#Godot Engine is available under the following licence: https://godotengine.org/license




tool
class_name PixelMesh
extends MultiMeshInstance

export(Texture) var texture = null setget setTexture
export(int)  var hframes = 1 setget setHFrames
export(int)  var vframes = 1 setget setVFrames
export(int)  var frame = 0 setget setFrame
export(Vector2) var gridFactor = Vector2(1.0,1.0) setget setGrid

export(Array, Array, Color) var animationColors = Array()


func setTexture(newValue: Texture) -> void:
	if(texture != newValue):
		texture = newValue
		if(texture):
			createMesh()
			calcAnimation()


func setHFrames(newValue: int) -> void:
	if(hframes != newValue):
		hframes = newValue
		if(texture):
			createMesh()
			calcAnimation()


func setVFrames(newValue: int) -> void:
	if(vframes != newValue):
		vframes = newValue
		if(texture):
			createMesh()
			calcAnimation()
			
			
func setFrame(newValue: int) -> void:
	frame = newValue
	if(texture):
		for i in range(multimesh.instance_count):
			var color: Color = animationColors[frame][i]
			multimesh.set_instance_color(i, color)
			
func setGrid(newValue: Vector2) ->	void:
	gridFactor = newValue
	
	var textureSize:Vector2 = texture.get_size()
	var frameWidth: int = textureSize[0] / hframes
	var frameHeight: int = textureSize[1] / vframes

	
	multimesh.instance_count = frameWidth * frameHeight
	for i in range(multimesh.instance_count):
		var x: int = i % frameWidth
		var y: int = i / frameWidth
		multimesh.set_instance_transform(i, Transform().translated(Vector3(x*gridFactor.x,1,y*gridFactor.y)))	

func calcAnimation() -> void:
	var textureSize:Vector2 = texture.get_size()
	var frameHeight: int = textureSize[1] / vframes
	var frameWidth: int = textureSize[0] / hframes
	animationColors.clear()
	
	var image: Image = texture.get_data()
	image.lock()
	var totalFrames: int = hframes*vframes
	for frameIndex in range(totalFrames):
		var frameColors: Array = Array()
		var frameStartX: int = (frameIndex % hframes) * frameWidth
		var frameStartY: int = (frameIndex / hframes) * frameHeight
		for ry in range(frameHeight):
			for rx in range(frameWidth):
				var px: int = rx + frameStartX
				var py: int = ry + frameStartY
				var pixel:Color = image.get_pixel(px,py)
				frameColors.append(pixel)
		animationColors.append(frameColors)
	image.unlock()
	
	setFrame(frame)
	

func createMesh() -> void:
	animationColors.clear()
	
	multimesh = MultiMesh.new()
	multimesh.mesh = CubeMesh.new()
	multimesh.mesh.size = Vector3(1.0,1.0,1.0)
	var material: SpatialMaterial = SpatialMaterial.new()
	material.vertex_color_use_as_albedo = true
	material.flags_transparent = true
	material.params_cull_mode = SpatialMaterial.CULL_DISABLED
	material.params_depth_draw_mode = SpatialMaterial.DEPTH_DRAW_ALPHA_OPAQUE_PREPASS
	multimesh.mesh.surface_set_material(0, material)
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.color_format = MultiMesh.COLOR_FLOAT
	
	setGrid(gridFactor)

		
		


