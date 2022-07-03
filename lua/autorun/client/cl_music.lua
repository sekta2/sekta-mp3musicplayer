AddCSLuaFile()

local rain = 0
local bplus = 0
local playing = false
local station = nil
local loop = false

/* by sekta */

surface.CreateFont("ma_roboto",{
	font = "Roboto",
	size = 15,
	weight = 5000,
	extended = true,
	shadow = true
})

function createAudio(url)
	sound.PlayURL(url,"mono noblock", function(stati,errorid,errortext)
		if IsValid(station) then station:Stop() station=nil end
		if IsValid(stati) then
			station=stati
			lasturl=url
			station:SetPos(LocalPlayer():GetPos())
			station:EnableLooping(loop)
			station:Play()
			playing=true
		end
	end)
end

function openDerma()

	local a = vgui.Create("DFrame")
	a:SetSize(0,350)
	a:Center()
	a:SetTitle("Музыкальный плеер")
	a:MakePopup()
	a.center = false
	a:ShowCloseButton(false)
	a.Paint = function(self,w,h)
		draw.RoundedBox(6,0,0,w,h,Color(26,26,71,255))
	end

	local b1 = vgui.Create("DButton",a)
	b1:SetSize(700,35)
	b1:SetPos(0,350-35)
	b1:SetText("Закрыть")
	b1.c = 0
	b1.Paint = function(self,w,h)
		if b1:IsHovered() then
			b1.c = b1.c+(700-b1.c)/bplus
		else b1.c = b1.c+(0-b1.c)/bplus end
		draw.RoundedBoxEx(6,700/2-b1.c/2,0,b1.c,35,HSVToColor(rain,1,1),false,false,true,true)
	end
	b1.DoClick = function()
	a.center=true
	a:SizeTo(700,0,0.3,0,.1,function()
		a.center = false
		a:Remove()
	end)
	end

	local te1 = vgui.Create("DTextEntry",a)
	te1:SetSize(700,35)
	te1:SetPos(0,350-35-35-35-35-35-35-35-35)
	te1:SetText(LocalPlayer():GetPData("MA_LASTTRACKURL","Сыллка на mp3 файл"))
	te1.c = 0
	te1.Paint = function(self,w,h)
		if te1:IsHovered() then
			te1.c = te1.c+(700-te1.c)/bplus
		else te1.c = te1.c+(0-te1.c)/bplus end
		draw.RoundedBox(0,700/2-te1.c/2,35-5/2,te1.c,5,HSVToColor(rain,1,1))
		draw.SimpleText(te1:GetValue(),"ma_roboto",700/2,35/2,Color(255,255,255,205),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

	te1.OnTextChanged = function()
		LocalPlayer():SetPData("MA_LASTTRACKURL",te1:GetValue())
	end

	local b2 = vgui.Create("DButton",a)
	b2:SetSize(700,35)
	b2:SetPos(0,350-35-35)
	b2:SetText("Слушать")
	b2.c = 0
	b2.Paint = function(self,w,h)
		if b2:IsHovered() then
			b2.c = b2.c+(700-b2.c)/bplus
		else b2.c = b2.c+(0-b2.c)/bplus end
		draw.RoundedBox(0,700/2-b2.c/2,0,b2.c,35,HSVToColor(rain,1,1))
	end
	b2.DoClick = function()
		createAudio(te1:GetValue())
	end

	local b3 = vgui.Create("DButton",a)
	b3:SetSize(700,35)
	b3:SetPos(0,350-35-35-35)
	b3:SetText("Пауза/Продолжить")
	b3.c = 0
	b3.Paint = function(self,w,h)
		if b3:IsHovered() then
			b3.c = b3.c+(700-b3.c)/bplus
		else b3.c = b3.c+(0-b3.c)/bplus end
		draw.RoundedBox(0,700/2-b3.c/2,0,b3.c,35,HSVToColor(rain,1,1))
	end
	b3.DoClick = function()
		if IsValid(station) then if station:GetState() == 1 then playing = false station:Pause() elseif station:GetState() == 2 then station:Play() playing = true end end
	end

	local b4 = vgui.Create("DButton",a)
	b4:SetSize(700,35)
	b4:SetPos(0,350-35-35-35-35)
	b4:SetText("Стоп")
	b4.c = 0
	b4.Paint = function(self,w,h)
		if b4:IsHovered() then
			b4.c = b4.c+(700-b4.c)/bplus
		else b4.c = b4.c+(0-b4.c)/bplus end
		draw.RoundedBox(0,700/2-b4.c/2,0,b4.c,35,HSVToColor(rain,1,1))
	end
	b4.DoClick = function()
		if IsValid(station) then if station:GetState() == 1 or station:GetState() == 2 then station:Stop() playing=false station=nil end end
	end

	local b5 = vgui.Create("DButton",a)
	b5:SetSize(700,35)
	b5:SetPos(0,350-35-35-35-35-35)
	b5:SetText("Громче +5")
	b5.c = 0
	b5.Paint = function(self,w,h)
		if b5:IsHovered() then
			b5.c = b5.c+(700-b5.c)/bplus
		else b5.c = b5.c+(0-b5.c)/bplus end
		draw.RoundedBox(0,700/2-b5.c/2,0,b5.c,35,HSVToColor(rain,1,1))
	end
	b5.DoClick = function()
		if IsValid(station) then station:SetVolume(station:GetVolume()+0.05) end
	end

	local b6 = vgui.Create("DButton",a)
	b6:SetSize(700,35)
	b6:SetPos(0,350-35-35-35-35-35-35)
	b6:SetText("Тише -5")
	b6.c = 0
	b6.Paint = function(self,w,h)
		if b6:IsHovered() then
			b6.c = b6.c+(700-b6.c)/bplus
		else b6.c = b6.c+(0-b6.c)/bplus end
		draw.RoundedBox(0,700/2-b6.c/2,0,b6.c,35,HSVToColor(rain,1,1))
	end
	b6.DoClick = function()
		if IsValid(station) then station:SetVolume(station:GetVolume()-0.05) end
	end

	local b7 = vgui.Create("DButton",a)
	b7:SetSize(700,35)
	b7:SetPos(0,350-35-35-35-35-35-35-35)
	b7:SetText("Повтор")
	b7.c = 0
	b7.Paint = function(self,w,h)
		if b7:IsHovered() then b7.c=b7.c+(700-b7.c)/bplus else b7.c=b7.c+(0-b7.c)/bplus end
		if loop then
			color=Color(0,255,0,255)
		else color=Color(255,0,0,255) end
		draw.RoundedBox(0,700/2-b7.c/2,0,b7.c,35,color)
	end
	b7.DoClick = function()
		loop=!loop
		if IsValid(station) then station:EnableLooping(loop) end
	end















	a.Think = function(me)
		if a.center == true then
			me:Center()
		end
	end

	a.center=true
	a:SizeTo(700,350,0.7,0,.1,function()
		a.center = false
	end)

end

hook.Add("OnPlayerChat","ma_chat",function(ply,text,dead,team)
	if ply==LocalPlayer() then
		if text == "!music" or text == "/music" then

			openDerma()

		end
	end
end)

concommand.Add("sekta_music", function()
	openDerma()
end)

hook.Add("Think","ma_think",function()
	rain=rain+1
	bplus=(1/RealFrameTime())/10
	if playing then
		station:SetPos(LocalPlayer():GetPos())
	end
end)

/* by sekta */

hook.Add("HUDPaint","ma_paint",function()
	if playing and station:GetState() != 2 and station:GetState() != 0 then
		local data = {}
		station:FFT(data,FFR_512)	
		local plus = (ScrW()/250)
		for i = 1, 250 do
			local rainbow = (i*(255/250))+rain
			draw.RoundedBox(8, i*(plus), -1, plus+1, data[i]*550, HSVToColor(rainbow,1,1))
		end
	end
end)
