-- $Name: Лифтер 2$
-- $Version: 0.3$
if stead.version < "1.1.6" then
	error [[Для игры нужен INSTEAD версии не ниже, чем 1.1.6.
http://instead.googlecode.com]]
end

if stead.version < "1.5.3" then
	walk = _G["goto"]
	walkin = goin
	walkout = goout
	walkback = goback
end

--на случай если версия < 1.1.6
--function pr(...)
--	local i
--	for i = 1, stead.table.maxn(arg) do
--		cctx().txt = par('',cctx().txt, arg[i]);
--	end
--end;

function music(v, n)
	return function()
		set_music(v, n)
	end
end;

game.act = 'Не понимаю, что это.';
game.inv = 'Странный предмет.';
game.use = function()
	local reply = {
		'Не получится.',
		'Не думаю...',
		'Это не реально.',
		'Может другое что-нибудь?',
		'Не может быть!',
		'Нет, нет и ещё раз нет.',
		'Точно?',
	}
	return reply[rnd(#reply)];
end;

game.codepage="UTF-8"
dofile("intro.lua");
dofile("d1.lua");
dofile("d2.lua");
dofile("d3.lua");
dofile("d4.lua");
