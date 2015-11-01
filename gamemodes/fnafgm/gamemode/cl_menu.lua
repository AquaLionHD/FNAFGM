function fnafgmMenu()
	
	if !IsValid(fnafgmMenuF) and !engine.IsPlayingDemo() then
		
		
		fnafgmMenuF = vgui.Create( "DFrame" )
		fnafgmMenuF:SetPos( ScrW()/2-320, ScrH()/2-240 )
		fnafgmMenuF:SetSize( 640, 480 )
		fnafgmMenuF:SetTitle(tostring(GAMEMODE.Name or "?").." Gamemode V"..tostring(GAMEMODE.Version or "?")..modetext..seasonaltext)
		fnafgmMenuF:SetVisible(true)
		fnafgmMenuF:SetDraggable(true)
		fnafgmMenuF:ShowCloseButton(true)
		fnafgmMenuF:SetScreenLock(true)
		fnafgmMenuF.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 128 ) )
		end
		fnafgmMenuF.Think = function(self)
			
			if xpad_anim:Active() then xpad_anim:Run() end
			
			local mousex = math.Clamp( gui.MouseX(), 1, ScrW()-1 )
			local mousey = math.Clamp( gui.MouseY(), 1, ScrH()-1 )
		
			if ( self.Dragging ) then
		
				local x = mousex - self.Dragging[1]
				local y = mousey - self.Dragging[2]
		
				-- Lock to screen bounds if screenlock is enabled
				if ( self:GetScreenLock() ) then
		
					x = math.Clamp( x, 0, ScrW() - self:GetWide() )
					y = math.Clamp( y, 0, ScrH() - self:GetTall() )
		
				end
		
				self:SetPos( x, y )
		
			end
				
			if ( self.Hovered && mousey < ( self.y + 24 ) ) then
				self:SetCursor( "sizeall" )
				return
			end
			
			self:SetCursor( "arrow" )

			if ( self.y < 0 ) then
				self:SetPos( self.x, 0 )
			end
			
		end
		fnafgmMenuF:MakePopup()
		fnafgmMenuF:SetKeyboardInputEnabled(false)
		
		
		fnafgmMenuF.links = vgui.Create( "DPanel" )
		fnafgmMenuF.links:SetParent(fnafgmMenuF)
		fnafgmMenuF.links:SetPos( 10, 30 )
		fnafgmMenuF.links:SetSize( 305, 215 )
		
		local linkslbl = vgui.Create( "DLabel" )
		linkslbl:SetParent(fnafgmMenuF.links)
		linkslbl:SetText( tostring(GAMEMODE.TranslatedStrings.links or GAMEMODE.Strings.en.links) )
		linkslbl:SetPos( 10, 5 )
		linkslbl:SetDark( 1 )
		linkslbl:SizeToContents()
		
		local websitebtn = vgui.Create( "DButton" )
		websitebtn:SetParent(fnafgmMenuF.links)
		websitebtn:SetText( GAMEMODE.ShortName.." Workshop page" )
		websitebtn:SetPos( 20, 60 )
		websitebtn:SetSize( 265, 80 )
		websitebtn.DoClick = function()
			local url = ""
			if GAMEMODE.Website:find( "://", 1, true ) then
				url = GAMEMODE.Website
			else
				url = "http://" .. GAMEMODE.Website
			end
			gui.OpenURL( url )
			fnafgmMenuF:Close()
		end
		
		if !fontloaded then
			
			local fontlbl = vgui.Create( "DLabel" )
			fontlbl:SetParent(fnafgmMenuF.links)
			fontlbl:SetText( tostring(GAMEMODE.TranslatedStrings.fonthint or GAMEMODE.Strings.en.fonthint) )
			fontlbl:SetPos( 15, 30 )
			fontlbl:SetDark( 1 )
			fontlbl:SizeToContents()
			
		end
		
		if engine.ActiveGamemode()=="fnafgm" then
			
			questionbtn = vgui.Create( "DButton" )
			questionbtn:SetParent(fnafgmMenuF.links)
			questionbtn:SetText( tostring(GAMEMODE.TranslatedStrings.faqbtn or GAMEMODE.Strings.en.faqbtn) )
			questionbtn:SetPos( 10, 185 )
			questionbtn:SetSize( 140, 20 )
			questionbtn.DoClick = function()
				gui.OpenURL( "http://steamcommunity.com/workshop/filedetails/discussion/408243366/537405286640719064/" )
				fnafgmMenuF:Close()
			end
			
			bugreportbtn = vgui.Create( "DButton" )
			bugreportbtn:SetParent(fnafgmMenuF.links)
			bugreportbtn:SetText( "Bug report" )
			bugreportbtn:SetPos( 155, 185 )
			bugreportbtn:SetSize( 140, 20 )
			bugreportbtn.DoClick = function()
				gui.OpenURL( "http://steamcommunity.com/workshop/filedetails/discussion/408243366/537405286650706286/" )
				fnafgmMenuF:Close()
			end
			
		end
		
		
		
		fnafgmMenuF.config = vgui.Create( "DPanel" )
		fnafgmMenuF.config:SetParent(fnafgmMenuF)
		fnafgmMenuF.config:SetPos( 325, 30 )
		fnafgmMenuF.config:SetSize( 305, 215 )
		
		local configlbl = vgui.Create( "DLabel" )
		configlbl:SetParent(fnafgmMenuF.config)
		configlbl:SetText( tostring(GAMEMODE.TranslatedStrings.config or GAMEMODE.Strings.en.config) )
		configlbl:SetPos( 10, 5 )
		configlbl:SetDark( 1 )
		configlbl:SizeToContents()
		
		local hideversion = vgui.Create( "DCheckBoxLabel" )
		hideversion:SetParent(fnafgmMenuF.config)
		hideversion:SetText(tostring(GAMEMODE.TranslatedStrings.hidever or GAMEMODE.Strings.en.hidever))
		hideversion:SetPos( 15, 30 )
		hideversion:SetDark( 1 )
		hideversion:SetConVar( "fnafgm_cl_hideversion" )
		hideversion:SetValue( GetConVar("fnafgm_cl_hideversion"):GetBool() )
		hideversion:SizeToContents()
		
		local warn = vgui.Create( "DCheckBoxLabel" )
		warn:SetParent(fnafgmMenuF.config)
		warn:SetText("Warn")
		warn:SetPos( 15, 50 )
		warn:SetDark( 1 )
		warn:SetConVar( "fnafgm_cl_warn" )
		warn:SetValue( GetConVar("fnafgm_cl_warn"):GetBool() )
		warn:SizeToContents()
		
		local autofnafview = vgui.Create( "DCheckBoxLabel" )
		autofnafview:SetParent(fnafgmMenuF.config)
		autofnafview:SetText(tostring(GAMEMODE.TranslatedStrings.autofnafview or GAMEMODE.Strings.en.autofnafview))
		autofnafview:SetPos( 15, 70 )
		autofnafview:SetDark( 1 )
		autofnafview:SetConVar( "fnafgm_cl_autofnafview" )
		autofnafview:SetValue( GetConVar("fnafgm_cl_autofnafview"):GetBool() )
		autofnafview:SizeToContents()
		
		local hud = vgui.Create( "DCheckBoxLabel" )
		hud:SetParent(fnafgmMenuF.config)
		hud:SetText(tostring(GAMEMODE.TranslatedStrings.dhud or GAMEMODE.Strings.en.dhud))
		hud:SetPos( 15, 90 )
		hud:SetDark( 1 )
		hud:SetConVar( "cl_drawhud" )
		hud:SetValue( GetConVar("cl_drawhud"):GetBool() )
		hud:SizeToContents()
		
		
		
		fnafgmMenuF.info = vgui.Create( "DPanel" )
		fnafgmMenuF.info:SetParent(fnafgmMenuF)
		fnafgmMenuF.info:SetPos( 10, 255 )
		fnafgmMenuF.info:SetSize( 305, 215 )
		
		local infolbl = vgui.Create( "DLabel" )
		infolbl:SetParent(fnafgmMenuF.info)
		infolbl:SetText( tostring(GAMEMODE.TranslatedStrings.infoat or GAMEMODE.Strings.en.infoat) )
		infolbl:SetPos( 10, 5 )
		infolbl:SetDark( 1 )
		infolbl:SizeToContents()
		
		local fontinfo = vgui.Create( "DLabel" )
		fontinfo:SetParent(fnafgmMenuF.info)
		fontinfo:SetText( tostring(GAMEMODE.TranslatedStrings.fontloaded or GAMEMODE.Strings.en.fontloaded)..": "..tostring(fontloaded or "false") )
		fontinfo:SetPos( 15, 30 )
		fontinfo:SetDark( 1 )
		fontinfo:SizeToContents()
		
		local cssinfo = vgui.Create( "DLabel" )
		cssinfo:SetParent(fnafgmMenuF.info)
		cssinfo:SetText( "Counter Strike: Source: "..tostring(IsMounted( 'cstrike' ) or "false") )
		cssinfo:SetPos( 15, 50 )
		cssinfo:SetDark( 1 )
		cssinfo:SizeToContents()
		
		local mapinfo = vgui.Create( "DLabel" )
		mapinfo:SetParent(fnafgmMenuF.info)
		mapinfo:SetText( "Map: "..game.GetMap() )
		mapinfo:SetPos( 15, 70 )
		mapinfo:SetDark( 1 )
		mapinfo:SizeToContents()
		
		local langinfo = vgui.Create( "DLabel" )
		langinfo:SetParent(fnafgmMenuF.info)
		langinfo:SetText( tostring(GAMEMODE.TranslatedStrings.lang or GAMEMODE.Strings.en.lang)..": "..GetConVarString("gmod_language") )
		langinfo:SetPos( 15, 90 )
		langinfo:SetDark( 1 )
		langinfo:SizeToContents()
		
		local mapselectb = vgui.Create( "DButton" )
		mapselectb:SetParent(fnafgmMenuF.info)
		mapselectb:SetText(tostring(GAMEMODE.TranslatedStrings.changemap or GAMEMODE.Strings.en.changemap))
		mapselectb:SetPos( 10, 185 )
		mapselectb:SetSize( 285, 20 )
		mapselectb:SetEnabled(LocalPlayer():IsAdmin())
		mapselectb.DoClick = function()
			RunConsoleCommand( "fnafgm_mapselect" )
			fnafgmMenuF:Close()
		end
		
		
		
		if !game.IsDedicated() and !tobool(DS) then --This doesn't work https://github.com/Facepunch/garrysmod-issues/issues/1495
			
			local resetprogress = vgui.Create( "DButton" )
			resetprogress:SetParent(fnafgmMenuF.info)
			resetprogress:SetText(tostring(GAMEMODE.TranslatedStrings.resetsave or GAMEMODE.Strings.en.resetsave))
			resetprogress:SetPos( 10, 160 )
			resetprogress:SetSize( 285, 20 )
			resetprogress:SetDisabled(SGvsA)
			resetprogress.DoClick = function()
				RunConsoleCommand( "fnafgm_resetprogress" )
				fnafgmMenuF:Close()
			end
		
		end
		
		
		
		fnafgmMenuF.debugmenu = vgui.Create( "DPanel" )
		fnafgmMenuF.debugmenu:SetParent(fnafgmMenuF)
		fnafgmMenuF.debugmenu:SetPos( 325, 255 )
		fnafgmMenuF.debugmenu:SetSize( 305, 215 )
		
		local debugmenulbl = vgui.Create( "DLabel" )
		debugmenulbl:SetParent(fnafgmMenuF.debugmenu)
		debugmenulbl:SetText( tostring(GAMEMODE.TranslatedStrings.debugmenu or GAMEMODE.Strings.en.debugmenu) )
		debugmenulbl:SetPos( 10, 5 )
		debugmenulbl:SetDark( 1 )
		debugmenulbl:SizeToContents()
		
		local startbtn = vgui.Create( "DButton" )
		startbtn:SetParent(fnafgmMenuF.debugmenu)
		startbtn:SetText(tostring(GAMEMODE.TranslatedStrings.start or GAMEMODE.Strings.en.start))
		startbtn:SetPos( 20, 45 )
		startbtn:SetSize( 265, 20 )
		startbtn.DoClick = function()
			RunConsoleCommand( "fnafgm_debug_start" )
			fnafgmMenuF:Close()
		end
		
		local restartbtn = vgui.Create( "DButton" )
		restartbtn:SetParent(fnafgmMenuF.debugmenu)
		restartbtn:SetText(tostring(GAMEMODE.TranslatedStrings.stop or GAMEMODE.Strings.en.stop))
		restartbtn:SetPos( 20, 75 )
		restartbtn:SetSize( 265, 20 )
		restartbtn.DoClick = function()
			RunConsoleCommand( "fnafgm_debug_restart" )
			fnafgmMenuF:Close()
		end
		
		local resetbtn = vgui.Create( "DButton" )
		resetbtn:SetParent(fnafgmMenuF.debugmenu)
		resetbtn:SetText(tostring(GAMEMODE.TranslatedStrings.reset or GAMEMODE.Strings.en.reset))
		resetbtn:SetPos( 20, 105 )
		resetbtn:SetSize( 265, 20 )
		resetbtn.DoClick = function()
			RunConsoleCommand( "fnafgm_debug_reset" )
			fnafgmMenuF:Close()
		end
		
		local refreshbtn = vgui.Create( "DButton" )
		refreshbtn:SetParent(fnafgmMenuF.debugmenu)
		refreshbtn:SetText(tostring(GAMEMODE.TranslatedStrings.refreshbypass or GAMEMODE.Strings.en.refreshbypass))
		refreshbtn:SetPos( 20, 135 )
		refreshbtn:SetSize( 265, 20 )
		refreshbtn.DoClick = function()
			RunConsoleCommand( "fnafgm_debug_refreshbypass" )
			fnafgmMenuF:Close()
		end
		
		local infobtn = vgui.Create( "DButton" )
		infobtn:SetParent(fnafgmMenuF.debugmenu)
		infobtn:SetText("Info (Console)")
		infobtn:SetPos( 20, 165 )
		infobtn:SetSize( 265, 20 )
		infobtn.DoClick = function()
			RunConsoleCommand( "fnafgm_debug_info" )
			fnafgmMenuF:Close()
		end
		
		
		local xpad = vgui.Create( "DHTML" )
		xpad:SetParent(fnafgmMenuF)
		xpad:SetPos( 10, 480 )
		xpad:SetSize( 620, 128 )
		xpad:SetAllowLua(true)
		xpad:OpenURL( "Xperidia.com/GMOD/ad?sys=fnafgmMenu&zone="..tostring(GAMEMODE.ShortName or "FNAFGM").."&lang="..tostring(GetConVarString("gmod_language") or "en") )
		xpad:SetScrollbars(false)
		
		xpad_anim = Derma_Anim( "xpad_anim", fnafgmMenuF, function( pnl, anim, delta, data )
			pnl:SetSize( 640, 138*delta+480 )
		end)
		
		hook.Call("fnafgmMenuCustom")
		
		
	elseif IsValid(fnafgmMenuF) then
		
		fnafgmMenuF:Close()
		
	end
	
end

function fnafgmMenuAdLoaded()
	if IsValid(fnafgmMenuF) then xpad_anim:Start(0.25) end
end