me()._is_morning3 = false; --новое утро
me()._is_cat_check = false; --проверил ли кота
me()._is_seen_labelgl1 = false; --видел ли надпись Глава 1
me()._is_camera_right = false; --разрешено ли пользоваться камерой
me()._is_were_in_dima_flat = false; --был ли в кв. Димы
me()._is_seen_stepan_run = false; -- видел ли Степана на лестничной пл.
me()._loss_stepan_keys = false; --потерял ли ключи Степана
me()._is_stepan_close = false; --закрыт ли Степан на чердаке
me()._watch_peephole = false; --смотрел ли в глазок
me()._is_night = false; --ночь

morning3 = room {
	nam = 'Утро...',
	dsc = [[На этот раз я встал поздновато. 10:00...^^
Нужно пойти проведать кота Димы.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd73level2')},
	enter = function()
		me()._is_morning3 = true;
		me()._is_post = true;
		me()._post = 'newspaper73';

		objs('d77p1level9'):add('label_gl1', 2);
		objs('d77p1level8'):add('lens');

		set_music('snd/yard1.ogg');
	end,
	exit = music('snd/pod1.ogg'),
	nomobil = true,
	pic = 'img/morning.png;img/morning3.png@88,33',
};

--газета 73
newspaper73 = obj {
	nam = img('img/icn_newspaper73.png')..'газета (№73)',
	inv = function()
		return [[«Вечерний обзор», №73.^^
В этом выпуске пишут о прорвавшей трубе... Ничего интересного.]];
	end,
};

--надпись Глава 1
label_gl1 = obj {
	nam = 'надпись',
	dsc = [[На дверях лифта есть {надпись}.]],
	act = function()
		if not me()._is_seen_labelgl1 then
			me()._is_seen_labelgl1 = true;
			return walk('scn_gl1');
		else
			return 'Надпись: «Глава 1. Смерть Петра и Олега».';
		end
	end,
};

--дверь в зал
dima_hall_door = obj {
	nam = 'дверь в зал',
	dsc = [[Передо мной расположена {дверь в зал}.]],
	act = [[Двойная дверь с витражами.]],
};

--дверь в кухню
dima_kitchen_enter = obj {
	nam = 'вход в кухню',
	dsc = [[{вход в кухню}.]],
	act = [[Дверь в кухню открыта. Можно идти.]],
};

--дверь в санузел
dima_toilet_door = obj {
	nam = 'дверь в санузел',
	dsc = [[Справа — {дверь в санузел}, ]],
	act = function()
		if me()._is_night then
			ways('dima_corridor'):add('dima_toilet');
			return [[Думаю, туда всё же придётся идти.]];
		else
			return [[Туалет, совмещённый с ванной. Особой нужды туда
идти у меня нет. А просто так туда заходить нет желания. У меня некая
фобия появилась после игр INSTEAD'а.]];
		end
	end,
};

--дверь в комнаты
dima_rooms_door = obj {
	nam = 'дверь в комнаты',
	dsc = [[Слева находится {дверь в комнаты}.]],
	act = [[Обычная деревянная дверь. Белая. Есть ручка. За дверью
комната Димы и спальня. Но Дима просил меня не ходить туда.]],
};

--угол
corner = obj {
	nam = 'угол',
	dsc = function(s)
		p [[В {углу}]];
		if not s.obj:look('cat_toilet') then
			p [[сейчас ничего нет.]];
		end
	end,
	act = [[Угол коридора...]],
	obj = {'cat_toilet'},
};

--туалет кота
cat_toilet = obj {
	nam = img('img/icn_cat_toilet.png')..'кошачий туалет',
	dsc = function(s)
		p [[стоит {кошачий туалет}.]];
		if s._full then
			p [[От него большая вонь.]];
		end
	end,
	act = function()
		if me()._is_night then
			return [[Туалет пустой. Я его лично убрал.]];
		else
			return [[Пустой кошачий туалет. Когда-нибудь он будет не
пустым.]];
		end
	end,
	tak = function(s)
		if s._full then
			return [[Я взял кошачий туалет в руки. В нём фекалии. Ну и
вонь. Фу.]];
		end
	end,
	inv = function(s)
		if s._full then
			return [[В туалете кошачьи фекалии. Ну и вонь. Похоже,
Армен сходил в туалет.]];
		elseif not s._clean then
			return [[Пустой кошачий туалет. Но в нем остались следы
фекалий. Поэтому он ещё воняет.]];
		else
			return [[Чистый кошачий туалет. Я его лично убрал.]];
		end
	end,
	use = function(s, w)
		if w == 'pan' then
			if s._full then
				s._full = false;
				set_sound('snd/washoff.ogg');
				return [[Я слил фекалии в унитаз.]];
			else
				return [[Кошачий туалет пустой.]];
			end
		elseif w == 'toilet_sink' then
			if s._full then
				return [[Фекалии?! В раковину?!]];
			else
				if s._clean then
					return [[Кошачий туалет чистый.]];
				else
					s._clean = true;
					set_sound('snd/water.ogg');
					return [[Я помыл туалет в раковине.]];
				end
			end
		elseif w == 'sink' then
			if s._full then
				return [[Фекалии?! В раковину?!]];
			else
				if s._clean then
					return [[Кошачий туалет чистый.]];
				else
					return [[В кухне туалет лучше не мыть.]];
				end
			end
		elseif w == 'bowl_for_food' or w == 'bowl_for_water' then
			if s._full then
				return [[Ого. Вот это мысли... Я бы насыпал фекалии в
миску Армена, но... Я ценю дружбу Димы. Мы с ним давно дружим. Поэтому
за его котом необходимо поухаживать нормально.]];
			else
				return [[В туалете уже нет фекалий. Нечего в миску
класть.]];
			end
		elseif w == 'corner' then
			if s._full then
				return [[В кошачьем туалете есть фекалии...]];
			elseif not s._clean then
				return [[В кошачьем туалете остался запах.]];
			else
				inv():del(s);
				corner.obj:add(s);
				return [[Я поставил кошачий туалет обратно.]];
			end
		end
	end,
	_full = false,
	_clean = false,
};

--бра
lamp = obj {
	nam = 'бра',
	dsc = [[Возле входной двери весит {бра}.]],
	act = [[Небольшая бра с белым плафоном.]],
};

--кабель из стены
wall_cable = obj {
	nam = 'кабель',
	dsc = [[Под ней торчит {кабель}.]],
	act = function(s)
		p [[Это кабель типа «тюльпан». Он проложен из перегородки.]];
		if s._connect then
			p [[К нему подлючён один конец другого кабеля.]];
		end
	end,
	_connect = false,
};

--Коридор квартиры Димы
dima_corridor = room {
	nam = function(s)
		pr 'Коридор';
		if here() == s then
			pr ' (Квартира Димы)';
		end
	end,
	dsc = 'Я нахожусь в коридоре Димы.',
	obj = {'dima_hall_door', 'dima_rooms_door', 'dima_toilet_door', 'dima_kitchen_enter', 'corner', 'lamp', 'wall_cable'},
	way = {'d77p1level8', 'dima_hall', 'dima_kitchen'},
	enter = function(s, f)
		if f == 'd77p1level8' then
			me()._is_were_in_dima_flat = true;
			return [[Я вошёл в перегородку, затем открыл дверь в
квартиру Димы, и зашёл в коридор.]];
		end
		if cat_toilet._full then
			return [[Я чую мерзкий запах фекалий...]];
		end
	end,
	exit = function(s, t)
		if me()._watch_peephole then
			if t == 'd77p1level8' then
				return [[Нет! Лучше подождать до утра. Не хочу оказаться
втянутым в то, что там происходит.]], false;
			end
		else
			if t ~= 'dima_hall' then
				if wall_cable._connect and not dima_tv._connect then
					wall_cable._connect = false;
					return [[Я отсоединил кабель от кабеля в коридоре.]];
				end
			end
		end
	end,
	pic = 'img/dima_corridor.png',
};

--кот Армен
cat_armen = obj {
	nam = 'кот',
	dsc = function()
		p [[На табуретке лежит {кот}.]];
		if not me()._is_cat_check then
			p [[Он живой хоть?]];
		end
	end,
	act = function()
		if me()._is_cat_check then
			return [[Кот Армен помурлыкал и продолжил спать.]];
		else
			me()._is_cat_check = true;
			return [[Я погладил кота Армена, он помурлыкал в ответ. Он
просто спит... Пусть дальше спит.]];
		end
	end,
};

--табуретка
stool = obj {
	nam = 'табуретка',
	dsc = [[Возле стола стоит {табуретка}.]],
	act = [[Крепкая деревянная табуретка.]],
	obj = {'cat_armen'},
};

--миска для еды
bowl_for_food = obj {
	nam = img('img/icn_bowlfood.png')..'миска для еды',
	dsc = [[Под столом стоит {миска для еды}.]],
	act = [[В миске лежит каша.]],
	tak = function(s)
		if me()._is_night and not s._full then
			return [[Я взял миску для еды. Она пуста.]];
		end
	end,
	inv = function(s)
		p [[Миска Армена для еды.]];
		if s._full then
			p [[Она полная.]];
		else
			p [[Она пуста.]];
		end
	end,
	use = function(s, w)
		if w == 'pot' then
			if s._full then
				return [[В миске уже есть каша.]];
			else
				s._full = true;
				return [[Я насыпал в миску каши.]];
			end
		elseif w == 'dima_table' then
			if s._full then
				inv():del(s);
				dima_table.obj:add(s, 1);
				lifeoff('cat_armen_live');
				objs():del('cat_armen_live');
				dima_table.obj:add('cat_armen_eat');
				set_sound('snd/nyam.ogg');
				return [[Я поставил под стол миску с едой.]];
			else
				return [[Миска пустая. Нужно в неё положить еды.]];
			end
		else
			if not s._full then
				return [[Еду надо.]];
			end
		end
	end,
	_full = false,
};

--миска для воды
bowl_for_water = obj {
	nam = img('img/icn_bowlwater.png')..'миска для воды',
	dsc = function()
		if dima_table.obj:look('bowl_for_food') then
			return [[Рядом {миска для воды}.]];
		else
			return [[Под столом стоит {миска для воды}.]];
		end
	end,
	act = [[В миске есть вода.]],
		tak = function(s)
		if me()._is_night and not s._full then
			return [[Я взял миску для воды. Она пуста.]];
		end
	end,
	inv = function(s)
		p [[Миска Армена для воды.]];
		if s._full then
			p [[Она полная.]];
		else
			p [[Она пуста.]];
		end
	end,
	use = function(s, w)
		if w == 'sink' or w == 'toilet_sink' then
			if s._full then
				return [[В миске уже есть вода.]];
			else
				s._full = true;
				return [[Я налил в миску воды.]];
			end
		elseif w == 'dima_table' then
			if s._full then
				inv():del(s);
				dima_table.obj:add(s, 2);
				return [[Я поставил под стол миску с водой.]];
			else
				return [[Миска пустая. Нужно воды налить.]];
			end
		else
			if not s._full then
				return [[В миску бы воды...]];
			end
		end
	end,
	_full = false,
};

--стол
dima_table = obj {
	nam = 'стол',
	dsc = [[Посередине кухни стоит {стол}.]],
	act = [[Кухонный стол. Со скатертью. На нём несколько кружек, солонка.]],
	obj = {'bowl_for_food', 'bowl_for_water'},
};

-- кастрюля
pot = obj {
	nam = 'кастрюля',
	dsc = [[В холодильнике стоит {кастрюля}.]],
	act = [[В кастрюле каша, смешанная с рыбой. В этой же кастрюле есть ложка.
Похоже, это для Армена.]],
};

--холодильник
refrigerator = obj {
	nam = 'холодильник',
	dsc = function(s)
		p [[В углу стоит]];
		if s._opened then
			p [[открытый {холодильник}.]];
		else
			p [[{холодильник}.]];
		end
	end,
	act = function(s)
		s._opened = not s._opened;
		if s._opened then
			s.obj:add('pot');
			return [[Я открыл холодильник.]];
		else
			s.obj:del('pot');
			return [[Я закрыл холодильник.]];
		end
	end,
	_opened = false;
};

--раковина
sink = obj {
	nam = 'раковина',
	dsc = [[Сбоку — {раковина}.]],
	act = [[Раковина пуста. И это хорошо.]],
};

--Кухня Димы
dima_kitchen = room {
	nam = function(s)
		pr 'Кухня';
		if here() == s then
			pr ' (Квартира Димы)';
		end
	end,
	dsc = [[Я в кухне Димы.]],
	obj = {'dima_table', 'stool', 'refrigerator',
vobj(1, 'печь', [[У другой стены находится газовая {печка}.]]), sink,},
	act = function(s, w)
		if w == 1 then
			return [[Газовая печка нового поколения. Ничего особенного.]];
		end
	end,
	way = {'dima_corridor'},
	exit = function()
		if refrigerator._opened then
			refrigerator.obj:del('pot');
			refrigerator._opened = false;
			return [[Я закрыл холодильник.]];
		end
	end,
	pic = function()
		pr 'img/dima_kitchen.png;';
		if dima_table.obj:look('bowl_for_food') then
			pr 'img/bowl_for_food.png@108,145;';
		end
		if dima_table.obj:look('bowl_for_water') then
			pr 'img/bowl_for_water.png@107,157;';
		end
		if dima_table.obj:look('cat_armen_eat') then
			pr 'img/armen_eat.png@119,115;';
		elseif not me()._is_night then
			pr 'img/armen_sleep.png@31,141;';
		end
	end,
};

--кабель в телевизоре
tv_cable = obj {
	nam = 'кабель',
	dsc = [[В телевизор подключён {кабель}.]],
	act = [[Это кабель типа «тюльпан». Он подключён к кабелю в коридоре.]],
};

--телевизор
dima_tv = obj {
	nam = 'телевизор',
	dsc = [[На тумбе стоит {телевизор}.]],
	act = function()
		if me()._is_seen_stepan_run then
			if me()._watch_peephole then
				return [[Я посмотрел, что происходит на лестничной
площадке через камеру. Вроде бы сейчас всё тихо. Но, лучше не
выходить...]];
			else
				return [[Света нет. Телевизор не работает.]];
			end
		elseif dima_tv._connect then
			return walk('scn_stepan_run');
		else
			pr [[Я включил телевизор. А там:^^«]];
			local tv_channel = {
[[...Я любил тебя так сладко.^
На облаках было так жарко.^
Я любил шоколадки.^
А ты тоже шоколадка]],
[[...Мы должны быть впереди! Только так мы добьёмся успеха! Эта зубная
паста будет вашим проводником]],
[[— Даже когда я звоню, я мою посуду.^
— Не мой посуду, я купил тебе вибраторную соковыжималку]],
[[Уходи. Но помни меня.^
Я тебя помню.^
Эта песня о нас.^
Сладкая шоколадка]],
[[— Скажите, вы хотите женится?^
— Я не знаю, я...^
— Гей?^
— Ну, как бы вам сказать...^
— Мы приглашаем сюда вашего парня!^
— Он здесь? Блин]],
[[Вы посмотрите, как наш чудо-нож режет овощи! Это просто сенсация!
Если вы позвоните сейчас, то получите в подарок чудо-дрель]],
[[— Мария, я так тебя люблю!^
— Я тебя тоже!^
— Но ты замужем за Роджером!^
— Я запуталась]],
[[— Вы знаете, что даже сейчас на ваших зубах бактерии?^
— Правда?^
— Я в белом халате, значит я учёный и умный]],
[[— Наша посудомоечная машина аж на целых 80 тысяч ватт! Покупайте её и
экономьте на воде!^
— Я купила и стала платить за воду на 15 копеек меньше! Правда за свет
теперь плачу в 3 раза больше. Наверное дочка за компьютером много сидит]],
[[Иногда так бывает, что хочется... Чего-то такого... Такого... Ну, как
вам объяснить? Такого коричневатого, с пупырышками... Свежего... Ломкого...
Очень соблазнительного... Шоколада хочется. Самый лучший шоколад — это]],};
			pr (tv_channel[rnd(#tv_channel)]);
			p [[...»^^После этого я его выключил...]];
			set_sound('snd/tv.ogg');
		end
	end,
	_connect = false,
};

--кабель
cable = obj {
	nam = img('img/icn_cable.png')..'кабель',
	dsc = [[В ней лежит {кабель}.]],
	inv = function()
		p [[Длинный кабель с разъёмами типа «тюльпан».]];
		if wall_cable._connect then
			p [[Один его конец подключён к кабелю в коридоре.]];
		end
	end,
	tak = function(s)
		s._taked = true;
		return [[Я взял кабель.]]
	end,
	use = function(s, w)
		if w == 'wall_cable' then
			wall_cable._connect = true;
			return [[Я соединил кабели.]];
		elseif w == 'dima_tv' then
			if wall_cable._connect then
				dima_tv._connect = true;
				dima_tv.obj:add('tv_cable');
				inv():del('cable');
				return [[Я подключил кабель к телевизору.]];
			else
				return [[Нет смысла подключать кабель к телевизору. В нём
нет сигнала.]];
			end
		end
	end,
	_taked = false,
};

--тумба
stand = obj {
	nam = 'тумба',
	dsc = function(s)
		p [[В центре комнаты расположена {тумба}.]];
		if me()._is_camera_right then
			if s._opened then
				p [[Она открыта.]];
				if cable._taked then
					p [[Внутри тумбы ничего нет.]];
				end
			else
				p [[Она закрыта.]];
			end
		end
	end,
	act = function(s)
		if me()._is_camera_right then
			s._opened = not s._opened;
			if s._opened then
				if not cable._taked then
					s.obj:add('cable', 1);
				end
				return [[Я открыл дверцы тумбы.]];
			else
				if not cable._taked then
					s.obj:del('cable');
				end
				return [[Я закрыл дверцы тумбы.]];
			end
		else
			return [[В тумбе есть дверцы. Но я не собираюсь лазить в чужих вещах.]];
		end
	end,
	obj = {'dima_tv'},
	_opened = false,
};

--диван
dima_sofa = obj {
	nam = 'диван',
	dsc = [[Справа стоит {диван}.]],
	act = function()
		if me()._watch_peephole and not me()._is_night then
			return walk('sleep3n');
		elseif dima_table.obj:look('cat_armen_eat')
			and corner.obj:look('cat_toilet')
			and cat_toilet._clean then
			return walk('sleepnm');
		elseif me()._is_night then
			return [[Спать хочется, но надо за Арменом поухаживать.]];
		else
			return [[Удобный мягкий диван. Чем-то похож на мой.]];
		end
	end,
};

--Зал Димы
dima_hall = room {
	nam = function(s)
		pr 'Зал';
		if here() == s then
			pr ' (Квартира Димы)';
		end
	end,
	dsc = [[Я в зале.]],
	obj = {'stand', 'dima_sofa'},
	way = {'dima_corridor'},
	enter = function()
		if dima_table.obj:look('cat_armen_eat')
			and corner.obj:look('cat_toilet')
			and cat_toilet._clean then
			return [[Кажется, со всем разобрался. Можно наконец-то
лечь поспать.]];
		end
	end,
	pic = 'img/dima_hall.png',
};

--линза
lens = obj {
	nam = function(s)
		if s._is_seen then
			return 'линза';
		else
			return 'точка';
		end
	end,
	dsc = function(s)
		if s._is_seen then
			return [[Над перегородкой {линза} камеры.]];
		else
			return [[Над перегородкой заметна блестящая тёмная {точка}.]];
		end
	end,
	act = function(s)
		if s._is_seen then
			if me()._is_camera_right then
				return [[Камера. Дима её когда-то установил.]];
			else
				return [[Надо у Димы спросить об этой камере.]];
			end
		elseif me()._is_seen_labelgl1 then
			s._is_seen = true;
			return [[Это линза... Там стоит камера. Хм... Надо у Димы
спросить об этой камере.]];
		else
			return [[Какая-то блестящая штука. Она меня сейчас не интересует.]];
		end
	end,
	_is_seen = false,
};

--арматура
armature = obj {
	nam = img('img/icn_armature.png')..'арматура',
	dsc = [[На полу возле лифта лежит {арматура}.]],
	tak = [[Я взял арматуру.]],
	inv = [[Арматура. Тяжеловатая. Наверное, Степан что-то делал с ней у лифта.]],
	use = function(s, w)
		if w == 'stepan_attic' then
			if stepan_attic._out then
				return [[Я его уже вырубил. Не стоит больше его бить.]];
			else
				stepan_attic._out = true;
				set_sound('snd/strike.ogg');
				set_music('snd/act2.ogg');
				return [[Я сильно ударил Степана по голове арматурой. Он сразу же
упал. Жалко... Но, что поделать? Заслужил.]];
			end
		else
			return [[Арматурой?! Вдребезги?!]];
		end
	end,
};

--молоток
hammer = obj {
	nam = img('img/icn_hammer.png')..'молоток',
	dsc = [[Ещё на полу есть {молоток}.]],
	tak = [[Я взял молоток.]],
	inv = [[Молоток. Наверное, Степан что-то делал с ним у лифта.]],
	use = function(s, w)
		if w == 'stepan_attic' then
			if stepan_attic._out then
				return [[Я его уже вырубил. Не стоит больше его бить.]];
			else
				stepan_attic._out = true;
				set_sound('snd/strike.ogg');
				set_music('snd/act2.ogg');
				return [[Я сильно ударил Степана по голове молотком. Он сразу же
упал. Жалко... Но, что поделать? Заслужил.]];
			end
		else
			return [[Молоточком можно и повредить.]];
		end
	end,
};

--механизм
mechanism = obj {
	nam = 'механизм',
	dsc = [[Перед Степаном какой-то {механизм}, связанный с лифтом.]],
	act = [[Я об этом механизме ничего не знаю.]],
};

--дверь на крышу
door_roof = obj {
	nam = 'дверь',
	dsc = [[Над лестницей есть {дверь на крышу}.]],
	act = [[Дверь закрыта на навесной замок.]],
};

--лестница
ladder_attic = obj {
	nam = 'лестница',
	dsc = [[Сбоку чердака есть {лестница}, ведущая на крышу.]],
	act = function(s)
		if stepan_attic._out then
			if not s._seen then
				s.obj:add('door_roof');
				s._seen = true;
			end
			return [[Она ведёт к двери.]];
		else
			return [[Пока что не до неё.]];
		end
	end,
	_seen = false;
};

--инструменты
tools = obj {
	nam = img('img/icn_tools.png')..'инструменты',
	dsc = [[Справа от Степана стоит {ящик с инструментами}.]],
	act = [[Пока что не до инструментов.]],
	tak = function()
		if stepan_attic._out then
			return [[Я взял инструменты Степана.]];
		end
	end,
	inv = [[Инструменты Степана. Монтажки, отвёртки, прочее...]],
};

--фонарик у Степана
stepan_lamp = obj {
	nam = 'фонарик',
	dsc = [[У Степана в руках {фонарик}. Именно он излучает хоть какой-то свет.]],
	act = function()
		if stepan_attic._out then
			return [[Пусть у него фонарик останется. У меня и так барахла
всякого полно, а ему не так в темноте страшно будет когда очнётся.]];
		else
			return [[Выхватить? Нет!]];
		end
	end,
};

--связка ключей
stepan_keys = obj {
	nam = img('img/icn_stepan_keys.png')..'ключи Степана',
	inv = [[Это служебные ключи Степана. Они все от навесных замков.]],
	use = function(s, w)
		if w == 'door_roof' then
			return [[Может какой-нибудь из ключей и подойдёт к замку на двери,
но я не собираюсь лезть на крышу.]];
		end
	end,
};

--Степан
stepan_attic = obj {
	nam = 'Степан',
	dsc = function(s)
		if s._out then
			return [[Передо мной лежит {Степан}.]];
		else
			return [[Передо мной сидит {Степан}, который в чём-то ковыряется.]];
		end
	end,
	act = function(s)
		if s._out then
			if not have('stepan_keys') then
				inv():add('stepan_keys');
				return [[Я порылся в карманах Степана и нашёл там связку ключей!]];
			else
				return [[Степан лежит без сознания. Жалко. А что ещё делать надо
было?]];
			end
		else
			return [[Ах, он гад! Он подкручивает лифт! Из-за него погибнут люди!
Надо его обезвредить пока он меня не увидел.]];
		end
	end,
	obj = {'stepan_lamp'},
	_out = false;
};

--чердак 77-1
d77p1_attic = room {
	nam = lev_title('Чердак'),
	dsc = [[В чердаке довольно темно.]],
	obj = {'stepan_attic', 'mechanism', 'tools', 'ladder_attic'},
	way = {'d77p1level9'},
	exit = function()
		if stepan_attic._out then
			
			if not me()._loss_stepan_keys then
				if not have('tools') or not have('stepan_keys') then
					return [[Нет. Не уйду. Я не всё забрал.]], false;
				elseif have('stepan_keys') then
					return walk('scn_keys_loss');
				end
			else
				return [[Надо как-то закрыть Степана.]];
			end
		end
	end,
	enter = function()
		if stepan_attic._out then
			return [[Хватит мне тут уже бродить. Нужно закрыть Степана!]];
		end
	end,
	pic = function()
		pr 'img/d77p1_attic.png;';
		if seen('tools') then
			pr 'img/tools_box.png@84,159;';
		end
		if stepan_attic._out then
			pr 'img/stepan_out.png@172,107';
		else
			pr 'img/stepan_sit.png@150,58';
		end
	end,
};

--замок на люке
hatch_lock = obj {
	nam = 'замок',
	dsc = [[В петлях люка навесной {замок}.]],
	act = function(s)
		if s._closed then
			return [[Замок закрыт!]];
		else
			return [[Открытый замок.]];
		end
	end,
	_closed = false,
};

--Диалог с Димой в 3-й день
mob_dima_day3_dlg = dlg {
	nam = 'Звонок Диме',
	dsc = [[Я позвонил Диме и услышал его радостное «Алё».]],
	obj = {
	[1] = phr('Привет. Ну, что, приехали уже?', 'Приехать-то приехали. А вот из подъезда еле вышли. Родителям не легко было, у нас света утром не было. Лифт не работал. Сейчас уже хоть дали?', [[pon(2);]]),
	[2] = _phr('Да, свет уже есть. А холодильник ты не отключал?', 'Не. Оставил. Ещё, когда спускались, у папы с рюкзака диск и ручка выпали. Он их поднимать не стал. Сказал, что не нужны ему. Зачем тогда брать было?'),
	[3] = phr('Расположились уже в номерах?', 'Да. Тут кондиционеры даже есть. И зомбо-ящик. Хорошо, я хоть фильмов с торрентов накачал про мертвецов. Буду на ноуте смотреть.', [[pon(4);]]),
	[4] = _phr('Жуть эти фильмы ужасов. Но, я уже повзрослел.', 'Я тоже. Теперь родители мне разрешают их смотреть.'),
	[5] = _phr('Слушай. Я у тебя в стенке перегородки камеру заметил...', 'А. Я как-то поставил... Стоп. Ты кота моего посмотрел?', [[pon(6);if me()._is_cat_check then pon(7); end;]]),
	[6] = _phr('Нет.', 'Посмотри! И перезвони мне сразу же!', [[return back();]]),
	[7] = _phr('Да. Спит на табуретке.', 'Это хорошо. А камера рабочая вроде. В коридоре висит шнур от неё. В тумбочке посмотри удлинитель. Можешь подсоединить к телику. Ладно, до связи!', [[me()._is_camera_right = true; poff(6); return back();]]),
	[8] = _phr('Как отдых?', 'Нормально! Не скучай там! И за Арменом приглядывай.', [[return back();]]),
	},
	enter = function(s)
		if lens._is_seen and not me()._is_camera_right then
			s:pon(5);
		else
			s:pon(8);
		end
	end,
	pic = 'img/mob_dlg.png',
};

--Глава 1
scn_gl1 = room {
	nam = 'Глава 1. Смерть Петра и Олега',
	dsc = [[Надпись: «Глава 1. Смерть Петра и Олега».^^
Значит, они действуют как и планировали... Скоро тут что-то произойдёт.
Как бы за ними проследить?]],
	obj = {vway('Продолжить', '{Продолжить}', 'd77p1level9')},
	enter = function(s)
		s._mus = get_music();
		set_music('snd/act1.ogg');
	end,
	exit = function(s)
		set_music(s._mus);
	end,
	nomobil = true,
	pic = 'img/scn_gl1.png',
};

--Степан
scn_stepan_run = room {
	nam = 'Степан',
	dsc = [[Я внимательно следил за камерой по телевизору.^^
И я увидел то, чего ждал. По лестнице вверх поднялся Степан. Через
несколько минут телевизор потух. Наверняка, это они выключили свет!^^
Надо что-то предпринять. Дело серьёзное. Я уже почти уверен,
что они будут убивать людей.]],
	obj = {vway('Продолжить', '{Продолжить}', 'dima_hall')},
	enter = function(s)
		d77p1level9.obj:add('armature');
		d77p1level9.obj:add('hammer');
		ways('d77p1level9'):add('d77p1_attic');
		me()._is_seen_stepan_run = true;
		s._mus = get_music();
		set_music('snd/act1.ogg');
	end,
	exit = function(s)
		set_music(s._mus);
	end,
	nomobil = true,
	pic = 'img/scn_stepan_run.png',
};

--ключи на 9 этаже на полу
d77p1l9keys = obj {
	nam = 'ключи',
	dsc = [[На полу лежат некоторые {ключи}.]],
	act = [[Похоже, это лежат некоторые ключи из связки Степана. Они
мне особо не нужны. Да и не до них.]],
};

--Ключи...
scn_keys_loss = room {
	nam = 'Ключи...',
	dsc = [[Когда я спускался у меня было много барахла. Поэтому связку ключей
Степана я не смог удержать...^^
Она упала, ударилась о перила и разлетелась. Времени собирать её у меня не было.
С минуты на минуту сюда могли прибежать остальные члены этой банды.^^
Но я решил, что Степана нужно запереть здесь... на чердаке...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd77p1level9')},
	enter = function()
		inv():del('stepan_keys');
		d77p1level9.obj:add('d77p1l9keys');
		me()._loss_stepan_keys = true;
	end,
	nomobil = true,
	pic = 'img/scn_keys_loss.png',
};

--Глазок
scn_peephole = room {
	nam = 'Глазок...',
	dsc = [[Когда я зашёл, я решил посмотреть в глазок. В результате я
провёл за глазком несколько часов...^^
Сначала я увидел, что лифт заработал... Но света в доме не было. Кто-то
на лифту поднялся на 9-й этаж и там застрял.^^
Затем пришёл напарник Степана. Я его видел несколько раз. Кажется, его
звали Иваном. Он пришёл, пытался их вытащить, они сорвались, упали.
Далее Иван бегал по этажам как сумасшедший. Он не мог выбраться с
подъезда.^^
Двери были закрыты... Но я всё понял. В подъезде был домофон. Вот он и
держал двери.^^
Затем Иван звонил во все звонки. Но ведь света не было...^^
Свет всё же появился через некоторое время. Я решил, что сегодня лучше
остаться в квартире Димы.]],
	obj = {vway('Продолжить', '{Продолжить}', 'dima_corridor')},
	enter = function()
		me()._watch_peephole = true;
		set_music('snd/act1.ogg');
	end,
	exit = function()
		set_music('snd/pod1.ogg');
		return [[Мне немного вздремнуть хочется.]];
	end,
	nomobil = true,
	pic = 'img/scn_peephole.png',
}

--Сон
sleep3n = room {
	nam = 'Диван',
	dsc = [[Я прилёг на диван Димы.]],
	obj = {
		vway('Спать', '{Спать}', 'scn_night'),
		vway('Встать', '^{Встать}', 'dima_hall')},
	nomobil = true,
	pic = 'img/sleep2.png',
};

--Ночь
scn_night = room {
	nam = 'Ночь...',
	dsc = [[Я проснулся ночью... Темно. Какие-то звуки.^^
Они пришли за мной! Я доигрался...^^
Стоп... Я отошёл ото сна. Вижу два огонька. Слышу чьё-то мяуканье...]],
	obj = {vway('Встать', '{Встать}', 'dima_hall')},
	enter = function()
		set_music('snd/act1.ogg')
		me()._is_night = true;
		stool.obj:del('cat_armen');
		cat_toilet._full = true; --куча
	end,
	exit = function()
		lifeon('cat_armen_live');
		set_music('snd/pod1.ogg');
	end,
	nomobil = true,
	pic = 'img/night.png',
}

--кот Армен встал
cat_armen_live = obj {
	nam = 'кот Армен',
	dsc = [[Передо мной лащится и мяукает {кот Армен}.]],
	act = function()
		local cat_look = {
[[Интересно, он арбузы и вино любит? Или шаурму? О! Знаю! Хачапури!]],
[[Слюшай, Армен, чего надо, а?]],
[[Ара, чего разорался, а?]],
[[Армен не грузын, Армен армянын!]],};
		set_sound('snd/myau.ogg');
		return (cat_look[rnd(#cat_look)]);
	end,
	life = function(s)
		if not seen(s) and deref(here()) ~= 'mobil_tel_in' then
			move(s, here(), s.__where);
			s.__where = pl.where;
			set_sound('snd/myau.ogg');
		end
	end,
};

--кот Армен ест
cat_armen_eat = obj {
	nam = 'кот Армен',
	dsc = [[{Кот Армен} ест из миски.]],
	act = function()
		set_sound('snd/nyam.ogg');
		return [[Армен ест. Он есть хотел.]];
	end
};

--ванна
bath = obj {
	nam = 'ванна',
	dsc = [[Слева стоит {ванна}.]],
	act = [[Белая ванна. Она пуста.]],
};

--раковина
toilet_sink = obj {
	nam = 'раковина',
	dsc = [[Передо мной {раковина}.]],
	act = [[Белая раковина. Из фарфора.]],
};

--бачок
cistern = obj {
	nam = 'бачок',
	dsc = [[Над унитазом {бачок}.]],
	act = [[Пластмассовый бачок. Белый, как и вся сантехника здесь.]],
};

--унитаз
pan = obj {
	nam = 'унитаз',
	dsc = [[Справа расположен {унитаз}.]],
	act = [[Унитаз белый. Из фарфора.]],
	obj = {'cistern'},
};

--Санузел
dima_toilet = room {
	nam = function(s)
		pr 'Санузел';
		if here() == s then
			pr ' (Квартира Димы)';
		end
	end,
	dsc = [[Я нахожусь в туалете, совмещённом с ванной. Он совсем не
похож на тот, из игры для INSTEAD'а. По крайней мере, он попроще, да
и поменьше.]],
	obj = {'bath', 'toilet_sink', 'pan'},
	way = {'dima_corridor'},
	pic = 'img/dima_toilet.png',
};
