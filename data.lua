local armor = table.deepcopy(data.raw["armor"]["light-armor"])
armor.name = "FullFeaturedStart-tshort-armor"
armor.icons = { {
                    icon = armor.icon,
                    icon_size = armor.icon_size,
                    icon_mipmaps = armor.icon_mipmaps,
                    tint = { r = 1, g = 1, b = 1, a = 1 },
                } }
armor.resistances = {}
armor.order = "a[FullFeaturedStart-tshort-armor]"
armor.equipment_grid = "small-equipment-grid"

data:extend {
    armor
}
