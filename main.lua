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

stead.list_add = function(self, name, pos)
    local nam = name
    if stead.initialized then
        nam = stead.ref(name);
    end
    if not nam then
        error ("Add wrong object to list: "..tostring(name), 2);
    end
    if self:look(nam) then
        return nil
    end
    self.__modified__ = true;
    if isObject(stead.deref(nam)) then
        nam._dynamic_type = true
    end
    if tonumber(pos) then
        pos = tonumber(pos)
        if pos <= #self then
            stead.table.insert(self, pos, nam);
        else
            self[pos] = nam; -- for spare lists
        end
    else
        stead.table.insert(self, nam);
    end
    return true
end;

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
