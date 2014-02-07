--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(strmatch("$Revision$", "%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", MINOR_VERSION)
if not lib then return end

local panelBackdrop = {
	bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tile = true, tileSize = 16,
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

function lib:New(parent, width, height)
	assert(type(parent) == "table" and type(rawget(parent, 0)) == "userdata", "PhanxConfig-Panel: Parent is not a valid frame!")

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetBackdrop(panelBackdrop)
	frame:SetBackdropColor(0.06, 0.06, 0.06, 0.4)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	frame:SetSize(width or 1, height or 1)

	return frame
end

function lib.CreatePanel(...) return lib:New(...) end