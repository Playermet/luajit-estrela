local mod = {}

function mod.is_tag(node)
	return type(node) == 'table' and node.tag ~= nil
end

function mod.find_match(node, from, func, ...)
	for i,sub in next, node, from do
		if func(sub, ...) then
			return sub,i
		end
	end
end

function mod.findr_match(node, from, func, ...)
	local r,i = mod.find_match(node, from, func, ...)
	if r then
		return r,i,node
	else
		for _,sub in ipairs(node) do
			if mod.is_tag(sub) then
				r,i = mod.findr_match(sub, nil, func, ...)
				if r then
					return r,i,sub
				end
			end
		end
	end
end

do
	local f = function(node, tag)
		return mod.is_tag(node) and node.tag == tag
	end

	function mod.find_tag(node, tag, from)
		return mod.find_match(node, from, f, tag)
	end

	function mod.findr_tag(node, tag, from)
		return mod.findr_match(node, from, f, tag)
	end
end

do
	local f = function(node, attr, value)
		if mod.is_tag(node) then
			return node.attr and node.attr[attr] == value
		end
	end

	function mod.find_attr(node, attr, value, from)
		return mod.find_match(node, from, f, attr, value)
	end

	function mod.findr_attr(node, attr, value, from)
		return mod.findr_match(node, from, f, attr, value)
	end
end

function mod.next_tag(node,from)
	for i,sub in next, node, from do
		if mod.is_tag(sub) then
			return i,sub
		end
	end
end

function mod.tag_pairs(node)
	return mod.next_tag,node,nil
end

return mod
