local writeFunc = false

--[[
	-- writeFunc = true
local poly = lib.zones.poly({
	name = poly,
	points = {
		vec(447.9, -998.8, 25.8),
		vec(450.3, -998.2, 25.8),
		vec(449.9, -995.5, 25.8),
		vec(447.2, -995.6, 25.8),
		vec(446.3, -997.9, 25.8),
	},
	debug = true,
})
	-- writeFunc = false
{
	name = poly,
	points = {
		vec(447.9, -998.8, 25.8),
		vec(450.3, -998.2, 25.8),
		vec(449.9, -995.5, 25.8),
		vec(447.2, -995.6, 25.8),
		vec(446.3, -997.9, 25.8),
	},
},
]]

local function roundToPlace(number, place)
	place = place or 1
	number = tonumber(number)
	number *= (10 ^ place)
	number = number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
	return number /= (10 ^ place)
end

local function roundAllToPlace(tab, place)
	for i = 1, #tab do
		tab[i] = roundToPlace(tab[i], place)
	end
	return tab
end

local function parsePoly(zone)
	local centrePlane = roundToPlace((zone.minZ + zone.maxZ) / 2)
	local points = {}
	for i = 1, #zone.points do
		points[#points + 1] = ('\t\tvec(%s, %s, %s),\n'):format(roundToPlace(zone.points[i].x), roundToPlace(zone.points[i].y), centrePlane)
	end
	local str = writeFunc and 'local poly = lib.zones.poly({\n\tname = %s,\n\tpoints = {\n%s\t},\n\tdebug = true,\n})\n' or '{\n\tname = %s,\n\tpoints = {\n%s\t},\n},\n'
	return str:format(zone.name, table.concat(points))
end

local function parseCircle(zone)
	local str = writeFunc and 'local sphere = lib.zones.sphere({\n\tname = %s,\n\tcoords = vec(%s, %s, %s),\n\tradius = %s,\n\tdebug = true,\n})\n' or '{\n\tname = %s,\n\tcoords = vec(%s, %s, %s),\n\tradius = %s,\n},\n'
	return str:format(zone.name, table.unpack(roundAllToPlace({zone.center.x, zone.center.y, zone.center.z, zone.radius})))
end

local function parseBox(zone)
	local str = writeFunc and 'local box = lib.zones.box({\n\tname = %s,\n\tcoords = vec(%s, %s, %s),\n\tsize = vec(%s, %s, %s),\n\trotation = %s,\n\tdebug = true,\n})\n' or '{\n\tname = %s,\n\tcoords = vec(%s, %s, %s),\n\tsize = vec(%s, %s, %s),\n\trotation = %s,\n},\n'
	return str:format(zone.name, table.unpack(roundAllToPlace({zone.center.x, zone.center.y, zone.center.z, zone.length, zone.width, zone.minZ and zone.maxZ and zone.minZ - zone.maxZ or 1, zone.heading})))
end

local path = GetResourcePath(GetCurrentResourceName()) .. '/creation/polyzone_created_zones.txt'
path = path:gsub('//', '/')
RegisterServerEvent('polyzone:printPoly', function(zone)
	file = io.open(path, 'a')
	io.output(file)
	local output = parsePoly(zone)
	io.write(output)
	io.close(file)
end)

RegisterServerEvent('polyzone:printCircle', function(zone)
	file = io.open(path, 'a')
	io.output(file)
	local output = parseCircle(zone)
	io.write(output)
	io.close(file)
end)

RegisterServerEvent('polyzone:printBox', function(zone)
	file = io.open(path, 'a')
	io.output(file)
	local output = parseBox(zone)
	io.write(output)
	io.close(file)
end)
