local factor = settings.startup["FullFeaturedStart-minifyEquipment"].value
if factor > 1 then
    for cat, type in pairs(data.raw) do
        for name, proto in pairs(type) do
            if proto.shape and proto.shape.type == "full" then
                proto.shape.width = math.ceil(proto.shape.width / factor)
                proto.shape.height = math.ceil(proto.shape.height / factor)
            end
        end
    end
end

local robotSpeed = settings.startup["FullFeaturedStart-robotSpeed"].value
if robotSpeed then
    data.raw["construction-robot"]["construction-robot"].speed = robotSpeed
end
