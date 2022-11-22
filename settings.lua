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
        type = "int-setting",
        name = "FullFeaturedStart-fuel",
        setting_type = "runtime-global",
        default_value = 10,
        minimum_value = 0,
        maximum_value = 100,
        order = "02"
    },
    {
        type = "double-setting",
        name = "FullFeaturedStart-robotSpeed",
        setting_type = "startup",
        default_value = 0.06,
        minimum_value = 0.01,
        maximum_value = 1,
        order = "03"
    },
    {
        type = "int-setting",
        name = "FullFeaturedStart-minifyEquipment",
        setting_type = "startup",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 4,
        order = "04"
    },
    {
        type = "int-setting",
        name = "FullFeaturedStart-equipmentSize",
        setting_type = "startup",
        default_value = 5,
        minimum_value = 4,
        maximum_value = 16,
        order = "05"
    },
})
