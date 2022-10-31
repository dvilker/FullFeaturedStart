data:extend({
    {
        type = "int-setting",
        name = "FullFeaturedStart-robots",
        setting_type = "runtime-global",
        default_value = 50,
        minimum_value = 50,
        maximum_value = 500,
        order = "01"
    },
    {
        type = "double-setting",
        name = "FullFeaturedStart-robotSpeed",
        setting_type = "startup",
        default_value = 0.06,
        minimum_value = 0.01,
        maximum_value = 1,
        order = "02"
    },
    {
        type = "int-setting",
        name = "FullFeaturedStart-minifyEquipment",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 4,
        order = "02"
    },
})
