
//sets you on fire, does burn damage, explodes into flame when burnt, weak to water
/datum/blobstrain/reagent/blazing_oil
	name = "Blazing Oil"
	description = "will do medium burn damage and set targets on fire."
	effectdesc = "is immune to, and will gain blob points from burn damage, but takes extra brute damage. Will also release bursts of flame when burnt, but takes damage from water."
	analyserdescdamage = "Does medium burn damage and sets targets on fire."
	analyserdesceffect = "Releases fire when burnt and will gain power when exposed to heat, but takes damage from water and other extinguishing liquids as well as taking extra brute damage."
	color = "#B68D00"
	complementary_color = "#BE5532"
	blobbernaut_message = "splashes"
	message = "The blob splashes you with burning oil"
	message_living = ", and you feel your skin char and melt"
	reagent = /datum/reagent/blob/blazing_oil

/datum/blobstrain/reagent/blazing_oil/extinguish_reaction(obj/structure/blob/B)
	B.take_damage(2.5, BURN, ENERGY)

/datum/blobstrain/reagent/blazing_oil/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_type == BRUTE) 
		return damage * 1.5
	if(damage_type == BURN && damage_flag != ENERGY)
		var/mob/camera/blob/O = overmind
		O.add_points(damage / 10)//burn damage causes the blob to gain a very small amount of points: the 20 damage of a laser will generate 2 BP.
		damage = 0 //completely and entirely immune to burn damage!
		for(var/turf/open/T in range(1, B))
			var/obj/structure/blob/C = locate() in T
			if(!(C && C.overmind && C.overmind.blobstrain.type == B.overmind.blobstrain.type) && prob(80))
				new /obj/effect/hotspot(T)
	if(damage_flag == FIRE)
		return 0
	return ..()

/datum/reagent/blob/blazing_oil
	name = "Blazing Oil"
	taste_description = "burning oil"
	color = "#B68D00"

/datum/reagent/blob/blazing_oil/reaction_mob(mob/living/M, methods = TOUCH, reac_volume, show_message, permeability, mob/camera/blob/O)
	reac_volume = ..()
	M.adjust_fire_stacks(round(reac_volume/10))
	M.ignite_mob()
	if(M)
		M.apply_damage(0.8*reac_volume, BURN, wound_bonus=CANT_WOUND)
	if(iscarbon(M))
		M.emote("scream")
