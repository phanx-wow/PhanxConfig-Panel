--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.
	https://github.com/Phanx/PhanxConfig-Panel

	Copyright (c) 2009-2014 Phanx <addons@phanx.net>. All rights reserved.

	Permission is granted for anyone to use, read, or otherwise interpret
	this software for any purpose, without any restrictions.

	Permission is granted for anyone to embed or include this software in
	another work not derived from this software that makes use of the
	interface provided by this software for the purpose of creating a
	package of the work and its required libraries, and to distribute such
	packages as long as the software is not modified in any way, including
	by modifying or removing any files.

	Permission is granted for anyone to modify this software or sample from
	it, and to distribute such modified versions or derivative works as long
	as neither the names of this software nor its authors are used in the
	name or title of the work or in any other way that may cause it to be
	confused with or interfere with the simultaneous use of this software.

	This software may not be distributed standalone or in any other way, in
	whole or in part, modified or unmodified, without specific prior written
	permission from the authors of this software.

	The names of this software and/or its authors may not be used to
	promote or endorse works derived from this software without specific
	prior written permission from the authors of this software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
	OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
	ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
----------------------------------------------------------------------]]

local MINOR_VERSION = 172

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", MINOR_VERSION)
if not lib then return end

local panelBackdrop = {
	bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tile = true, tileSize = 16,
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

local function SetPoint(f, a, to, b, x, y)
	if f.label:GetText() and strfind(a, "TOP") then
		if x and not y then
			a, to, b, x, y = a, to, a, b, x
		elseif b and not x then
			a, to, b, x, y = a, f:GetParent(), a, to, b
		end
		y = y - f.label:GetHeight()
	end
	f.__SetPoint(f, a, to, b, x, y)
end

local function SetLabel(f, labelText)
	local prev = f.label:GetText()
	f.label:SetText(labelText)
	if (not not prev) ~= (not not labelText) then
		for i = 1, f:GetNumPoints() do
			f:SetPoint(f:GetPoint(i))
		end
	end
end

function lib:New(parent, labelText, width, height)
	assert(type(parent) == "table" and type(rawget(parent, 0)) == "userdata", "PhanxConfig-Panel: Parent is not a valid frame!")
	if type(label) == "number" then
		label, width, height = nil, label, width -- backwards compat
	end

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetBackdrop(panelBackdrop)
	frame:SetBackdropColor(0.06, 0.06, 0.06, 0.4)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 4, 0)
	label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, 0)
	label:SetJustifyH("LEFT")
	frame.label = label

	frame.__SetPoint = frame.SetPoint
	frame.SetPoint = SetPoint

	frame.SetLabel = SetLabel

	label:SetText(labelText)
	if width and height then
		frame:SetSize(width, height)
	end

	return frame
end

function lib.CreatePanel(...) return lib:New(...) end