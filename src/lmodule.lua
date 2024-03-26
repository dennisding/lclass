

_sys = {}
_sys.paths = {'./'}
_sys.suffix = '.lum'
_sys.modules = {}
_sys.file_reader = function (name)
	local file = io.open(name)
	if file == nil then
		return nil
	end
	local content = file:read('*all')
	file:close()
	return content
end

function _import(name)
	if _sys.modules[name] ~= nil then
		return _sys.modules
	end

	local file_name = name .. _sys.suffix
	local file_path = file_name
	local content = nil
	for _, path in ipairs(_sys.paths) do
		file_path = path .. file_name
		content = _sys.file_reader(file_path)
		if content ~= nil then
			break
		end
	end

	-- load the module
	local module = {}
	setmetatable(module, {__index = _ENV})
	_sys.modules[name] = module
	local loaded = load(content, file_path, 'bt', module)
	loaded()

	return module
end