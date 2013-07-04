LENA1_DSC = [[А с Леной мы виделись часто. Мы уже почти... как это?
Начали встречаться.]];
LENA2_DSC = [[Лене я почти не звонил. Я потерял с ней связь. А почему?
Она же мне так нравилась...]];

me()._is_day_m = false; --наступил ли заключительный день
--разговоры с Леной и встреча
me()._lena_talk1 = false;
me()._lena_meet = false;
me()._lena_talk2 = false;
me()._lena_talk2b = false;
me()._lena_talk3 = false;
me()._lena_talk3b = false;
me()._lena_call = false; --звонила ли Лена
me()._is_read_gl2true = false; --читал ли главу 2 наст.
me()._peace = false; --все помирились
me()._key_num = 0; --номер верного ключа
me()._garage_num = 0; --номер верного гаража

--Шли дни
sleepnm = room {
	nam = 'Шли дни...',
	dsc = function()
		p [[Вроде бы всё шло нормально. Я не слышал об этой банде
лифто-маньяков. Наверное, я их здорово напугал.^^
Я каждый день приходил в квартиру Димы, следил за его котом Арменом.^^]];
		if me()._lena_talk3 then
			p(LENA1_DSC);
		else
			p(LENA2_DSC);
		end
	end,
	obj = {vway('Продолжить', '{Продолжить}', 'scn_stepan_new')},
	enter = function()
		set_music('snd/yard1.ogg');
		inv():zap();
	end,
	nomobil = true,
	pic = 'img/sleepnm.png',
};

--Снова Степан
scn_stepan_new = room {
	nam = 'Снова Степан...',
	dsc = [[Как-то я выходил из своего подъезда. Я увидел Степана. У
него в руке был маркер. Он его вкладывал в карман.^^
Значит, они продолжили своё дело...^^
Я поздоровался со Степаном. Он, наверное, только что сделал надпись.
Стоп. Вторая глава — это «Смерть Елены». Если это та самая Лена, то...^^
Нужно это остановить! Степан шёл от 71-го дома. Значит, глава 2 будет
либо в 1-м, либо во 2-м подъезде 71-го дома.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd73')},
	enter = function()
		set_music('snd/act3.ogg');
		inv():add('home_key');
		inv():add('mobil_tel');
		inv():add('note_intro');
		inv():add('note_gl1');
		inv():add('note_gl2');

		my_apartment.obj:add('home_tools');
		objs('d71p1level9'):add('label_gl2_fake', 2);

		me()._is_post = true;
		me()._post = 'newspaper78';
		
		me()._is_day_m = true;
	end,
	exit = music('snd/yard1.ogg'),
	nomobil = true,
	pic = 'img/scn_stepan_new.png',
};

--газета 78
newspaper78 = obj {
	nam = img('img/icn_newspaper78.png')..'газета (№78)',
	inv = function()
		return [[«Вечерний обзор», №78.^^
Тут пишут о сумасшедших лифтёрах. Это о Степане и Иване. Они вроде бы
что-то видели. Убийство. Но их признали сумасшедшими. Не официально,
конечно.]];
	end,
};

--отмычка
fake_key = obj {
	nam = img('img/icn_fake_key.png')..'отмычка',
	inv = [[Отмычка, пригодная для открытия подъездных замков с
ключом.]],
};

--инструкция по взлому домофона
instruction1 = obj {
	nam = img('img/icn_instruction1.png')..'инструкция (взлом домофона)',
	inv = [[Это подробная инструкция от какого-то хакера-малолетки:
	«Привет! Пишу инструкцию, проверенную на своей практике! Буду писать
о каждом известном мне способе. Начинаем.^^
1. Замкнуть цепь. Домофон работает от электричества. Дверь закрыта
благодаря электромагниту. Стоит прекратить подачу электричества, и дверь
откроется. Для этого достаточно найти лампочку на крыльце подъезда,
выкрутить её, замкнуть чем-нибудь контакты патрона.^^
2. Код. В домофонах есть своё меню, попасть в которое можно набирая
специальный код. Оно то и откроет вам дверь!
Но, также, для доступа вам необходимо знать
четырёхзначный пароль (обычно). Не расстраивайтесь, ведь пароль
оставляют часто тот, который по-умолчанию, либо меняют на простой.
Для домофонов марки Spen необходимо набрать *1623*XXXX#. Для
Lakr — *154#XXXX#. XXXX — это пароль. Попробуйте пароли вроде 1111,
2222, 9999. Есть ещё домофоны Lendas, однако у нас в районе я
такие не встречал, да и слышно о них мало.^^
3. Батарейка. Я слышал, что можно открыть домофон поднеся батарейку.
Однако, я не знаю, где её взять. Дефицит.»^^
Пацан явно дальше своего двора не ходил. Надеюсь, его инструкция
поможет.]],
};

--инструкция по изготовлению отмычки
instruction2 = obj {
	nam = img('img/icn_instruction2.png')..'инструкция (отмычка)',
	inv = function(s)
		if not s._is_read then
			s._is_read = true;
		end
		return [[Инструкция по изготовлению отмычки к подъезду:^^
«Замки к дверям подъездов просты. Они гораздо проще тех, которые
ставят в квартиры.^^
Весь секрет ключа заключается в прорезях. Благодаря проделанным
в нужном места прорезям ключу удаётся войти в отверстие замка. Но
ведь можно сделать такой ключ, которому ничего не будет мешать
пролазить.^^
Изготовить отмычку можно с помощью простых инструментов и жёсткой
проволоки (или прута). Необходимо лишь загнуть кончик проволоки под
прямым углом. Длина кончика должна быть милиметров 8-10. Сам ключ
должен быть длиной сантиметров 13. Можно также на конце отмычки сделать
петельку чтобы её куда-нибудь вешать.»]];
	end,
	use = function(s, w)
		if w == 'home_tools' then
			if s._is_read then
				inv():add('fake_key');
				return [[Я нашёл жёсткую проволоку и плоскогубцы.
Проволоку согнул как написано в инструкции. Получилась отмычка для
замков в подъездах.]];
			else
				return [[Хм... Надо бы почитать.]];
			end
		end
	end,
	_is_read = false,
};

--инструменты
home_tools = obj {
	nam = 'инструменты',
	dsc = [[На полу стоит {ящик с инструментами}.]],
	act = [[В нём собраны различные инструменты: молоток, напильник,
плоскогубцы, кусачки, проволока, изолента...]],
};

--домофон двери подъезда 71-1
d71p1lock = obj {
	nam = 'домофон',
	dsc = 'Дверь закрыта. На ней {домофон}. Нужен ключ. Либо можно кому-то позвонить.',
	act = function(s, w)
		if w == nil then
			p [[Это домофон. Марка «Lakr».]];
			if me()._is_day_m and not have('instruction1') then
				p [[Надо бы где-то узнать о взломе домофонов.]];
			end
		else
			if string.len(dphone_string._dphone_str) < 12 then
				if w == 13 then
					if me()._is_day_m and dphone_string._dphone_str == '*154#2222#' then
						return walk('d71p1level1');
					elseif string.len(dphone_string._dphone_str) == 2 then
						return [[Не отвечают.]];
					else
						return [[Ошибка.]];
					end
				elseif w == 14 then
					dphone_string._dphone_str = '';
					return [[Сброс.]];
				else
					dphone_string._dphone_str =
						dphone_string._dphone_str..dphone_kd[w];
					return 'Клавиша «'..dphone_kd[w]..'».';
				end
			else
				dphone_string._dphone_str = '';
				return [[Поле ввода очистилось. Похоже, я ввёл
максимум символов.]];
			end
		end
	end,
	obj = {'dphone_string',
		vobj(1, dphone_kd[1], '^^Клавиши домофона: {'..dphone_kd[1]..'} '),
		vobj(2, dphone_kd[2], '{'..dphone_kd[2]..'} '),
		vobj(3, dphone_kd[3], '{'..dphone_kd[3]..'} '),
		vobj(4, dphone_kd[4], '{'..dphone_kd[4]..'} '),
		vobj(5, dphone_kd[5], '{'..dphone_kd[5]..'} '),
		vobj(6, dphone_kd[6], '{'..dphone_kd[6]..'} '),
		vobj(7, dphone_kd[7], '{'..dphone_kd[7]..'} '),
		vobj(8, dphone_kd[8], '{'..dphone_kd[8]..'} '),
		vobj(9, dphone_kd[9], '{'..dphone_kd[9]..'} '),
		vobj(10, dphone_kd[10], '{'..dphone_kd[10]..'} '),
		vobj(11, dphone_kd[11], '{'..dphone_kd[11]..'} '),
		vobj(12, dphone_kd[12], '{'..dphone_kd[12]..'} '),
		vobj(13, dphone_kd[13], '{'..dphone_kd[13]..'} '),
		vobj(14, dphone_kd[14], '{'..dphone_kd[14]..'}^^'),},
};

--Дверь 71-1
d71p1door = room {
	nam = 'Дверь (д.71, п.1)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d71p1lock'},
	way = {'d71'},
	exit = function()
		dphone_string._dphone_str = '';
	end,
	pic = 'img/d71p1door.png',
};

--замок двери подъезда 71-2
d71p2lock = obj {
	nam = 'замок',
	dsc = 'Дверь закрыта на {замок}. Нужен ключ.',
	act = function()
		p 'Нужен ключ. Конечно, можно подождать кого-то.';
		if me()._is_day_m and not have('instruction2') then
			p [[Но лучше узнать как сделать отмычку от подъезда.]];
		end
	end,
	used = function(s, w)
		if w == 'fake_key' then
			return walk('d71p2level1');
		elseif w == 'home_key' then
			return [[Эти ключи не подойдут.]];
		end
	end,
};

--Дверь 71-2
d71p2door = room {
	nam = 'Дверь (д.71, п.2)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d71p2lock'},
	way = {'d71'},
	pic = 'img/d71p2door.png',
};

--71-2------------------------------------------------------------------
--кнопки
d71p2l1 = obj {
	nam = '1',
	dsc = '{1},',
	act = function()
		return walk('d71p2level1');
	end,
};

d71p2l2 = obj {
	nam = '2',
	dsc = '{2},',
	act = function()
		return walk('d71p2level2');
	end,
};

d71p2l3 = obj {
	nam = '3',
	dsc = '{3},',
	act = function()
		return walk('d71p2level3');
	end,
};

d71p2l4 = obj {
	nam = '4',
	dsc = '{4},',
	act = function()
		return walk('d71p2level4');
	end,
};

d71p2l5 = obj {
	nam = '5',
	dsc = '{5},',
	act = function()
		return walk('d71p2level5');
	end,
};

d71p2l6 = obj {
	nam = '6',
	dsc = '{6},',
	act = function()
		return walk('d71p2level6');
	end,
};

d71p2l7 = obj {
	nam = '7',
	dsc = '{7},',
	act = function()
		return walk('d71p2level7');
	end,
};

d71p2l8 = obj {
	nam = '8',
	dsc = '{8},',
	act = function()
		return walk('d71p2level8');
	end,
};

d71p2l9 = obj {
	nam = '9',
	dsc = '{9},',
	act = function()
		return walk('d71p2level9');
	end,
};

d71p2stop = obj {
	nam = 'стоп',
	dsc = '{Стоп},',
	act = 'Никакого эффекта.'
};

d71p2call_disp = obj {
	nam = 'вызов',
	dsc = '{Вызов} диспетчера.',
	act = 'Никакого эффекта.',
};

--панель кнопок в лифте
d71p2elevator_panel = obj {
	nam = 'панель',
	dsc = 'Здесь расположена {панель} с кнопками:',
	act = 'Грязная, старая панель с кнопками.',
	obj = {'d71p2l1', 'd71p2l2', 'd71p2l3', 'd71p2l4', 'd71p2l5', 'd71p2l6', 'd71p2l7', 'd71p2l8', 'd71p2l9', 'd71p2stop', 'd71p2call_disp'},
};

--Лифт
d71p2elevator = room {
	nam = lev_title('Лифт'),
	dsc = 'Я в лифте.',
	obj = {'d71p2elevator_panel'},
	exit = function()
		set_sound('snd/elevator_close.ogg');
	end,
	pic = 'img/elevator.png',
};

--1-й этаж
d71p2level1 = room {
	nam = lev_title('Этаж 1'),
	dsc = [[Я нахожусь на этаже 1.]],
	way = {'d71', 'd71p2level12'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_basement'},
	enter = function(s, f)
		if f == 'd71p2door' then
			me()._dom = 71;
			me()._pod = 2;
			set_music('snd/pod1.ogg');
			return 'Дверь открылась, и я зашёл в подъезд.';
		end
	end,
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/level1.png@25,16;img/elevator_key1.png@195,109;img/gr09.png@24,40';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--1-2 этаж
d71p2level12 = room {
	nam = lev_title('Площадка между этажами 1-2'),
	dsc = [[Я нахожусь на площадке между этажами 1-2.]],
	way = {'d71p2level1', 'd71p2level2'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr171.png@219,114',
};

--2-й этаж
d71p2level2 = room {
	nam = lev_title('Этаж 2'),
	dsc = [[Я нахожусь на этаже 2.]],
	way = {'d71p2level12', 'd71p2level23'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/gr02.png@312,15';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--2-3 этаж
d71p2level23 = room {
	nam = lev_title('Площадка между этажами 2-3'),
	dsc = [[Я нахожусь на площадке между этажами 2-3.]],
	way = {'d71p2level2', 'd71p2level3'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr271.png@219,114;img/gr01.png@128,46',
};

--3 этаж
d71p2level3 = room {
	nam = lev_title('Этаж 3'),
	dsc = [[Я нахожусь на этаже 3.]],
	way = {'d71p2level23', 'd71p2level34'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key3.png@197,113;img/gr03.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--3-4 этаж
d71p2level34 = room {
	nam = lev_title('Площадка между этажами 3-4'),
	dsc = [[Я нахожусь на площадке между этажами 3-4.]],
	way = {'d71p2level3', 'd71p2level4'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr371.png@219,114',
};

--4 этаж
d71p2level4 = room {
	nam = lev_title('Этаж 4'),
	dsc = [[Я нахожусь на этаже 4.]],
	way = {'d71p2level34', 'd71p2level45'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/gr04.png@312,45';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--4-5 этаж
d71p2level45 = room {
	nam = lev_title('Площадка между этажами 4-5'),
	dsc = [[Я нахожусь на площадке между этажами 4-5.]],
	obj = {'chute2'},
	way = {'d71p2level4', 'd71p2level5'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr471.png@219,114',
};

--5 этаж
d71p2level5 = room {
	nam = lev_title('Этаж 5'),
	dsc = [[Я нахожусь на этаже 5.]],
	way = {'d71p2level45', 'd71p2level56'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key5.png@195,111';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--5-6 этаж
d71p2level56 = room {
	nam = lev_title('Площадка между этажами 5-6'),
	dsc = [[Я нахожусь на площадке между этажами 5-6.]],
	way = {'d71p2level5', 'd71p2level6'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr571.png@219,114',
};

--6 этаж
d71p2level6 = room {
	nam = lev_title('Этаж 6'),
	dsc = [[Я нахожусь на этаже 6.]],
	way = {'d71p2level56', 'd71p2level67'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/gr02.png@318,27';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--6-7 этаж
d71p2level67 = room {
	nam = lev_title('Площадка между этажами 6-7'),
	dsc = [[Я нахожусь на площадке между этажами 6-7.]],
	way = {'d71p2level6', 'd71p2level7'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr671.png@219,114',
};

--7 этаж
d71p2level7 = room {
	nam = lev_title('Этаж 7'),
	dsc = [[Я нахожусь на этаже 7.]],
	way = {'d71p2level67', 'd71p2level78'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key7.png@196,114;img/gr01.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--7-8 этаж
d71p2level78 = room {
	nam = lev_title('Площадка между этажами 7-8'),
	dsc = [[Я нахожусь на площадке между этажами 7-8.]],
	way = {'d71p2level7', 'd71p2level8'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr771.png@219,114',
};

--8 этаж
d71p2level8 = room {
	nam = lev_title('Этаж 8'),
	dsc = [[Я нахожусь на этаже 8.]],
	way = {'d71p2level78', 'd71p2level89'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key3.png@197,113;img/gr03.png@312,45';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--8-9 этаж
d71p2level89 = room {
	nam = lev_title('Площадка между этажами 8-9'),
	dsc = [[Я нахожусь на площадке между этажами 8-9.]],
	way = {'d71p2level8', 'd71p2level9'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr871.png@219,114',
};

--9 этаж
d71p2level9 = room {
	nam = lev_title('Этаж 9'),
	dsc = [[Я нахожусь на этаже 9.]],
	way = {'d71p2level89'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_attic'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	enter = function()
		return [[Здесь нет надписи.]];
	end,
	pic = function()
		pr 'img/level71.png;img/level9.png@1,15;';
		if me()._elevator_key_pressed then
			pr 'img/elevator_open.png@217,58';
		end
	end,
};
--к71-2-----------------------------------------------------------------

--71-1------------------------------------------------------------------
--кнопки
d71p1l1 = obj {
	nam = '1',
	dsc = '{1},',
	act = function()
		return walk('d71p1level1');
	end,
};

d71p1l2 = obj {
	nam = '2',
	dsc = '{2},',
	act = function()
		return walk('d71p1level2');
	end,
};

d71p1l3 = obj {
	nam = '3',
	dsc = '{3},',
	act = function()
		return walk('d71p1level3');
	end,
};

d71p1l4 = obj {
	nam = '4',
	dsc = '{4},',
	act = function()
		return walk('d71p1level4');
	end,
};

d71p1l5 = obj {
	nam = '5',
	dsc = '{5},',
	act = function()
		return walk('d71p1level5');
	end,
};

d71p1l6 = obj {
	nam = '6',
	dsc = '{6},',
	act = function()
		return walk('d71p1level6');
	end,
};

d71p1l7 = obj {
	nam = '7',
	dsc = '{7},',
	act = function()
		return walk('d71p1level7');
	end,
};

d71p1l8 = obj {
	nam = '8',
	dsc = '{8},',
	act = function()
		return walk('d71p1level8');
	end,
};

d71p1l9 = obj {
	nam = '9',
	dsc = '{9},',
	act = function()
		return walk('d71p1level9');
	end,
};

d71p1stop = obj {
	nam = 'стоп',
	dsc = '{Стоп},',
	act = 'Никакого эффекта.'
};

d71p1call_disp = obj {
	nam = 'вызов',
	dsc = '{Вызов} диспетчера.',
	act = 'Никакого эффекта.',
};

--панель кнопок в лифте
d71p1elevator_panel = obj {
	nam = 'панель',
	dsc = 'Здесь расположена {панель} с кнопками:',
	act = 'Грязная, старая панель с кнопками.',
	obj = {'d71p1l1', 'd71p1l2', 'd71p1l3', 'd71p1l4', 'd71p1l5', 'd71p1l6', 'd71p1l7', 'd71p1l8', 'd71p1l9', 'd71p1stop', 'd71p1call_disp'},
};

--Лифт
d71p1elevator = room {
	nam = lev_title('Лифт'),
	dsc = 'Я в лифте.',
	obj = {'d71p1elevator_panel'},
	exit = function()
		set_sound('snd/elevator_close.ogg');
	end,
	pic = 'img/elevator.png',
};

--1-й этаж
d71p1level1 = room {
	nam = lev_title('Этаж 1'),
	dsc = [[Я нахожусь на этаже 1.]],
	way = {'d71', 'd71p1level12'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_basement'},
	enter = function(s, f)
		if f == 'd71p1door' then
			me()._dom = 71;
			me()._pod = 1;
			set_music('snd/pod1.ogg');
			--me()._lena_talk3 = true;
			if me()._lena_talk3 and not me()._lena_call then
				lifeon('telephone_lena');
			end
			return 'Дверь открылась, и я зашёл в подъезд.';
		end
	end,
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/level1.png@25,16;img/elevator_key1.png@195,109';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--1-2 этаж
d71p1level12 = room {
	nam = lev_title('Площадка между этажами 1-2'),
	dsc = [[Я нахожусь на площадке между этажами 1-2.]],
	way = {'d71p1level1', 'd71p1level2'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr171.png@219,114',
};

--2-й этаж
d71p1level2 = room {
	nam = lev_title('Этаж 2'),
	dsc = [[Я нахожусь на этаже 2.]],
	way = {'d71p1level12', 'd71p1level23'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/gr07.png@320,60';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--2-3 этаж
d71p1level23 = room {
	nam = lev_title('Площадка между этажами 2-3'),
	dsc = [[Я нахожусь на площадке между этажами 2-3.]],
	way = {'d71p1level2', 'd71p1level3'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr271.png@219,114;img/gr01.png@128,46',
};

--3 этаж
d71p1level3 = room {
	nam = lev_title('Этаж 3'),
	dsc = [[Я нахожусь на этаже 3.]],
	way = {'d71p1level23', 'd71p1level34'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key3.png@197,113;img/gr03.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--3-4 этаж
d71p1level34 = room {
	nam = lev_title('Площадка между этажами 3-4'),
	dsc = [[Я нахожусь на площадке между этажами 3-4.]],
	way = {'d71p1level3', 'd71p1level4'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr371.png@219,114',
};

--4 этаж
d71p1level4 = room {
	nam = lev_title('Этаж 4'),
	dsc = [[Я нахожусь на этаже 4.]],
	way = {'d71p1level34', 'd71p1level45'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/gr08.png@24,40';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--4-5 этаж
d71p1level45 = room {
	nam = lev_title('Площадка между этажами 4-5'),
	dsc = [[Я нахожусь на площадке между этажами 4-5.]],
	obj = {'chute2'},
	way = {'d71p1level4', 'd71p1level5'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr471.png@219,114',
};

--5 этаж
d71p1level5 = room {
	nam = lev_title('Этаж 5'),
	dsc = [[Я нахожусь на этаже 5.]],
	way = {'d71p1level45', 'd71p1level56'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key5.png@195,111;img/gr09.png@24,40';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--5-6 этаж
d71p1level56 = room {
	nam = lev_title('Площадка между этажами 5-6'),
	dsc = [[Я нахожусь на площадке между этажами 5-6.]],
	way = {'d71p1level5', 'd71p1level6'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr571.png@219,114',
};

--6 этаж
d71p1level6 = room {
	nam = lev_title('Этаж 6'),
	dsc = [[Я нахожусь на этаже 6.]],
	way = {'d71p1level56', 'd71p1level67'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--6-7 этаж
d71p1level67 = room {
	nam = lev_title('Площадка между этажами 6-7'),
	dsc = [[Я нахожусь на площадке между этажами 6-7.]],
	way = {'d71p1level6', 'd71p1level7'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr671.png@219,114',
};

--7 этаж
d71p1level7 = room {
	nam = lev_title('Этаж 7'),
	dsc = [[Я нахожусь на этаже 7.]],
	way = {'d71p1level67', 'd71p1level78'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key7.png@196,114;img/gr07.png@320,60';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--7-8 этаж
d71p1level78 = room {
	nam = lev_title('Площадка между этажами 7-8'),
	dsc = [[Я нахожусь на площадке между этажами 7-8.]],
	way = {'d71p1level7', 'd71p1level8'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr771.png@219,114',
};

--8 этаж
d71p1level8 = room {
	nam = lev_title('Этаж 8'),
	dsc = [[Я нахожусь на этаже 8.]],
	way = {'d71p1level78', 'd71p1level89'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level71.png;img/elevator_key3.png@197,113;img/gr03.png@312,45';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--8-9 этаж
d71p1level89 = room {
	nam = lev_title('Площадка между этажами 8-9'),
	dsc = [[Я нахожусь на площадке между этажами 8-9.]],
	way = {'d71p1level8', 'd71p1level9'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr871.png@219,114',
};

--надпись Глава 2 (фальшивка)
label_gl2_fake = obj {
	nam = 'надпись',
	dsc = [[На дверях лифта есть {надпись}.]],
	act = [[Надпись: «Глава 2. Смерть Елены». Вот она! Что же делать?]],
};

--9 этаж
d71p1level9 = room {
	nam = lev_title('Этаж 9'),
	dsc = [[Я нахожусь на этаже 9.]],
	way = {'d71p1level89'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_attic'},
	exit = function(s, t)
		me()._elevator_key_pressed = false;
		enable('label_gl2_fake');
		if t ~= 'mobil_tel_in' then
			return walk('scn_get');
		end
	end,
	pic = function()
		pr 'img/level71.png;img/level9.png@1,15;';
		if me()._elevator_key_pressed then
			pr 'img/elevator_open.png@217,58;';
		end
		if seen('label_gl2_fake') then
			pr 'img/gl2flabel.png@222,79';
		end
	end,
};
--к71-1-----------------------------------------------------------------

--звонок Лены
telephone_lena = obj {
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
		return walk('mob_lena_dlg');
	end,
};

--Звонок Лены
mob_lena_dlg = dlg {
	nam = 'Звонок Лены',
	dsc = [[Звонит Лена. Я взял трубку.]],
	obj = {
	[1] = phr('Алё.', 'Максим, привет! Ты где сейчас?!', [[pon(2);pon(3);]]),
	[2] = _phr('Я... гуляю.', 'Не ходи в подъезд, из которого выходил Степан! Это ловушка!', [[poff(3);pon(4);]]),
	[3] = _phr('В подъезде каком-то.', 'Оттуда выходил Степан?! Беги оттуда! Это ловушка!', [[poff(2);pon(4);]]),
	[4] = _phr('Что?! Откуда ты знаешь?', 'Максим, это долго объяснять. Но это ловушка. Они знают, что ты читал главу 2. Они сделали в том подъезде надпись. Степан специально оттуда вышел чтобы тебя заманить. Настоящая глава 2 происходит в 77-м доме. И сам Степан в опасности.', [[pon(5);]]),
	[5] = _phr('А ты не в опасности?! 2-я глава называлась «Смерть Елены». Не о тебе ли речь?', 'Обо мне. Но, я уже в безопасности. Проверь свою почту. Там есть что почитать. Обязательно проверь. Всё, пока.'),
	},
	exit = function()
		me()._is_post = true;
		me()._post = 'note_gl2true';
		me()._lena_call = true;
	end,
	pic = 'img/mob_dlg.png',
};

--записка гл.2 настоящая
note_gl2true = obj {
	nam = function()
		pr(img('img/icn_note_gl2true.png'));
		if me()._is_read_gl2true then
			pr '«Глава 2» (настоящая)';
		else
			pr 'бумага (почта)';
		end
	end,
	inv = function()
		me()._is_read_gl2true = true;
		return [[«Глава 2. Смерть Степана^^
Степан «Лифтёр» и помощник Степан сойдутся в этой схватке.
Каждый получил свою версию этой главы. Умереть должны оба. Каждый
думает, что умрёт не он. «Лифтёр» думает, что убьёт Степана ножами.
Степан думает, что убьёт «Лифтёра» огнестрельным пистолетом. Но если
кто-то выживет, я убью сам его. Как повезло, что их зовут одинаково...^^
У каждого своя версия главы. Я гений.»^^
Внизу дописано: «77-1».]];
	end,
};

--Попался
scn_get = room {
	nam = 'Попался!',
	dsc = [[Вдруг я услышал чьи-то шаги.^^
— Попался?! — раздался крик. — Мы давно тебя ловим. Ты совсем обнаглел.
Беспредельщик. То Степана побил, то... А, ты у нас в комнате был.
Читал мою повесть? Главу 1, 2. Я решил переписать 2-ю главу. А ты
попался в ловушку.^^
Ты пойми, мы занимаемся хорошим делом. Да, я мент. У меня есть связи.
Мы будем незамеченными. Точнее, о нас будут все говорить. Но никто нас
знать не будет.^^
Ты пойми, мы... В общем, у тебя два варианта... Либо ты с нами, либо я
тебя убью.]],
	obj = {vway('Продолжить', '{Продолжить}^^', 'scn_end1')},
	enter = function()
		set_music('snd/act3.ogg');
		if seen('telephone_lena') then
			lifeoff('telephone_lena');
		end
	end,
	nomobil = true,
	pic = 'img/scn_get.png',
};

--Конец 1
scn_end1 = room {
	nam = 'Конец',
	dsc = [[Да... Я стал на их сторону. Этот мент меня убедил. Они
убивали только людей, которые не заслуживали права на жизнь. В чём-то
они были правы...^^
Но, почему?.. Почему умер Стёпа, его напарник Иван, этот «Лифтёр»?...^^
Я пришёл на кладбище. Но не к Степану, не к Ивану... Я пришёл к Лене.
Она тоже умерла. И я ей в этом помог.^^
Новые люди... Это мент пообещал новых людей. Он сказал, что мы создаём
новый мир. Но почему погибли люди, которые мне были дороги?!^^
Я не знаю...]],
	obj = {vway('Титры', '{Титры}', 'scn_titles')},
	enter = function()
		set_music('snd/end1.ogg');
		lifeoff('stepan_end');
		lifeoff('ivan_end');
		inv():zap();
		
	end,
	pic = 'img/end1.png',
};

--Степан и Иван
scn_stepanivan = room {
	nam = 'Степан и Иван',
	dsc = [[Когда я подходил к 77-му дому, я заметил Степана и Ивана.
Они ссорились.^^
— Ты говорил, что в этом подъезде дверь на ключе, а она с домофоном!
— кричал Иван.^^
— Да я забыл, что она с домофоном.^^
— Я думаю, ты в сговоре с ними. Я тебя спас. Нас бы убили, если бы я
травматическим пистолетом не запасся.]],
	obj = {vway('Продолжить', '{Продолжить}', 'scn_lifter')},
	enter = function()
		set_music('snd/act3.ogg');
	end,
	nomobil = true,
	pic = 'img/scn_stepanivan.png',
};

--Лифтёр
scn_lifter = room {
	nam = '«Лифтёр»',
	dsc = [[Вдруг появился этот самый человек — «Лифтёр».^^
Степан достал пистолет и направил его на «Лифтёра».^^
— У тебя есть огнестрельный пистолет?! — кричал Иван. — Я рисковал за
тебя жизнью!^^
Все трое готовы были убить друг друга. Но я вмешался.^^
— Стойте! — крикнул я, и они посмотрели на меня. — Да он вас просто
натравил друг на друга. Ты, Степан, думаешь, что в этой главе должен
умереть он — Степан «Лифтёр». А ты, «Лифтёр», думаешь, что вот этот
Степан должен умереть. Не знаю, что этот, главный ваш, вам сказал, но
он вас круто провёл. Вот, почитайте настоящую главу 2.^^
Они по очереди просмотрели бумагу.^^
— Вы что, издеваетесь надо мной? — Сказал «Лифтёр». — Да ты сам её
напечатал.^^
— Взгляни на надпись внизу: «77-1». Ты же знаешь почерк своего этого
«главаря».^^
Он несколько минут молча рассматривал лист бумаги. Он действительно не
казался поддельным. И сама бумага такая же, и краска на ней та же, и
подпись с почерком...^^
— Этот гад мент. — наконец сказал «Лифтёр». — Благодаря ему я вышел на
свободу. Но он меня использовал... А я то думал, мы хорошими делами
занимаемся. Я только сейчас прозрел...]],
	obj = {vway('Продолжить', '{Продолжить}', 'scn_peace')},
	enter = function()
		set_music('snd/act3.ogg');
	end,
	nomobil = true,
	pic = 'img/scn_lifter.png',
};

--ключ Лифтёра 1
lifter_key1 = obj {
	nam = img('img/icn_lifter_key1.png')..'ключ №1',
	inv = [[Это один из ключей, которые мне дал сам «Лифтёр».]],
};

--ключ Лифтёра 2
lifter_key2 = obj {
	nam = img('img/icn_lifter_key2.png')..'ключ №2',
	inv = [[Это один из ключей, которые мне дал сам «Лифтёр».]],
};

--ключ Лифтёра 3
lifter_key3 = obj {
	nam = img('img/icn_lifter_key3.png')..'ключ №3',
	inv = [[Это один из ключей, которые мне дал сам «Лифтёр».]],
};

--ключ Лифтёра 4
lifter_key4 = obj {
	nam = img('img/icn_lifter_key4.png')..'ключ №4',
	inv = [[Это один из ключей, которые мне дал сам «Лифтёр».]],
};

--ключ Лифтёра 5
lifter_key5 = obj {
	nam = img('img/icn_lifter_key5.png')..'ключ №5',
	inv = [[Это один из ключей, которые мне дал сам «Лифтёр».]],
};

--Лифтёр
scn_peace = room {
	nam = 'Мир',
	dsc = [[Когда все успокоились, «Лифтёр» сказал:^^
— Нужно его убить.^^
— Кого?! — спросил Иван.^^
— Этого мента. — ответил Степан.^^
— Ты хороший человек. — обратился ко мне «Лифтёр». — Держи ключи. Идите к
гаражам. Я не знаю ни конкретного ключа, ни гаража. Подберите ключ и
гараж. В гараже должны лежать мешки со взрывчаткой. Берите их и несите
к четырнадцатиэтажке. А я пойду и свяжу этого гада...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd77')},
	enter = function()
		set_music('snd/act3.ogg');
		me()._peace = true;
	end,
	exit = function()
		inv():add('lifter_key1');
		inv():add('lifter_key2');
		inv():add('lifter_key3');
		inv():add('lifter_key4');
		inv():add('lifter_key5');
		ways('yard'):add('garages');

		lifeon('stepan_end');
		lifeon('ivan_end');

		--номер ключа и гаража
		me()._key_num = rnd(5);
		me()._garage_num = rnd(4);
	end,
	nomobil = true,
	pic = 'img/scn_peace.png',
};

--проверка ключа и гаража
function key_check(gar, keyn)
	if seen('sacks', 'garages') then
		return [[Двери нужного гаража уже открыты.]];
	else
		if gar._num == me()._garage_num then
			if deref(keyn) == 'lifter_key'..me()._key_num then
				objs('garages'):add('sacks');
				return [[Ключ подошёл. Я открыл двери гаража.]];
			else
				return [[Ключ не подходит.]];
			end
		else
			return [[Ключ не подходит.]];
		end
	end
end;

--мешки
sacks = obj {
	nam = 'мешки',
	dsc = function()
		return [[В гараже №]]..me()._garage_num..[[ есть {мешки}.]];
	end,
	act = function()
		return walk('scn_end2');
	end,
};

--гараж 1
garage1 = obj {
	nam = 'гараж №1',
	dsc = [[Предо мной находятся гаражи: {№1},]],
	act = function(s)
		if seen('sacks') and me()._garage_num == s._num then
			p [[Открытый гараж.]];
		else
			p [[Гараж с металлическими дверьми. На дверях есть замок.]];
		end
	end,
	used = function(s, w)
		return key_check(s, w);
	end,
	_num = 1,
};

--гараж 2
garage2 = obj {
	nam = 'гараж №2',
	dsc = [[{№2},]],
	act = function(s)
		if seen('sacks') and me()._garage_num == s._num then
			p [[Открытый гараж.]];
		else
			p [[Гараж с металлическими дверьми. На дверях есть замок.]];
		end
	end,
	used = function(s, w)
		return key_check(s, w);
	end,
	_num = 2,
};

--гараж 3
garage3 = obj {
	nam = 'гараж №3',
	dsc = [[{№3},]],
	act = function(s)
		if seen('sacks') and me()._garage_num == s._num then
			p [[Открытый гараж.]];
		else
			p [[Гараж с металлическими дверьми. На дверях есть замок.]];
		end
	end,
	used = function(s, w)
		return key_check(s, w);
	end,
	_num = 3,
};

--гараж 4
garage4 = obj {
	nam = 'гараж №4',
	dsc = [[{№4}.]],
	act = function(s)
		if seen('sacks') and me()._garage_num == s._num then
			p [[Открытый гараж.]];
		else
			p [[Гараж с металлическими дверьми. На дверях есть замок.]];
		end
	end,
	used = function(s, w)
		return key_check(s, w);
	end,
	_num = 4,
};

--Гаражи
garages = room {
	nam = 'Гаражи',
	dsc = [[Я стою у гаражей.]],
	obj = {'garage1', 'garage2', 'garage3', 'garage4'},
	way = {'yard'},
	pic = function()
		pr'img/garages.png;';
		if seen('sacks') then
			if me()._garage_num == 1 then
				pr 'img/garage_open.png@39,58';
			elseif me()._garage_num == 2 then
				pr 'img/garage_open.png@176,53';
			elseif me()._garage_num == 3 then
				pr 'img/garage_open.png@308,50';
			else
				pr 'img/garage_open.png@443,53';
			end
		end
	end,
};

--Степан
stepan_end = obj {
	nam = 'Степан',
	dsc = [[Рядом со мной {Степан}]],
	life = function(s)
		if not seen(s) and deref(here()) ~= 'mobil_tel_in' and deref(here()) ~= 'computer_in' and deref(here()) ~= 'browser_in' and deref(here()) ~= 'photo_dir_in' and deref(here()) ~= 'qcat_in' and deref(here()) ~= 'scn_get' then
			move(s, here(), s.__where);
			s.__where = pl.where;
		end
	end,
	act = function()
		return walk('stepan_end_dlg');
	end,
};

--Диалог со Степаном
stepan_end_dlg = dlg {
	nam = 'Диалог со Степаном',
	dsc = [[Степан внимательно смотрит на меня.]],
	obj = {
	[1] = phr('Почему ты стал на сторону того оборотня в погонах?', 'Та я по пьяни к ним попал. Они мне угрожали.'),
	[2] = phr('Как вы делали так, что света не было, а лифт работал?', 'К лифту питание с другой линии подаётся. Там 380 вольт.'),
	[3] = phr('А как вы делали, что невозможно было с подъезда выйти?', 'Дверь с домофоном удерживается с помощью электромагнита. Мы просто к электромагниту напрямую питание подсоединяли. Вот и нельзя было открыть. На всякий случай мы и в соседнем подъезде подобное проделывали. Чтобы думали, что проблема во всём доме.'),
	[4] = phr('А куда вы дели трупы тех ребят?', '«Лифтёр» с ментом их спрятали где-то. Меня кто-то же закрыл на чердаке. Они испугались.'),
	[5] = phr('Степан, может тебе надо закодироваться?', 'Может быть...'),
	},
	exit = function(s)
		s:pon(5);
	end,
	pic = 'img/stepan_dlg.png',
};

--Иван
ivan_end = obj {
	nam = 'Иван',
	dsc = [[и {Иван}.]],
	life = function(s)
		if not seen(s) and deref(here()) ~= 'mobil_tel_in' and deref(here()) ~= 'computer_in' and deref(here()) ~= 'browser_in' and deref(here()) ~= 'photo_dir_in' and deref(here()) ~= 'qcat_in' and deref(here()) ~= 'scn_get' then
			move(s, here(), s.__where);
			s.__where = pl.where;
		end
	end,
	act = function()
		return walk('ivan_end_dlg');
	end,
};

--Диалог с Иваном
ivan_end_dlg = dlg {
	nam = 'Диалог с Иваном',
	dsc = [[Иван внимательно смотрит на меня.]],
	obj = {
	[1] = phr('Ты когда в прошлый раз попал в подъезд, ты выйти не мог?', 'Дверь была закрыта. Теперь я понимаю, что дело в домофоне. Они электромагнитом её удерживали!'),
	[2] = phr('Ты герой! Ты спас Степана!', 'Я бы не стал этого делать, если бы всё знал... Это ты герой, ты разоблачил того мента.'),
	[3] = phr('Ты будешь со Степаном дальше дружить?', 'Давай не будем сейчас об этом.'),
	[4] = phr('Иван, может тебе надо закодироваться?', 'Сам закодируйся.'),
	},
	exit = function(s)
		s:pon(4);
	end,
	pic = 'img/ivan_dlg.png',
};

--Конец 2
scn_end2 = room {
	nam = 'Конец',
	dsc = [[Мы отнесли мешки к четырнацдатиэтажке. Нас встретил
«Лифтёр».^^
— Ну, что? — спросил я.^^
— Всё в порядке. Я его вырубил, крепко привязал... В общем всё приготовил.^^
— И что дальше?^^
— Взорвём здесь всё к чертям.^^
— Но мы же его убьём!^^
— По делам ему! — вмешался Степан. — По другому никак. Мы даже в милицию
пойти не можем. Он сам мент. Да и мы соучастники. По крайней мере я и
«Лифтёр».^^
«Лифтёр» брал по мешку и носил их в здание четырнадцатиэтажки.
Мы ждали... Наконец, мешки закончились.^^
— Уходите отсюда подальше. — приказал «Лифтёр».^^
Через минут десять произошло несколько взрывов. Мы пытались найти
«Лифтёра», но нам не удалось... Возможно, он остался в
четырнадцатиэтажке. А быть может, просто сбежал.^^
Что касается меня с Леной... У нас была свадьба... И, как оказалось,
она была тоже замешана в этой истории. Но пусть об этом расскажет она
сама.]],
	obj = {vway('Титры', '{Титры}', 'scn_titles')},
	enter = function()
		set_music('snd/end2.ogg');
		lifeoff('stepan_end');
		lifeoff('ivan_end');
		inv():zap();
	end,
	pic = 'img/end2.png',
};

--Титры
scn_titles = room {
	nam = 'Титры',
	dsc = txtc(txtb('Автор:')..[[^Евгений Ефремов^^]]..
txtb('Движок INSTEAD:')..[[^Петр Косых^^]]..
txtb('Музыка и звуки:')..[[^Петр Семилетов^Евгений Ефремов^Некоторые звуки взяты с сайта freesound.org^^]]..
txtb('Благодарности:')..[[^Александр Дадыка, Анатолий Ефремов — за сканирование^Александр Шохров — за грамматику и вдохновение^Вероника Рубин — за грамматику и прочее^Петр Косых — за движок INSTEAD, фото и много чего ещё^Вадим Балашов — за фото и вдохновение^
А также всем участникам форума, которые мне помогали!^^]]..
txtb('Сайт автора:')..[[^http://jhekasoft.narod.ru]])..
[[^^Если вам понравилась игра, вы можете написать свою! А если не понравилась, так тем более нужно исправлять ситуацию! Поверьте, написать игру на INSTEAD не так уж
сложно! Особенно, если вы хоть немного соображаете в программировании.
Зайдите на сайт ]]..txtb('http://instead.syscall.ru')..'.',
	pic = 'img/screen.png',
};
