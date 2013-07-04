me()._is_morning2 = false; --новое утро
me()._is_seen_labelvved = false; --видел надпись Введение
me()._is_seen_human2 = false; --видел ли человека 2-й раз
me()._is_seen_gl12 = false; --видел ли бумаги глав 1, 2
me()._is_cat_discard = false; --отказался ли ухаживать за котом (сначала)
me()._is_cat_agree = false; --согласился ли ухаживать за котом
me()._have_key_771_31 = false; --есть ли ключи от 77-1, 31
me()._is_read_gl1 = false; --читал ли главу 1
me()._is_read_gl2 = false; --читал ли главу 2
me()._is_seen_79_band = false; --видел ли всю банду в д.79

morning2 = room {
	nam = 'Утро...',
	dsc = [[Я проснулся снова очень рано. На часах было 4 часа утра...^^
Я вспомнил разговор Степана. Чёрт, а если тут серьёзное преступление?
Если тут убийство? Но в милицию я не собирался обращаться.^^
Нужно проверить, а нет ли надписи в том подъезде... 79-й дом, 2-й...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd73level2')},
	enter = function()
		me()._is_morning2 = true;
		objs('d79p2level9'):add('label_intro', 2);

		set_music('snd/yard1.ogg');
	end,
	exit = music('snd/pod1.ogg'),
	nomobil = true,
	pic = 'img/morning.png;img/morning2.png@86,31',
};

--Диалог с жильцом 79-2
dphone792_dlg = dlg {
	nam = 'Диалог с жильцом по домофону',
	dsc = [[Кажется, я дозвонился!
^^— Алё... Руслан, ты?]],
	obj = {
	[1] = phr('Нет. Это не Руслан, но мне нужно войти...', 'Отстань!', [[return back();]]),
	[2] = phr('Я!', 'Заходи.', [[return walk('d79p2level1');]]),
	},
	exit = function()
		pon(1);
		pon(2);
	end,
	pic = 'img/dphone.png',
};

--79-2------------------------------------------------------------------
--кнопки
d79p2l1 = obj {
	nam = '1',
	dsc = '{1},',
	act = function()
		return walk('d79p2level1');
	end,
};

d79p2l2 = obj {
	nam = '2',
	dsc = '{2},',
	act = function()
		return walk('d79p2level2');
	end,
};

d79p2l3 = obj {
	nam = '3',
	dsc = '{3},',
	act = function()
		return walk('d79p2level3');
	end,
};

d79p2l4 = obj {
	nam = '4',
	dsc = '{4},',
	act = function()
		return walk('d79p2level4');
	end,
};

d79p2l5 = obj {
	nam = '5',
	dsc = '{5},',
	act = function()
		return walk('d79p2level5');
	end,
};

d79p2l6 = obj {
	nam = '6',
	dsc = '{6},',
	act = function()
		return walk('d79p2level6');
	end,
};

d79p2l7 = obj {
	nam = '7',
	dsc = '{7},',
	act = function()
		return walk('d79p2level7');
	end,
};

d79p2l8 = obj {
	nam = '8',
	dsc = '{8},',
	act = function()
		return walk('d79p2level8');
	end,
};

d79p2l9 = obj {
	nam = '9',
	dsc = '{9},',
	act = function()
		return walk('d79p2level9');
	end,
};

d79p2stop = obj {
	nam = 'стоп',
	dsc = '{Стоп},',
	act = 'Никакого эффекта.'
};

d79p2call_disp = obj {
	nam = 'вызов',
	dsc = '{Вызов} диспетчера.',
	act = 'Никакого эффекта.',
};

--панель кнопок в лифте
d79p2elevator_panel = obj {
	nam = 'панель',
	dsc = 'Здесь расположена {панель} с кнопками:',
	act = 'Грязная, старая панель с кнопками.',
	obj = {'d79p2l1', 'd79p2l2', 'd79p2l3', 'd79p2l4', 'd79p2l5', 'd79p2l6', 'd79p2l7', 'd79p2l8', 'd79p2l9', 'd79p2stop', 'd79p2call_disp'},
};

--Лифт
d79p2elevator = room {
	nam = lev_title('Лифт'),
	dsc = 'Я в лифте.',
	obj = {'d79p2elevator_panel'},
	exit = function()
		set_sound('snd/elevator_close.ogg');
	end,
	pic = 'img/elevator.png',
};

--1-й этаж
d79p2level1 = room {
	nam = lev_title('Этаж 1'),
	dsc = [[Я нахожусь на этаже 1.]],
	way = {'d79', 'd79p2level12'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_basement'},
	enter = function(s, f)
		if f == 'd79p2door' or f == 'dphone792_dlg' then
			me()._dom = 79;
			me()._pod = 2;
			set_music('snd/pod1.ogg');
			return 'Дверь открылась, и я зашёл в подъезд.';
		end
	end,
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/level1.png@25,16;img/elevator_key1.png@195,109';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--1-2 этаж
d79p2level12 = room {
	nam = lev_title('Площадка между этажами 1-2'),
	dsc = [[Я нахожусь на площадке между этажами 1-2.]],
	way = {'d79p2level1', 'd79p2level2'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr179.png@219,114',
};

--2-й этаж
d79p2level2 = room {
	nam = lev_title('Этаж 2'),
	dsc = [[Я нахожусь на этаже 2.]],
	way = {'d79p2level12', 'd79p2level23'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/gr02.png@312,15';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--2-3 этаж
d79p2level23 = room {
	nam = lev_title('Площадка между этажами 2-3'),
	dsc = [[Я нахожусь на площадке между этажами 2-3.]],
	way = {'d79p2level2', 'd79p2level3'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr279.png@219,114;img/gr01.png@128,46',
};

--3 этаж
d79p2level3 = room {
	nam = lev_title('Этаж 3'),
	dsc = [[Я нахожусь на этаже 3.]],
	way = {'d79p2level23', 'd79p2level34'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/elevator_key3.png@197,113;img/gr03.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--3-4 этаж
d79p2level34 = room {
	nam = lev_title('Площадка между этажами 3-4'),
	dsc = [[Я нахожусь на площадке между этажами 3-4.]],
	way = {'d79p2level3', 'd79p2level4'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr379.png@219,114',
};

--4 этаж
d79p2level4 = room {
	nam = lev_title('Этаж 4'),
	dsc = [[Я нахожусь на этаже 4.]],
	way = {'d79p2level34', 'd79p2level45'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/gr04.png@312,45';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--4-5 этаж
d79p2level45 = room {
	nam = lev_title('Площадка между этажами 4-5'),
	dsc = [[Я нахожусь на площадке между этажами 4-5.]],
	obj = {'chute2'},
	way = {'d79p2level4', 'd79p2level5'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr479.png@219,114',
};

--5 этаж
d79p2level5 = room {
	nam = lev_title('Этаж 5'),
	dsc = [[Я нахожусь на этаже 5.]],
	way = {'d79p2level45', 'd79p2level56'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/elevator_key5.png@195,111';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--5-6 этаж
d79p2level56 = room {
	nam = lev_title('Площадка между этажами 5-6'),
	dsc = [[Я нахожусь на площадке между этажами 5-6.]],
	way = {'d79p2level5', 'd79p2level6'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr579.png@219,114',
};

--6 этаж
d79p2level6 = room {
	nam = lev_title('Этаж 6'),
	dsc = [[Я нахожусь на этаже 6.]],
	way = {'d79p2level56', 'd79p2level67'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/gr02.png@318,27';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--6-7 этаж
d79p2level67 = room {
	nam = lev_title('Площадка между этажами 6-7'),
	dsc = [[Я нахожусь на площадке между этажами 6-7.]],
	way = {'d79p2level6', 'd79p2level7'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr679.png@219,114',
};

--7 этаж
d79p2level7 = room {
	nam = lev_title('Этаж 7'),
	dsc = [[Я нахожусь на этаже 7.]],
	way = {'d79p2level67', 'd79p2level78'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/elevator_key7.png@196,114;img/gr01.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--7-8 этаж
d79p2level78 = room {
	nam = lev_title('Площадка между этажами 7-8'),
	dsc = [[Я нахожусь на площадке между этажами 7-8.]],
	way = {'d79p2level7', 'd79p2level8'},
	obj = {'chute1'},
	enter = function()
		if me()._is_seen_labelvved and not me()._is_seen_human2 then
			return [[Кажется, я слышу приближающиеся снизу шаги. Нужно
спрятаться.]];
		end
	end,
	exit = function(s, t)
		if me()._is_seen_labelvved and not me()._is_seen_human2 then
			if t == 'd79p2level7' then
				return [[Снизу кто-то идёт. Нужно срочно
спрятаться.]], false;
			elseif t == 'd79p2level8' then
				return [[Даже если пойти вверх, меня могут заметить.
Нужно срочно спрятаться.]], false;
			end
		elseif me()._is_seen_labelvved and t == 'd79p2level8' then
			return [[Лучше не идти вверх. Туда пошёл тот человек с
четырнадцатиэтажки.]], false;
		end
	end,
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr779.png@219,114',
};

--8 этаж
d79p2level8 = room {
	nam = lev_title('Этаж 8'),
	dsc = [[Я нахожусь на этаже 8.]],
	way = {'d79p2level78', 'd79p2level89'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level.png;img/elevator_key3.png@197,113;img/gr03.png@312,45';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--8-9 этаж
d79p2level89 = room {
	nam = lev_title('Площадка между этажами 8-9'),
	dsc = [[Я нахожусь на площадке между этажами 8-9.]],
	way = {'d79p2level8', 'd79p2level9'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr879.png@219,114',
};

--надпись Введение
label_intro = obj {
	nam = 'надпись',
	dsc = [[На дверях лифта есть {надпись}.]],
	act = function()
		if not me()._is_seen_labelvved then
			me()._is_seen_labelvved = true;
			return walk('scn_vved');
		else
			return 'Надпись: «Введение. Смерть манекена».';
		end
	end,
};

--9 этаж
d79p2level9 = room {
	nam = lev_title('Этаж 9'),
	dsc = [[Я нахожусь на этаже 9.]],
	way = {'d79p2level89'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_attic'},
	exit = function()
		me()._elevator_key_pressed = false;
		enable('label_intro');
	end,
	pic = function()
		pr 'img/level.png;img/level9.png@1,15;';
		if me()._elevator_key_pressed then
			pr 'img/elevator_open.png@217,58;';
		end
		if seen('label_intro') then
			pr 'img/introlabel.png@221,81';
		end
	end,
};
--к79-2-----------------------------------------------------------------

--Введение. Смерть манекена...
scn_vved = room {
	nam = 'Введение. Смерть манекена...',
	dsc = [[Надпись: «Введение. Смерть манекена». Это реально...^^
Вдруг лампочка, которая горела на этаже погасла. Я попробовал вызвать
лифт, но не увидел никакой реакции. В доме выключили свет?^^
Я представил, что те, кто затеял эту «повесть» про лифт, меня вычислили.
У меня возник некий испуг... Ведь, может, так и есть.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd79p2level9')},
	enter = music('snd/act2.ogg'),
	nomobil = true,
	pic = 'img/scn_vved.png',
};

--замок (дверь кв.4, д.111)
d111f4_lock = obj {
	nam = 'замок',
	dsc = [[На двери навесной {замок}.]],
	act = [[Замок крепкий, держится на железных петлях. Просто руками
его не открыть.]],
};

--замок (сорванный)
lock1 = obj {
	nam = function(s)
		if s._opened then
			pr(img('img/icn_lock1_opened.png'));
		else
			pr(img('img/icn_lock1.png'));
		end
		pr 'замок';
	end,
	dsc = [[На полу лежит сорванный {замок}.]],
	tak = [[Я взял замок вместе с дверными петлями.]],
	inv = function(s)
		if s._opened then
			return [[Навесной замок. Открыт.]];
		else
			return [[Навесной закрытый замок. На нём есть петли с двери.]];
		end
	end,
	use = function(s, w)
		if w == 'door_flat4' then
			if not s._opened then
				return [[Место для петель слишком раздолбано. Если даже
удастся их прибить, всё равно будет заметно, что их снимали.]];
			end
		elseif w == 'd77p1_hatch_attic' then
			if stepan_attic._out and not me()._is_stepan_close then
				if s._opened then
					inv():del(s);
					ways():del('d77p1_attic');
					d77p1_hatch_attic.obj:add('hatch_lock');
					return [[На люке есть петли. Я подцепил замок на них. Но
замок ещё открыт.]];
				else
					return [[Замок закрыт! На замке петли! Не получится.]];
				end
			else
				return [[Закрыть им? Может, потом...]];
			end
		end
	end,
	_opened = false,
};

--петли от замка
hinge = obj {
	nam = img('img/icn_hinge.png')..'дверные петли',
	inv = [[Дверные петли из четырнадцатиэтажки.]],
	use = function(s, w)
		if w == 'door_flat4' then
			return [[Место для петель слишком раздолбано. Если даже
удастся их прибить, всё равно будет заметно, что их снимали.]];
		end
	end,
};

--ключ от навесного замка
lock_key = obj {
	nam = img('img/icn_lock_key.png')..'ключ от замка',
	dsc = [[Есть один {ключ} без замка.]],
	tak = [[Я взял ключ.]],
	inv = [[Ключ от замка.]],
	use = function(s, w)
		if w == 'lock1' then
			if lock1._opened then
				return [[Я уже открыл замок. А закрывать пока не нужно.]];
			else
				lock1._opened = true;
				inv():add('hinge');
				return [[Ключ подошёл. Я открыл замок и снял петли.]];
			end
		elseif w == 'hatch_lock' then
			if hatch_lock._closed then
				return [[Замок уже закрыт. Открывать я его не собираюсь.
Пусть Степан посидит взаперти.]];
			else
				hatch_lock._closed = true;
				me()._is_stepan_close = true;
				return [[Я закрыл замок! Теперь Степан взаперти. Пусть посидит.
Сейчас как раз время спрятаться.]];
			end
		end
	end,
};

--Диалог по домофону
d79p1dphone_dlg = dlg {
	nam = 'Диалог с жильцом по домофону',
	dsc = [[Кажется, ответили.^^
— Алло...]],
	obj = {
	[1] = phr('Здравствуйте! Пустите меня, пожалуйста. У меня тут... друг живёт!', 'Вот другу и позвони...', [[return back();]]),
	[2] = phr('Пустите меня. Я из милиции.', 'Да хоть Папа Римский...', [[return back();]]),
	[3] = phr('Пустите меня. Я попрошайка!', 'Иди в другой подъезд просить...', [[return back();]]),
	[4] = phr('Привет. Я твой одноклассник!', 'Я не учился в школе...', [[return back();]]),
	},
	exit = function(s)
		s:pon(1);
		s:pon(2);
		s:pon(3);
		s:pon(4);
	end,
	pic = 'img/dphone.png',
};

--Вторая встреча
scn_human2 = room {
	nam = 'Вторая встреча...',
	dsc = [[Я спрятался за мусоропроводную трубу. И, видимо, не зря...^^
По лестнице поднимался тот человек, которого я видел в четырнадцатиэтажке.
Надпись на дверях лифта сделал вчера Степан. Воплощать «Введение»
в реальность ещё рано. Для чего он здесь?..^^
Наверное, подготовка уже началась. Это они отключили свет.^^
Если этот монстр здесь, то в четырнадцатижтажке его точно нет...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd79p2level78')},
	enter = function()
		me()._is_seen_human2 = true;
		door_flat4.obj:add('d111f4_lock');
		--set_music('snd/act2.ogg');
	end,
	nomobil = true,
	pic = 'img/scn_human2.png',
};

--Глава 1 и Глава 2
scn_gl12 = room {
	nam = '«Глава 1» и «Глава 2»',
	dsc = [[Вот это находка! Это не просто бумаги!^^
Это «Глава 1» и «Глава 2» — продолжение
повести! Кажется, я далеко зашёл. Лучше их не забирать отсюда, а то
поднимется очень большая паника. Но нужно как-то их запечатлить и
бежать отсюда побыстрее.]],
	obj = {vway('Продолжить', '{Продолжить}', 'flat4')},
	enter = function()
		me()._is_seen_gl12 = true;
		set_music('snd/act2.ogg');
	end,
	nomobil = true,
	pic = 'img/scn_gl12.png',
};

--записка гл.1
note_gl1 = obj {
	nam = img('img/icn_note_gl1.png')..'«Глава 1»',
	inv = function()
		me()._is_read_gl1 = true;
		return [[«Глава 1. Смерть Петра и Олега^^
Пётр и Олег входят в лифт. Поднимаются на 9-й этаж. Застряют. Их
освобождают лифтёры. Но лифт обрывается. Они не успевают выйти, падают
вниз. Внизу из встречает «Лифтёр». Он их убивает.»^^
А, я, кажется всё понял. «Лифтёр» — это тот монстр из четырнадцатиэтажки.^^
Внизу дописано шариковой ручкой: «77-1».]];
	end,
};

--записка гл.2
note_gl2 = obj {
	nam = img('img/icn_note_gl2.png')..'«Глава 2»',
	inv = function()
		me()._is_read_gl2 = true;
		return [[«Глава 2. Смерть Елены.^^
Елена заходит в лифт. Едет на 9 этаж. Обрывается. Внизу её убивает
«Лифтёр».»^^
Не очень разнообразно. Но, Елена. А вдруг это та самая Лена? Моя Лена.
Хотя, она и не совсем моя.]];
	end,
};

--звонок Димы
telephone_dima = obj {
	nam = 'звонок',
	dsc = [[Кто-то мне звонит на {мобильный телефон}.]],
	life = function(s)
		if not seen(s) then
			movef(s, here(), s.__where);
			s.__where = pl.where;
			set_sound('snd/telephone.ogg');
		end
	end,
	act = function(s)
		lifeoff(s);
		objs():del(s);
		return walk('mob_dima_dlg');
	end,
};

--Звонок Димы
mob_dima_dlg = dlg {
	nam = 'Звонок Димы',
	dsc = [[Это звонит Дима — мой бывший одноклассник, у которого я
недавно был на дне рождения. Я взял трубку.]],
	obj = {
	[1] = phr('Алё.', 'Привет, Макс!', [[pon(2);pon(3);]]),
	[2] = _phr('Как дела?', 'Та нормально всё. Слушай, я попросить хотел...', [[poff(3);pon(4);]]),
	[3] = _phr('По какому поводу звонишь?', 'Та вот попросить хотел...', [[poff(2);pon(4);]]),
	[4] = _phr('Продолжай.', 'В общем я уезжаю отдыхать в пансионат. Вот путёвки выпросил. Но, тут такое дело... Родители тоже едут. А кота Армена некуда деть.', [[pon(5);]]),
	[5] = _phr('Чё?! Твоего кота зовут Армен?!', 'Да. Ты не знал? Вроде часто видел его.', [[pon(6);pon(7);]]),
	[6] = _phr('Да я не помешан на котах, как некоторые.', 'Некоторые их даже целуют... Ну, то совсем помешанные. Как так только можно...'),
	[7] = _phr('Ладно, я должен его себе забрать?', 'Нет. Лучше возьми у меня ключи от квартиры. И просто заходи иногда его проведывать. Кормить там...', [[poff(6);pon(8);]]),
	[8] = _phr('Хм...', 'Подходи к подъезду. Помнишь, где я живу? Дом 77, подъезд 1...', [[pon(9);pon(10);]]),
	[9] = _phr('Думаю, не получится. Я тут занят...', 'Жалко. Если передумаешь, позвони.', [[poff(10);me()._is_cat_discard=true;]]),
	[10] = _phr('Подойду!', 'Спасибо! Сейчас спущусь и буду тебя ждать!', [[poff(9);me()._is_cat_agree=true;]]),
	},
	exit = function()
		memo._is_memo2 = true; --адрес Димы в заметках
	end,
	pic = 'img/mob_dlg.png',
};

--Звонок Диме (чтобы согласиться)
mob_dima_agree_dlg = dlg {
	nam = 'Звонок Диме',
	dsc = [[Я позвонил Диме... Он взял трубку и сказал:^^
— Алё.]],
	obj = {
	[1] = phr('Я согласен поухаживать за твоим котом!', 'Спасибо! А то я и не знал кого ещё попросить. Подходи к подъезду 1 дома 77.', [[me()._is_cat_agree=true;]]),
	},
	pic = 'img/mob_dlg.png',
};

--дверь в перегородку кв. Димы
door_dima = obj {
	nam = 'дверь',
	dsc = [[Слева находятся {дверь} в перегородку Димы.]],
	act = [[Нужны ключи чтобы открыть.]],
};

--ключи от 77_31
keys77_31 = obj {
	nam = img('img/icn_keys77_31.png')..'ключи Димы',
	inv = [[Связка ключей Димы. Содержит ключи от подъезда и от
квартиры (д.77, кв.31).]],
	use = function(s, w)
		if w == 'd77p1lock' then
			return walk('d77p1level1');
		elseif w == 'door_dima' then
			if me()._is_morning3 then
				if stepan_attic._out then
					if me()._is_stepan_close then
						return walk('scn_peephole');
					else
						return [[Не время прятаться! Нужно закрыть Степана на чердаке!]];
					end
				else
					return walk('dima_corridor');
				end
			else
				return [[Нет. Сегодня Дима ещё дома. Завтра надо будет зайти проведать его
кота.]];
			end
		else
			return [[Не нужно сувать чужие ключи куда попало.]];
		end
	end,
};

--Дима даёт ключ
scn_dimakeygive = room {
	nam = 'Встреча с Димой',
	dsc = [[Я подождал немного на крыльце. Через несколько минут вышел
Дима.^^
Мы немного поговорили о жизни. Он рассказал, что путёвку было достать не
просто.^^
После он дал ключи. Завтра с утра уезжает. В его комнату и спальню
просил не ходить. Только в зал и кухню.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd77p1door')},
	exit = function()
		inv():add('keys77_31');
		d77p1level8.obj:add('door_dima');
		me()._have_key_771_31 = true;
	end,
	nomobil = true,
	pic = 'img/dima_dlg.png',
};

--Банда
scn_d79band = room {
	nam = 'Банда в сборе',
	dsc = [[Они выходили. Это банда. Их было трое: Степан, тот монстр,
и ещё один. Мне показалось, что именно он главный.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd79')},
	enter = function(s)
		s._mus = get_music();
		set_music('snd/act2.ogg');
	end,
	exit = function(s)
		me()._is_seen_79_band = true;
		set_music(s._mus);
		return [[Кажется, уже пришло время поспать.]];
	end,
	nomobil = true,
	pic = 'img/scn_d79band.png',
};

--Сон
sleep23 = room {
	nam = 'Диван',
	dsc = [[Я прилёг на диван.]],
	obj = {
		vway('Спать', '{Спать}', 'morning3'),
		vway('Встать', '^{Встать}', 'my_apartment')},
	nomobil = true,
	pic = 'img/sleep.png',
};

--Разговор с Леной по моб. 1
lena1_dlg = dlg {
	nam = 'Звонок Лене',
	dsc = [[Я позвонил Лене. Она подняла трубку и сказала «Алё».]],
	obj = {
	[1] = phr('Привет. Это я, Максим.', 'Привет, Макс! Как ты?', [[pon(2);pon(8);pon(9);]]),
	[2] = _phr('Я нормально. А ты как?', 'Лучше всех. Как отдыхается?', [[pon(3);pon(4)]]),
	[3] = _phr('Отдыхается отлично!', 'Это хорошо...', [[poff(4);pon(6);]]),
	[4] = _phr('Отдыхается так себе. Одному скучно.', 'А как же друзья?', [[poff(3);pon(5)]]),
	[5] = _phr('Друзья заняты. У кого работа, у кого семья.', 'Хм. Мне на выходных тоже бывает скучно.', [[pon(6);]]),
	[6] = _phr('Можно будет как-нибудь встретится.', 'Обязательно. Завтра у меня выходной. Позвони.', [[pon(7)]]),
	[7] = _phr('Хорошо.', 'Тогда, до завтра. Пока.', [[return back();]]),
	[8] = _phr('У тебя есть домашние животные?', 'Попугайчик.'),
	[9] = _phr('А ты любишь по деревьям лазить?', 'Я же не мальчишка.'),
	},
	exit = function()
		me()._lena_talk1 = true;
	end,
	pic = 'img/mob_dlg.png',
};

--Разговор с Леной по моб. 2
lena2_dlg = dlg {
	nam = 'Звонок Лене',
	dsc = function()
		p [[Я позвонил Лене.]];
		if me()._is_seen_gl12 then
			p [[Она]];
		else
			p [[Ещё слишком рано, но она]];
		end
		p [[подняла трубку и радостным голосом сказала «Алё».]];
	end,
	obj = {
	[1] = phr('Привет.', 'Привет, Макс! Как ты?', [[pon(2);]]),
	[2] = _phr('Я нормально. А ты как?', 'Отлично. Готов к встрече?', [[pon(3);]]),
	[3] = _phr('Да! Конечно.', 'Тогда подходи сейчас к моему дому. Я живу в 83-м доме, во 2-м подъезде. Подойдёшь?', [[pon(4);]]),
	[4] = _phr('Да.', 'До встречи, Максим.'),
	},
	exit = function()
		me()._lena_talk2 = true;
		memo._is_memo3 = true;
	end,
	pic = 'img/mob_dlg.png',
};

--Разговор с Леной по моб. 2 плохой
lena2b_dlg = dlg {
	nam = 'Звонок Лене',
	dsc = [[Я позвонил Лене. Он подняла трубку и сказала «Алё».]],
	obj = {
	[1] = phr('Привет. Это я, Максим.', 'А. Привет. Как дела?', [[pon(2);pon(3);pon(4);]]),
	[2] = _phr('Я нормально. А ты как?', 'Лучше всех. Слушай, я тут немного занята. Извини. Пока.', [[return back();]]),
	[3] = _phr('У тебя есть домашние животные?', 'Попугай.'),
	[4] = _phr('А ты любишь по деревьям лазить?', 'Я же не ребёнок.'),
	},
	exit = function()
		me()._lena_talk2b = true;
	end,
	pic = 'img/mob_dlg.png',
};

--Встреча с Леной
scn_lenameet = room {
	nam = 'Встреча с Леной',
	dsc = [[Я её встретил у подъезда...^^
Мы погуляли немного. Пообщались. Время пролетело незаметно. Мне не
хотелось её отпускать...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd838587')},
	enter = function()
		--set_music('snd/end2.ogg');
		me()._lena_meet = true;
	end,
	nomobil = true,
	pic = 'img/lena_dlg.png',
};

--Разговор с Леной по моб. 3
lena3_dlg = dlg {
	nam = 'Звонок Лене',
	dsc = [[Я позвонил Лене. Он подняла трубку и радостным голосом
сказала «Алё».]],
	obj = {
	[1] = phr('Привет.', 'Привет! Ну, как ты?', [[pon(2);]]),
	[2] = _phr('Да отлично. А ты как?', 'Так же. Мы вчера хорошо провели время.', [[pon(3);]]),
	[3] = _phr('Да, это точно. Может, повторим как-нибудь?', 'Да. Как будут выходные.', [[pon(4);]]),
	[4] = _phr('Буду ждать.', 'Я тоже. Созвонимся. Пока.'),
	},
	exit = function()
		me()._lena_talk3 = true;
	end,
	pic = 'img/mob_dlg.png',
};

--Разговор с Леной по моб. 3 плохой
lena3b_dlg = dlg {
	nam = 'Звонок Лене',
	dsc = [[Я позвонил Лене. Он подняла трубку и сказала «Алё».]],
	obj = {
	[1] = phr('Привет.', 'Почему ты вчера не подошёл ко моему подъезду?', [[pon(2);]]),
	[2] = _phr('Ну, я... это... Извини.', 'Ладно. Я занята. Пока.'),
	},
	exit = function()
		me()._lena_talk3b = true;
	end,
	pic = 'img/mob_dlg.png',
};
