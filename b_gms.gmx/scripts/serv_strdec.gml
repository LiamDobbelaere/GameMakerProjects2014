basestr = argument0

start = string_pos("<", basestr)
ends = string_pos(">", basestr)
return string_copy(basestr, start+1, ends-start-1)
