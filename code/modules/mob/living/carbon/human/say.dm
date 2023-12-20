/mob/living/carbon/human/say_mod(input, message_mode)
	var/rare_verb = LAZYLEN(dna.species.rare_say_mod) ? pick(dna.species.rare_say_mod) : null
	if (rare_verb && prob(dna.species.rare_say_mod[rare_verb]))
		verb_say = rare_verb
	else
		verb_say = dna.species.say_mod

	. = ..()

/mob/living/carbon/human/GetTTSVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/mask = wear_mask
		if(mask.vchange && mask.voice_action?.current_voice)
			return mask.voice_action.current_voice
	return ..()

/mob/living/carbon/human/GetTTSPitch()
	var/pitch_multiplier = 0.5
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/mask = wear_mask
		if(mask.vchange && mask.voice_action?.current_pitch)
			return mask.voice_action.current_pitch
	else
		var/pitch = current_pitch + (GetGasDensity() - 1.0) * pitch_multiplier
	return ..()

/mob/living/carbon/human/GetGasDensity()
	var/datum/gas_mixture/environment = src.return_air()
	var/total_moles = environment.total_moles()
	var/total_pressure = environment.return_pressure()
	var/total_temperature = environment.return_temperature()

	var/o2_concentration = environment.get_moles(GAS_O2)/total_moles * 1.33
	var/n2_concentration = environment.get_moles(GAS_N2)/total_moles * 1.25
	var/co2_concentration = environment.get_moles(GAS_CO2)/total_moles * 1.98
	var/plasma_concentration = environment.get_moles(GAS_PLASMA)/total_moles * 2.22
	var/water_vapor_concentration = environment.get_moles(GAS_H2O)/total_moles * 0.8
	var/hypernob_concentration = environment.get_moles(GAS_HYPERNOB)/total_moles * 3.8
	var/nitrous_oxide_concentration = environment.get_moles(GAS_NITROUS)/total_moles * 1.87
	var/tritium_concentration = environment.get_moles(GAS_TRITIUM)/total_moles * 0.083
	var/bz_concentration = environment.get_moles(GAS_TRITIUM)/total_moles * 1.5
	var/pluoxium_concentration = environment.get_moles(GAS_PLUOXIUM)/total_moles * 1.9
	var/miasma_concentration = environment.get_moles(GAS_MIASMA)/total_moles * 1.4
	var/freon_concentration = environment.get_moles(GAS_FREON)/total_moles * 4
	var/h2_concentration = environment.get_moles(GAS_H2)/total_moles * 0.083
	var/healium_concentration = environment.get_moles(GAS_HEALIUM)/total_moles * 1.2
	var/pluonium_concentration = environment.get_moles(GAS_HEALIUM)/total_moles * 10
	var/halon_concentration = environment.get_moles(GAS_HALON)/total_moles * 8
	var/antinob_concentration = environment.get_moles(GAS_ANTINOB)/total_moles * 0.3
	var/zauker_concentration = environment.get_moles(GAS_ZAUKER)/total_moles * 5
	var/hexane_concentration = environment.get_moles(GAS_HEXANE)/total_moles * 7
	var/dilithium_concentration = environment.get_moles(GAS_DILITHIUM)/total_moles * 3
	return CalculateTotalDensity(
        total_pressure,
        total_temperature,
        o2_concentration,
        n2_concentration,
        co2_concentration,
        plasma_concentration,
        water_vapor_concentration,
        hypernob_concentration,
        nitrous_oxide_concentration,
        tritium_concentration,
        bz_concentration,
        pluoxium_concentration,
        miasma_concentration,
        freon_concentration,
        h2_concentration,
        healium_concentration,
        pluonium_concentration,
        halon_concentration,
        antinob_concentration,
        zauker_concentration,
        hexane_concentration,
        dilithium_concentration)

/mob/living/carbon/human/CalculateTotalDensity(total_pressure, total_temperature, o2_concentration, n2_concentration, co2_concentration, plasma_concentration, water_vapor_concentration, hypernob_concentration, nitrous_oxide_concentration, tritium_concentration, bz_concentration, pluoxium_concentration, miasma_concentration, freon_concentration, h2_concentration, healium_concentration, pluonium_concentration, halon_concentration, antinob_concentration, zauker_concentration, hexane_concentration, dilithium_concentration):
    // Ideal gas constant (J/(mol·K))
    R = 8.314

    // Molar masses of gases (in g/mol)
    var/Mo2 = 32
    var/Mn2 = 28
    var/Mco2 = 44
    var/Mplasma = 60
    var/Mh2o = 18
    var/Mhypernob = 1
    var/Mnitrous_oxide = 44
    var/Mtritium = 6
    var/Mbz = 105
    var/Mpluoxium = 55
    var/Mmiasma = 32
    var/Mfreon = 235
    var/Mh2 = 1
    var/Mhealium = 40
    var/Mpluonium = 208
    var/Mhalon = 100
    var/Mantinob = 20
    var/Mzauker = 80
    var/Mhexane = 20
    var/Mdilithium = 28

    // Convert concentrations to mass fractions
    var/mass_fraction_O2 = o2_concentration * Mo2
    var/mass_fraction_N2 = n2_concentration * Mn2
    var/mass_fraction_CO2 = co2_concentration * Mco2
    var/mass_fraction_PLASMA = plasma_concentration * Mplasma
    var/mass_fraction_WATER_VAPOR = water_vapor_concentration * Mh2o
    var/mass_fraction_HYPERNOB = hypernob_concentration * Mhypernob
    var/mass_fraction_NITROUS = nitrous_oxide_concentration * Mnitrous_oxide
    var/mass_fraction_TRITIUM = tritium_concentration * Mtritium
    var/mass_fraction_BZ = bz_concentration * Mbz
    var/mass_fraction_PLUOXIUM = pluoxium_concentration * Mpluoxium
    var/mass_fraction_MIASMA = miasma_concentration * Mmiasma
    var/mass_fraction_FREON = freon_concentration * Mfreon
    var/mass_fraction_H2 = h2_concentration * Mh2
    var/mass_fraction_HEALIUM = healium_concentration * Mhealium
    var/mass_fraction_PLUTONIUM = pluonium_concentration * Mpluonium
    var/mass_fraction_HALON = halon_concentration * Mhalon
    var/mass_fraction_ANTINOB = antinob_concentration * Mantinob
    var/mass_fraction_ZAUKER = zauker_concentration * Mzauker
    var/mass_fraction_HEXANE = hexane_concentration * Mhexane
    var/mass_fraction_DILITHIUM = dilithium_concentration * Mdilithium

    var/total_mass = mass_fraction_O2 + mass_fraction_N2 + mass_fraction_CO2 + mass_fraction_PLASMA + mass_fraction_WATER_VAPOR + mass_fraction_HYPERNOB + mass_fraction_NITROUS + mass_fraction_TRITIUM + mass_fraction_BZ + mass_fraction_PLUOXIUM + mass_fraction_MIASMA + mass_fraction_FREON + mass_fraction_H2 + mass_fraction_HEALIUM + mass_fraction_PLUTONIUM + mass_fraction_HALON + mass_fraction_ANTINOB + mass_fraction_ZAUKER + mass_fraction_HEXANE + mass_fraction_DILITHIUM

    var/total_density = (total_mass * total_pressure) / (R * total_temperature * total_moles * 1e-3)
    return total_density


/mob/living/carbon/human/GetVoice()
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/V = wear_mask
		if(V.vchange && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	if(istype(wear_mask, /obj/item/clothing/mask/gas/sechailer/swat/encrypted))
		return splittext(src.tag, "_")[2] // Voice name will show up as their tag numbers to match ID
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.mimicing )
			return changeling.mimicing
	if(GetSpecialVoice())
		return GetSpecialVoice()
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(ears)
		var/obj/item/radio/headset/dongle = ears
		if(!istype(dongle))
			return FALSE
		if(dongle.translate_binary)
			return TRUE

/mob/living/carbon/human/radio(message, list/message_mods = list(), list/spans, language) //Poly has a copy of this, lazy bastard
	. = ..()
	if(. != FALSE)
		return .

	if(message_mods[MODE_HEADSET])
		if(ears)
			ears.talk_into(src, message, , spans, language, message_mods)
			return ITALICS | REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT)
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE
	else if(GLOB.radiochannels[message_mods[RADIO_EXTENSION]])
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE
	return 0

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (as [get_id_name("Unknown")])"

/mob/living/carbon/human/proc/forcesay(list/append) //this proc is at the bottom of the file because quote fuckery makes notepad++ cri
	if(stat == CONSCIOUS)
		if(client)
			var/temp = winget(client, "input", "text")
			var/say_starter = "Say \"" //"
			if(findtextEx(temp, say_starter, 1, length(say_starter) + 1) && length(temp) > length(say_starter))	//case sensitive means

				temp = trim_left(copytext(temp, length(say_starter + 1)))
				temp = replacetext(temp, ";", "", 1, 2)	//general radio
				while(trim_left(temp)[1] == ":")	//dept radio again (necessary)
					temp = copytext_char(trim_left(temp), 3)

				if(temp[1] == "*")	//emotes
					return

				var/trimmed = trim_left(temp)
				if(length(trimmed))
					if(append)
						trimmed += pick(append)

					say(trimmed)
				winset(client, "input", "text=[null]")
