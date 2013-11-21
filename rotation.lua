--Discipline Priest by Shadowstepster

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(256, "Discipline[Shadow]", {

	--Inner Fire
	{ "588", "!player.buff(588)" },
	--Mana Regen
	{ "34433", {
		"player.mana < 70",
		"modifier.cooldowns"
	}},
	{ "123040", {
		"player.mana < 70",
		"modifier.cooldowns"
	}},
	{ "28730", {
		"player.mana < 90",
		"modifier.cooldowns"
        }},
        { "64901", "modifier.alt"},
	--Cascade and Halo
        { "121135", "@coreHealing.needsHealing(80, 6)", "lowest" },
        { "120517", "@coreHealing.needsHealing(60, 10)", "lowest" },
	--PW:S tank
	{ "17", "!tank.debuff(6788)", "tank" },
	--PW:S
	{ "17", {
		"lowest.health < 75",
		"!lowest.debuff(6788)"
	}, "lowest" },
	--Power Word: Solace
	{ "129250", "lowest.health < 100", "target" },
	--Penance Atonement
	{ "47540", "lowest.health < 90", "target" },
	--Penance
	{ "47540", "lowest.health < 75", "lowest" },
	--Flash Heal
	{ "2061", {
		"lowest.debuff(6788)",
		"lowest.health < 40",
		"!lowest.buff(17)"
	}, "lowest" },
	--Greater Heal
	{ "2060", { 
		    "lowest.health < 50",
	            "lowest.debuff(6788)",
	            "!lowest.buff(17)"
	}, "lowest" },
	--PW:S Myself
	{ "17", "!player.debuff(6788)", "player" },
	--Archangel
	{ "81700", "player.buff(81661).stacks = 5" },
	--Prayer of Mending
	{ "33076", "!tank.buff(41635)", "tank" },
	--Renew if weakened soul and no shield
	{ "139", {
		"lowest.health < 80",
		"lowest.debuff(6788)",
		"!lowest.buff(139)",
		"!lowest.buff(17)"
	}, "lowest" },
	--Holy Fire
	{ "14914", "lowest.health < 95", "target"},
	--Smite
	{ "585", "lowest.health < 100", "target" },
	{ "2050", "lowest.health < 95", "lowest" },
})