----------------------------------------------------------------------------------
local dialogs = {}
----------------------------------------------------------------------------------

dialogs["play"] = function()
	local text
	
	text = "Play!"
	
	return text
end

dialogs["options"] = function()
	local text
	
	text = "Options"
	
	return text
end

dialogs["music"] = function()
	local text
	
	text = "Musica:"
	
	return text
end

dialogs["sound"] = function()
	local text
	
	text = "Sonido:"
	
	return text
end


dialogs["storyP1"] = function()
	local text
	
	text = "Aún recuerdo aquella fria y lluviosa noche, mamá me preparó un poco de té caliente, luego de haber tomado hasta la última gota, me dirigía a mi habitación..."
	
	return text
end



dialogs["storyP2"] = function()
	local text
	
	text = "De repente, un aterrador susurro proveniente del sótano decía mi nombre, me sentí asustado, aún así quería saber de que se trataba esta escalofriante sensación..."
	
	return text
end



dialogs["storyP3"] = function()
	local text
	
	text = "Bajé, y frente a mi, la caja misteriosa que papá siempre me prohibió abrir. ¡NO! No quería hacerlo, pero esa virtud que los humanos poseemos llamada curiosidad, esa noche se convirtió en mi mayor maldición."
	
	return text
end


dialogs["storyP4"] = function()
	local text
	
	text = "Abrí la caja y dentro de ella se encontraba una historieta, la cual cambió mi destino."
	
	return text
end



return dialogs