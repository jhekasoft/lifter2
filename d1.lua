me()._last_scene_name = ''; --имя сцены до использования моб. тел.
me()._elevator_key_pressed = false; --нажата кнопка лифта
me()._dom = 0; --номер дома
me()._pod = 0; --номер подъезда
me()._is_post = false; --есть ли почта
me()._post = ''; --имя объекта почты (в почтовом ящике)
me()._is_read_72 = false; --читался ли 72-й номер газеты.
me()._is_seen_d111stepan = false; --видел ли Стёпу возле 14-ти-эт.
me()._is_read_intro = false; --читал ли Введение
me()._was_in_yard_d111 = false; --был ли во дворе 14-ти-эт.
me()._is_seen_d111human = false; --видел ли человека в 14-ти-эт.
me()._is_hear_stepa = false; --слышал ли разговор Степана

--Заставка
screen = room {
	nam = 'Лифтёр 2',
	dsc = [[Версия: 0.3 (15.07.2013)^^
	Автор: Евгений Ефремов^
	Движок INSTEAD: Петр Косых^
	Музыка: Петр Семилетов, Евгений Ефремов^^
	Благодарности: Александр Дадыка, Александр Шохров, Вероника Рубин,
Петр Косых, Вадим Балашов^^
	Сайт автора: jhekasoft.net^^
	Дата выхода игры: 15.09.2010]],
	enter = music('snd/screen.ogg', 1),
	obj = {vway('Инструкция', '{Инструкция}^', 'instruction'),
		vway('Начать', '{Начать}', 'morning')},
	exit = function()
		stop_music();
	end,
	pic = 'img/screen.png',
};

--Инструкция
instruction = room {
	nam = 'Инструкция',
	dsc = txtc(img('img/inst02.png'))..
[[^^Эта инструкция нужна для того чтобы уяснить и так ясные вещи, а
также не совсем те, которые сразу можно понять. Без инструкции не всем
было понятно как играть в «Лифтёр», в «Лифтёр 2» не будет понятно тем более.
Поэтому эта инструкция просто необходима!^^]]
..txtb('Время происходящих событий')..[[. События «Лифтёра 2»
начинают развиваться немного ранее событий «Лифтёра». А заканчиваются
немного позже.^^]]
..txtb('Номера дома, подъезда')..[[. Теперь номер дома и подъезда
отображается в названии сцены, потому как в статусе их было не совсем
заметно.^^]]
..txtb('Карта кликабельна')..[[. Вы можете переходить в нужные места
не только используя стандартные ссылки, но и кликая по необходимому
объекту на карте двора.^^]]
..txtb('Почта')..[[. Проверяйте почту, которая находится в почтовом
ящике. А почтовый ящик находится (не в интернете, представьте себе)
в вашем подъезде.^^]]
..txtb('Мобильный телефон')..[[. Он может пригодится. Особенно
если звонить когда надо куда надо. Но на этом его функции не
ограничиваются.^^]]
..txtb('Компьютер')..[[. У главного героя есть дома компьютер с
интернетом. Может, он Вам сможет пригодиться.^^]]
..txtb('Читайте')..[[! Чтобы было понятно, что происходит, да
и вообще что нужно делать, нужно читать! Читайте! Иначе автор
будет виноват.^^]]
..txtc(img('img/inst01.png')),
	obj = {vway('Вернуться', '{Вернуться}', 'screen')},
};

--ключи от квартиры
home_key = obj {
	nam = img('img/icn_home_key.png')..'ключи',
	inv = [[Связка ключей. Содержит ключи от подъезда, от квартиры (один
от перегородки, два от входной двери). Также есть ключ от почтового ящика.]],
};

--звонок
function mob_call()
	local cal_type_num = rnd(2);
	if cal_type_num == 1 then
		set_sound('snd/telephone_busy.ogg');
		return [[Занято...]];
	else
		set_sound('snd/telephone_noans.ogg');
		return [[Не отвечает...]];
	end
end;

--номер телефона Димы
dima_tel = obj {
	nam = 'дима',
	dsc = 'Дима — 0586525781 ({Позвонить})^',
	act = function()
		if me()._is_morning3 and not me()._is_night then
			if me()._is_were_in_dima_flat then
				set_sound('snd/telephone_ans.ogg');
				return walk('mob_dima_day3_dlg');
			else
				set_sound('snd/telephone_busy.ogg');
				return [[Занято. Надо попозже попробовать позвонить.]];
			end
		elseif me()._is_morning2 and me()._is_cat_discard and not me()._is_night then
			set_sound('snd/telephone_ans.ogg');
			return walk('mob_dima_agree_dlg');
		else
			return mob_call(); 
		end
	end,
};

--номер телефона Лены
lena_tel = obj {
	nam = 'лена',
	dsc = 'Лена — 0613641257 ({Позвонить})',
	act = function()
		if me()._is_morning3 and not me()._is_night then
			--3-й день
			if me()._lena_meet then
				if not me()._lena_talk3 then
					set_sound('snd/telephone_ans.ogg');
					return walk('lena3_dlg');
				else
					return mob_call();
				end
			elseif me()._lena_talk2 then
				if not me()._lena_talk3b then
					set_sound('snd/telephone_ans.ogg');
					return walk('lena3b_dlg');
				else
					return mob_call();
				end
			else
				return mob_call();
			end
		elseif me()._is_morning2 then
			--2-й день
			if me()._lena_talk1 then
				if not me()._lena_talk2 then
					set_sound('snd/telephone_ans.ogg');
					return walk('lena2_dlg');
				else
					return mob_call();
				end
			else
				if not me()._lena_talk2b then
					set_sound('snd/telephone_ans.ogg');
					return walk('lena2b_dlg');
				else
					return mob_call();
				end
			end
		else
			--1-й день
			if not me()._lena_talk1 then
				set_sound('snd/telephone_ans.ogg');
				return walk('lena1_dlg');
			else
				return mob_call();
			end
		end
	end,
};

--пункт меню "телефонная книга"
m_phonebook = obj {
	nam = 'телефонная книга',
	dsc = 'Меню:^{Телефонная книга}^',
	act = function()
		--objs('mobil_tel_in'):add('phonebook');
		objs('mobil_tel_in'):add('phonebook', 10);
		objs('mobil_tel_in'):del('memo');
		objs('mobil_tel_in'):del('photo');
		return 'Телефонная книга';
	end,
};

--телефонная книга
phonebook = obj {
	nam = 'телефонная книга',
	dsc = '^^',
	obj = {'dima_tel', 'lena_tel'},
};

--пункт меню "заметки"
m_memo = obj {
	nam = 'заметки',
	dsc = '{Заметки}^',
	act = function()
		--objs('mobil_tel_in'):add('memo');
		objs('mobil_tel_in'):add('memo', 10);
		objs('mobil_tel_in'):del('phonebook');
		objs('mobil_tel_in'):del('photo');
		return 'Заметки';
	end,
};

--заметки
memo = obj {
	nam = 'заметки',
	dsc = function(s)
		p [[^^]]
		if me()._is_day_m then
			p [[Степан должен был сделать надпись либо в 1-м подъезде
71-го дома, либо во 2-м.^]];
		end
		if s._is_memo2 then
			p [[Адрес Димы: б-р Шевченко, 77, 31 (1-й подъезд, 8-й этаж)^]];
		end
		if s._is_memo3 then
			p [[Адрес Лены: б-р Шевченко, 83, ... (2-й подъезд)^]];
		end
		if s._is_memo1 then
			p [[Адрес Степана: б-р Шевченко, 73, 6 (1-й подъезд, 2-й этаж)^]];
		end
		p [[Мой адрес: б-р Шевченко, 73, 5 (1-й подъезд, 2-й этаж)]];
	end,
	_is_memo1 = false,
	_is_memo2 = false,
	_is_memo3 = false,
};

--пункт меню "снимки"
m_photo = obj {
	nam = 'снимки',
	dsc = '{Снимки}',
	act = function()
		--objs('mobil_tel_in'):add('photo');
		objs('mobil_tel_in'):add('photo', 10);
		objs('mobil_tel_in'):del('phonebook');
		objs('mobil_tel_in'):del('memo');
		return 'Снимки';
	end,
};

--снимки
photo = obj {
	nam = 'снимки',
	dsc = function(s)
		p [[^^Благодаря камере, встроенной в мой мобильный, можно сделать
хоть и не высококачественное, но довольно хорошее фото.]];
		if not s._is_photo1 then
			p 'Здесь можно будет просмотреть фото, сделанные на камеру.';
		else
			p('^^'..txtb('Фото:'));
		end
		if s._is_photo1 then
			p('^^Четырнадцатиэтажка^'..img('img/photo1s.png'));
		end
		if s._is_photo2 then
			p('^^Бумага 1^'..img('img/photo21s.png')..'^^Бумага 2^'..img('img/photo22s.png'));
		end
	end,
	_is_photo1 = false,
	_is_photo2 = false,
};

--отложить телефон
exit_tel = obj {
	nam = 'вернуться',
	dsc = function()
		return '^^{Вернуться}'; --me()._last_scene_name
	end,
	act = function()
		objs('mobil_tel_in'):del('phonebook');
		objs('mobil_tel_in'):del('memo');
		objs('mobil_tel_in'):del('photo');
		return walk(ref(me()._last_scene_name));
	end,
};

--мобильный телефон
mobil_tel = obj {
	nam = img('img/icn_mobil_tel.png')..'мобильный',
	inv = function()
		if isDialog(here()) or here().nomobil then
			return [[Это мой мобильный телефон.]];
		else
			if seen('telephone_dima') then
				lifeoff(telephone_dima);
				objs():del('telephone_dima');
				return walk('mob_dima_dlg');
			elseif seen('telephone_lena') then
				lifeoff(telephone_lena);
				objs():del('telephone_lena');
				return walk('mob_lena_dlg');
			else
				if deref(here()) ~= 'mobil_tel_in' then
					me()._last_scene_name = deref(here());
				end
				return walk('mobil_tel_in');
			end
		end
	end,
	use = function(s, w)
		if w == 'd111build' then
			if not photo._is_photo1 then
				if me()._is_read_72 then
					photo._is_photo1 = true;
					return [[Я сфотографировал четырнадцатиэтажку... Теперь
можно вернуться домой, сбросить фотку четырнадцатиэтажки на компьютер
и посмотреть в полный размер.]];
				else
					return [[Сфотографировать? Как-нибудь потом.
Память жалко забивать.]];
				end
			else
				return 'Я уже её сфотографировал.';
			end
		elseif w == 'note_12' then
			if not photo._is_photo2 then
				if me()._is_seen_gl12 then
					photo._is_photo2 = true;
					return [[Я сфотографировал бумаги. Теперь нужно
скинуть их на компьютер и хорошо изучить!]];
				else
					return [[Нет. Не вижу смысла.]];
				end
			end
		elseif w == 'photo_dir' then
			return [[Хорошая идея. Нужно только войти в эту папку.]];
		elseif w == 'add_photo' then
			p [[Я подключил мобильный телефон к компьютеру.]];
			local new_photo = false; --есть ли новые фото
			if photo._is_photo1 and not photo_comp._is_photo1 then
				photo_comp._is_photo1 = true;
				p [[Я перекинул фото четырнадцатиэтажки с мобильного
телефона в компьютер.]];
				new_photo = true;
			end
			if photo._is_photo2 and not photo_comp._is_photo2 then
				photo_comp._is_photo2 = true;
				--распечатал
				inv():add('note_gl1');
				inv():add('note_gl2');
				p [[Я перекинул фотографии глав 1, 2 на компьютер и сразу же их распечатал.]];
				set_sound('snd/printer.ogg');
				new_photo = true;
			end
			if not new_photo then
				p [[На нём нет новых фото.]];
			end
		else
			return [[Что им сделать? Сфотографировать? Не надо тратить
память без надобности.]];
		end
	end,
};

--Мобильный телефон (открыт)
mobil_tel_in = room {
	nam = 'Мобильный телефон',
	dsc = 'Мой мобильный телефон.',
	obj = {'m_phonebook', 'm_memo', 'm_photo'},
	pic = 'img/mobil_tel.png',
};

--Утро
morning = room {
	nam = 'Раннее утро...',
	dsc = [[Весь следующий день после дня рождения Димы я спал. К
счастью, я был в отпуске. Поэтому мне это было позволительно. Эта
работа... Она так меня достала! Мне хотелось провести отпуск так,
чтобы он запомнился навсегда.^^
А вот следующее утро (после дня рождения Димы) было необычным. Даже
каким-то странным... Не то, чтобы было что-то необычное. Скорее
наоборот: всё было обычное. Именно поэтому мне это утро показалось таким
необычным и странным...^^
Я проснулся рано. В 5 часов поутру. Последние несколько ночей до дня
рождения Димы я не спал. Мой режим изменился. Я превратился в "сову".
Хотя никогда не верил в эти дурацкие типы людей по их распорядку дня.
Но наконец-то я поспал немного ночью. И проснулся рано утром...^^
Вот я встал, умылся, немного даже позавтракал. Оделся, обулся и решил
идти на улицу. Гулять...]],
	obj = {vway('Продолжить', '{Продолжить}', 'd73level2')},
	enter = music('snd/yard1.ogg'),
	exit = function()
		--objs('mobil_tel_in'):add('exit_tel');
		objs('mobil_tel_in'):add('exit_tel', 20);
		inv():add('home_key');
		inv():add('mobil_tel');
		--газета в ящике
		me()._is_post = true;
		me()._post = 'newspaper72';

		--me()._dom = 73;
		--me()._pod = 1;

		set_music('snd/pod1.ogg');

		return [[Давненько я не заглядывал в почтовый ящик...]];
	end,
	pic = 'img/morning.png',
};

--газета 72
newspaper72 = obj {
	nam = img('img/icn_newspaper72.png')..'газета (№72)',
	inv = function()
		if not me()._is_read_72 then
			me()._is_read_72 = true;
		end
		p [[Это наша городская газета с идиотским названием
«Вечерний обзор». Она выходит несколько раз в неделю.^^
Похоже, главная новость в 72-м номере «Вечернего обзора» — это cнос
четырнадцатиэтажки, которая находится недалеко от нас:^^
«Планируется снос многоэтажного дома, расположенного по проспекту
Металлургов, 111. Как известно, эта «четырнадцатиэтажка» была построена
на плохом грунте, и с каждым годом её угол наклона увеличивался. В связи
с этим ещё в апреле 1998 года её жители были переселены.^
...^
В ближайшие дни планируется эвакуация жителей домов, которые расположены
рядом с «четырнадцатиэтажкой», так как здание планируется снести
направленным взрывом...»^^
Больше ничего интересного.]];
		if not photo._is_photo1 then
			p [[^^Хм... Если четырнадцатиэтажку скоро снесут, можно пойти
её напоследок сфотографировать на камеру моего мобильного телефона.]];
		end
	end,
};

--кнопка вызова лифта
elevator_key = obj {
	nam = 'кнопка',
	dsc = 'Возле дверей расположена {кнопка} вызова лифта.',
	act = function()
		if me()._dom == 77 and me()._pod == 1 and me()._is_seen_stepan_run then
			return [[Лифт не работает. В доме нет света. Наверное его
отключила эта банда лифто-маньяков.]];
		elseif me()._dom == 79 and me()._pod == 2 and me()._is_seen_labelvved then
			return 'Лифт не работает.';
		else
			if me()._elevator_key_pressed then
				return [[Двери лифта уже открыты.]];
			else
				if deref(here()) == 'd79p2level9' and seen('label_intro') then
					disable('label_intro');
				elseif deref(here()) == 'd77p1level9' and seen('label_gl1') then
					disable('label_gl1');
				elseif deref(here()) == 'd71p1level9' and seen('label_gl2_fake') then
					disable('label_gl2_fake');
				end
				me()._elevator_key_pressed = true;
				set_sound('snd/elevator_open.ogg');
				return 'Я вызвал лифт. Двери открылись.';
			end
		end
	end,
};

--двери лифта
elevator_door = obj {
	nam = 'двери лифта',
	dsc = function()
		if me()._elevator_key_pressed then
			return 'Передо мной открытые {двери} лифта.';
		else
			return 'Передо мной {двери} лифта.';
		end
	end,
	act = function()
		if me()._elevator_key_pressed then
			if me()._dom == 73 then
				if me()._pod == 1 then
					return walk('d73p1elevator');
				end
			elseif me()._dom == 77 then
				if me()._pod == 1 then
					return walk('d77p1elevator');
				end
			elseif me()._dom == 79 then
				if me()._pod == 2 then
					return walk('d79p2elevator');
				end
			elseif me()._dom == 71 then
				if me()._pod == 1 then
					return walk('d71p1elevator');
				elseif me()._pod == 2 then
					return walk('d71p2elevator');
				end
			end
		else
			return 'Обычные двери лифта.';
		end
	end,
};

--звонки
bells = obj {
	nam = 'звонки',
	dsc = 'По сторонам расположены {звонки} в квартиры.',
	act = [[Я подумал позвонить в звонки каких-нибудь квартир. Но это...
аморально. А я не Угол с группы ОН.]],
};

--труба мусоропровода
chute1 = obj {
	nam = 'труба',
	dsc = 'Здесь расположена {труба} мусоропровода.',
	obj = {vobj(1, 'дверца', 'В ней есть {дверца} для выброса мусора.')},
	act = function(s, w)
		if w == 1 then
			return 'Её можно открыть и бросить что-нибудь. Например, мусор.';
		else
			if me()._dom == 79 then
				if me()._pod == 2 then
					if here() == d79p2level78 then
						if me()._is_seen_labelvved and not me()._is_seen_human2 then
							return walk('scn_human2');
						else
							return 'Труба прямо белоснежная. Надавно белили наверное.';
						end
					else
						return 'Труба прямо белоснежная. Надавно белили наверное.';
					end
				end
			else
				return 'Старая уже. Но держится нормально.';
			end
		end
	end,
};

--труба мусоропровода (без дверцы)
chute2 = obj {
	nam = 'труба',
	dsc = 'Здесь расположена {труба} мусоропровода.',
	act = 'Старая труба.',
};

--Функция форматирования заголовка сцены этажа
--rm — комната, lev_name — имя этажа
--Вывод: Этаж (дом, подъезд)
function set_lev_title(rm, lev_name)
	if rm == here() then
		return lev_name..' (д.'..me()._dom..', п.'..me()._pod..')';
	else
		return lev_name;
	end
end;

--поглощение (Хе-ге!)
function lev_title(lev_name)
	return function(s)
		return set_lev_title(s, lev_name);
	end
end;

--люк в подвал
hatch_basement = obj {
	nam = 'люк',
	dsc = [[Под ступеньками есть {люк}, ведущий в подвал.]],
	act = [[Люк закрыт на навесной замок.]],
};

--люк на чердак
hatch_attic = obj {
	nam = 'люк',
	dsc = [[Вверху есть {люк}, ведущий на чердак.]],
	act = [[Люк закрыт на навесной замок.]],
};

--73-1------------------------------------------------------------------
--кнопки
d73p1l1 = obj {
	nam = '1',
	dsc = '{1},',
	act = function()
		return walk('d73level1');
	end,
};

d73p1l2 = obj {
	nam = '2',
	dsc = '{2},',
	act = function()
		return walk('d73level2');
	end,
};

d73p1l3 = obj {
	nam = '3',
	dsc = '{3},',
	act = function()
		return walk('d73level3');
	end,
};

d73p1l4 = obj {
	nam = '4',
	dsc = '{4},',
	act = function()
		return walk('d73level4');
	end,
};

d73p1l5 = obj {
	nam = '5',
	dsc = '{5},',
	act = function()
		return walk('d73level5');
	end,
};

d73p1l6 = obj {
	nam = '6',
	dsc = '{6},',
	act = function()
		return walk('d73level6');
	end,
};

d73p1l7 = obj {
	nam = '7',
	dsc = '{7},',
	act = function()
		return walk('d73level7');
	end,
};

d73p1l8 = obj {
	nam = '8',
	dsc = '{8},',
	act = function()
		return walk('d73level8');
	end,
};

d73p1l9 = obj {
	nam = '9',
	dsc = '{9},',
	act = function()
		return walk('d73level9');
	end,
};

d73p1stop = obj {
	nam = 'стоп',
	dsc = '{Стоп},',
	act = 'Никакого эффекта.'
};

d73p1call_disp = obj {
	nam = 'вызов',
	dsc = '{Вызов} диспетчера.',
	act = 'Никакого эффекта.'
};

--панель кнопок в лифте
d73p1elevator_panel = obj {
	nam = 'панель',
	dsc = 'Здесь расположена {панель} с кнопками:',
	act = 'Грязная, старая панель с кнопками.',
	obj = {'d73p1l1', 'd73p1l2', 'd73p1l3', 'd73p1l4', 'd73p1l5', 'd73p1l6', 'd73p1l7', 'd73p1l8', 'd73p1l9', 'd73p1stop', 'd73p1call_disp'},
};

--Лифт
d73p1elevator = room {
	nam = lev_title('Лифт'),
	dsc = 'Я в лифте.',
	obj = {'d73p1elevator_panel'},
	exit = function()
		set_sound('snd/elevator_close.ogg');
	end,
	pic = 'img/elevator.png',
};

--1-й этаж
d73level1 = room {
	nam = lev_title('Этаж 1'),
	dsc = [[Я нахожусь на этаже 1.]],
	way = {'d73', 'd73level12'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_basement'},
	enter = function(s, f)
		if f == 'd73p1door' then
			me()._dom = 73;
			me()._pod = 1;
			set_music('snd/pod1.ogg');
			return 'Дверь открылась, и я зашёл в подъезд.';
		end
	end,
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/level1.png@25,16;img/elevator_key1.png@195,109';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--замок почтового ящика
post_lock = obj {
	nam = 'замок',
	dsc = 'На ящике {замок}.',
	act = 'Чтобы открыть, нужен лишь ключ.',
	used = function(s, w)
		if w == 'home_key' then
			if me()._is_post then
				inv():add(me()._post);
				me()._is_post = false;
				if me()._post == 'note_gl2true' then
					return 'В ящике оказалась бумага.';
				else
					return 'Я открыл ящик. Там оказалась газета. Я её взял.';
				end
			else
				return 'Ничего в ящике нет... Он действительно пуст.';
			end
		end
	end,
};

--Почтовый ящик игрока
my_post = room {
	nam = 'Мой почтовый ящик',
	dsc = function()
		p 'Вот мой почтовый ящик.';
		if me()._is_post then
			p 'Кажется, в нём что-то есть. Надо открыть.';
		else
			p 'Сквозь отверстия я вижу, что в нём ничего нет.';
		end
	end,
	obj = {'post_lock'},
	way = {'d73level12'},
	pic = function()
		pr 'img/my_post.png;';
		if me()._is_post then
			pr 'img/my_post_i.png@70,74;';
		end
	end,
};

--почтовые ящики
d73p1post = obj {
	nam = 'ящики',
	dsc = 'На стене расположены почтовые {ящики}.',
	act = function()
		return walk('my_post');
	end,
};

--1-2 этаж
d73level12 = room {
	nam = function(s)
		if here() == my_post then
			return 'Отойти';
		else
			return set_lev_title(s, 'Площадка между этажами 1-2');
		end
	end,
	dsc = [[Я нахожусь на площадке между этажами 1-2.]],
	way = {'d73level1', 'd73level2'},
	obj = {'chute1', 'd73p1post'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr173.png@219,114',
};

--дверь в перегородку
partition_doors = obj {
	nam = 'дверь',
	dsc = 'На этом этаже {дверь в перегородку} с моей квартирой.',
	act = [[Нужны ключи.]],
	used = function(s, w)
		if w == 'home_key' then
			if not photo._is_photo1 then
				return [[Я провёл много времени в четырёх стенах, и у
меня пока что нет ни малейшего желания возвращаться туда обратно.]];
			else
				return walk('partition');
			end
		end
	end,
};

--дверь в кв. ГГ
my_apartment_door = obj {
	nam = 'дверь',
	dsc = 'Здесь есть {дверь} в мою квартиру.',
	act = 'Нужны ключи.',
	used = function(s, w)
		if w == 'home_key' then
			return walk('my_apartment');
		end
	end,
};

--компьютер
computer = obj {
	nam = 'компьютер',
	dsc = 'На нём слева расположен {компьютер}.',
	act = function()
		return walk('computer_in');
	end,
};

--Компьютер
computer_in = room {
	nam = function()
		if here() ~= browser_in and
			here() ~= photo_dir_in and
			here() ~= qcat_in then
			return 'Компьютер';
		else
			return 'Закрыть';
		end
	end,
	dsc = 'Передо мной монитор моего компьютера.',
	obj = {'photo_dir', 'browser', 'qcat'},
	way = {'my_apartment'},
	enter = function(s, f)
		if f == 'my_apartment' then
			return 'Я включил компьютер.';
		end
	end,
	exit = function(s, t)
		if t == 'my_apartment' then
			return 'Я выключил компьютер.';
		end
	end,
	nomobil = true,
	pic = 'img/computer.png;img/desktop.png@48,34',
};

--папка Фото
photo_dir = obj {
	nam = 'фото',
	dsc = 'На рабочем столе я вижу {папку «Фото»}, ',
	act = function()
		return walk('photo_dir_in');
	end,
};

--добавление фото (с моб. тел.)
add_photo = obj {
	nam = 'добавление фото',
	dsc = 'Сюда можно {добавить фотографии}.',
	act = 'Чтобы добавить нужно что-то использовать.',
};

--фото на компьютере
photo_comp = obj {
	nam = 'фото',
	dsc = function(s)
		if not s._is_photo1 then
			p 'Пока фотографий нет.';
		else
			p('^^'..txtb('Фото:'));
		end
		if s._is_photo1 then
			p('^^Четырнадцатиэтажка^'..img('img/photo1b.png'));
		end
		if s._is_photo2 then
			p('^^Бумага 1^'..img('img/photo21b.png')..'^^Бумага 2^'..img('img/photo22b.png'));
		end
	end,
	_is_photo1 = false,
	_is_photo2 = false,
};

--Папка Фото
photo_dir_in = room {
	nam = 'Папка «Фото»',
	dsc = [[В этой папке находятся мои фотографии.]],
	obj = {'add_photo', 'photo_comp'},
	way = {'computer_in'},
	nomobil = true,
	pic = 'img/computer.png;img/desktop.png@48,34;img/photo_dir.png@101,42',
};

--браузер
browser = obj {
	nam = 'браузер',
	dsc = '{браузер}, ',
	act = function()
		return walk('browser_in');
	end,
};

alph = {'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л',
'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ',
'ъ', 'ы', 'ь', 'э', 'ю', 'я', '1', '2', '3', '4', '5', '6', '7', '8',
'9', '0',
}

--клавиатура
keyboard = obj {
	nam = 'клавиатура',
	dsc = [[^^Клавиатура:^]],
	obj = {
		vobj(1, alph[1], '{'..alph[1]..'} '),
		vobj(2, alph[2], '{'..alph[2]..'} '),
		vobj(3, alph[3], '{'..alph[3]..'} '),
		vobj(4, alph[4], '{'..alph[4]..'} '),
		vobj(5, alph[5], '{'..alph[5]..'} '),
		vobj(6, alph[6], '{'..alph[6]..'} '),
		vobj(7, alph[7], '{'..alph[7]..'} '),
		vobj(8, alph[8], '{'..alph[8]..'} '),
		vobj(9, alph[9], '{'..alph[9]..'} '),
		vobj(10, alph[10], '{'..alph[10]..'} '),
		vobj(11, alph[11], '{'..alph[11]..'} '),
		vobj(12, alph[12], '{'..alph[12]..'} '),
		vobj(13, alph[13], '{'..alph[13]..'} '),
		vobj(14, alph[14], '{'..alph[14]..'} '),
		vobj(15, alph[15], '{'..alph[15]..'} '),
		vobj(16, alph[16], '{'..alph[16]..'} '),
		vobj(17, alph[17], '{'..alph[17]..'} '),
		vobj(18, alph[18], '{'..alph[18]..'} '),
		vobj(19, alph[19], '{'..alph[19]..'} '),
		vobj(20, alph[20], '{'..alph[20]..'} '),
		vobj(21, alph[21], '{'..alph[21]..'} '),
		vobj(22, alph[22], '{'..alph[22]..'} '),
		vobj(23, alph[23], '{'..alph[23]..'} '),
		vobj(24, alph[24], '{'..alph[24]..'} '),
		vobj(25, alph[25], '{'..alph[25]..'} '),
		vobj(26, alph[26], '{'..alph[26]..'} '),
		vobj(27, alph[27], '{'..alph[27]..'} '),
		vobj(28, alph[28], '{'..alph[28]..'} '),
		vobj(29, alph[29], '{'..alph[29]..'} '),
		vobj(30, alph[30], '{'..alph[30]..'} '),
		vobj(31, alph[31], '{'..alph[31]..'} '),
		vobj(32, alph[32], '{'..alph[32]..'} '),
		vobj(33, alph[33], '{'..alph[33]..'}^'),
		vobj(34, alph[34], '{'..alph[34]..'} '),
		vobj(35, alph[35], '{'..alph[35]..'} '),
		vobj(36, alph[36], '{'..alph[36]..'} '),
		vobj(37, alph[37], '{'..alph[37]..'} '),
		vobj(38, alph[38], '{'..alph[38]..'} '),
		vobj(39, alph[39], '{'..alph[39]..'} '),
		vobj(40, alph[40], '{'..alph[40]..'} '),
		vobj(41, alph[41], '{'..alph[41]..'} '),
		vobj(42, alph[42], '{'..alph[42]..'} '),
		vobj(43, alph[43], '{'..alph[43]..'} '),
		vobj(44, 'Пробел', '{Пробел} '),
		vobj(45, 'Пробел', '{Backspace}'),
	},
	act = function(s, w)
		if string.len(search_string._search_str) < 60 then
			if w == 44 then
				search_string._search_str = search_string._search_str..' ';
				return 'Клавиша «Пробел».';--..string.len(search_string._search_str);
			elseif w == 45 then
				if search_string._search_str ~= '' then
					if search_string._search_str:byte(search_string._search_str:len()) >= 128 then
						search_string._search_str = search_string._search_str:sub(1, search_string._search_str:len() - 2);
					else
						search_string._search_str = search_string._search_str:sub(1, search_string._search_str:len() - 1);
					end
				end
				return 'Клавиша «Backspace».';
			else
				search_string._search_str = search_string._search_str..alph[w];
				return 'Клавиша «'..alph[w]..'».';--..string.len(search_string._search_str)
			end
		else
			return [[В строке поиска слишком много символов. Может,
очистить?]];
		end
	end,
};

--строка поиска
search_string = obj {
	nam = 'строка поиска',
	dsc = function(s)
		return [[Поиск: «]]..s._search_str..img('img/cursor.gif')..[[»]];
	end,
	_search_str = '',
};

--Браузер
browser_in = room {
	nam = 'Браузер',
	dsc = [[На экране окно браузера. Можно полазить в интернете.
Для этого нужно ввести в поле «Поиск» ключевые слова для поиска через
пробел, а затем нажать «Найти».]],
	obj = {
		'search_string',
		vobj(1, 'Найти', '^{Найти} '),
		vobj(2, 'Очистить', '/ {Очистить}'),
		'keyboard'
	},
	way = {'computer_in'},
	act = function(s, w)
		if w == 1 then
			if me()._is_day_m and string.find(search_string._search_str, 'взлом') ~= nil and
				string.find(search_string._search_str, 'домофон') ~= nil then
				if not have('instruction1') then
					inv():add('instruction1');
					set_sound('snd/printer.ogg');
					return 'Я нашёл статью по взлому домофона и распечатал её.';
				else
					return 'Я нашёл статью по взлому домофона. Такую же я уже распечатал.';
				end
			elseif me()._is_day_m and string.find(search_string._search_str, 'отмычка') ~= nil and
				string.find(search_string._search_str, 'подъезд') ~= nil then
				if not have('instruction2') then
					inv():add('instruction2');
					set_sound('snd/printer.ogg');
					return 'Я нашёл статью по изготовлению отмычки для двери подъезда и распечатал её.';
				else
					return 'Я нашёл статью по изготовлению отмычки для двери подъезда. Её я уже распечатал.';
				end
			elseif search_string._search_str == '' or
				search_string._search_str == ' ' then
				return [[Необходимо ввести ключевые слова для поиска.]];
			else
				local search_st1 = {'Жирный серый',
'Исчезнувший и появившийся',
'Меркантильная',
'Серебристый ветряной',
'Пожирневший',
'Унылая белая',
'Гравием обложил',
'Споря с тренером по борьбе,',
'Выходя из спортзала,',
'Как мстил',
'Утром',
'Вспоминал',
'Можно ли',
'Бывший',
'Как стал',};
				local search_st2 = {'в домашних условиях',
'и зелёнка',
'была покрашена',
'утоплен и отремонтирован',
'замаскирован под НЛО',
'молниеносно одобрен',
'дружно живя',
'нахамя репетитору по французскому',
'угнал автомобиль Стива Джобса',
'и дети',
'и ПК',
'безопасен',
'чувствует безразличность',
'отучен плакать',
'к другим млекопитающим',
'в деревне',
'на свадьбе',};
				return [[Найдена статья: «]]..search_st1[rnd(#search_st1)]..' '
..txtb(search_string._search_str)..' '..search_st2[rnd(#search_st2)]
..'». Чего только не выложат в интернете... В статье нет ничего интересного...';
			end
		elseif w == 2 then
			search_string._search_str = '';
			return 'Кнопка «Очистить».';
		end
	end,
	enter = function(s, f)
		if f == 'computer_in' then
			return 'Я запустил браузер.';
		end
	end,
	exit = function(s, t)
		search_string._search_str = '';
		if t == 'computer_in' then
			return 'Я закрыл браузер.';
		end
	end,
	nomobil = true,
	pic = 'img/computer.png;img/desktop.png@48,34;img/browser.png@49,39',
};

--возв. кв. кота
qcat = obj {
	nam = 'возвращение квантового кота',
	dsc = '{игру «Возвращение квантового кота»}.',
	act = function()
		return walk('qcat_in');
	end,
};

--Возв. кв. кота
qcat_in = room {
	nam = 'Игра «Возвращение квантового кота»',
	dsc = function()
		p [[Это очень интересная игра. Мне она нравится. Я дошёл до
места, где нужно поставить ящики чтобы перелезть через забор института.^^]];
		if me()._was_in_yard_d111 then
			p [[Что-то подобное я сделал когда перелазил через забор
четырнадцатиэтажки.]];
		else
			p [[Хм... Может попробовать так перелезть через забор
четырнадцатиэтажки?]];
		end
	end,
	way = {'computer_in'},
	nomobil = true,
	pic = 'img/computer.png;img/desktop.png@48,34;img/qcat.png@65,39',
};

--скотч
scotch = obj {
	nam = img('img/icn_scotch.png')..'скотч',
	dsc = 'На краю лежит {скотч}.',
	tak = 'Я взял скотч.',
	inv = 'Прозрачный скотч. Можно что-нибудь склеить.',
};

--стол
my_table = obj {
	nam = 'стол',
	dsc = 'В углу стоит деревянный {стол}.',
	obj = {'computer', 'scotch'},
	act = [[Деревянный компьютерный стол. Именно поэтому на нём и стоит
компьютер.]],
};

--диван
sofa = obj {
	nam = 'диван',
	dsc = 'Напротив стола — {диван}.',
	act = function()
		if me()._is_hear_stepa and not me()._is_morning2 then
			return walk('sleep12');
		elseif me()._is_seen_79_band and not me()._is_morning3 then
			return walk('sleep23');
		else
			return [[Удобный диван. Я на нём сплю. Но сейчас не время
спать.]];
		end
	end,
};

--Квартира ГГ
my_apartment = room {
	nam = function()
		if here() ~= computer_in then
			return 'Комната Максима';
		else
			return 'Отойти';
		end
	end,
	dsc = 'Я в своей комнате.',
	act = function(s, w)
		if w == 1 then
			return [[Мягкое кресло. Сверху клетчатая накидка. Гостям на
нём удобно сидеть. Однажды на него пролили воду. Хорошо, что это была
просто вода.]];
		end
	end,
	obj = {'my_table',
		vobj(1, 'кресло', 'В углу комнаты стоит {кресло}.'),
		'sofa'},
	way = {'partition'},
	enter = function(s, f)
		if f == 'partition' then
			return 'Я вошёл в квартиру, и сразу пошёл в свою комнату.';
		end
	end,
	pic = function()
		pr 'img/my_apartment.png;';
		if seen('home_tools') then
			pr 'img/home_tools.png@230,105';
		end
	end,
};

--дверь в кв. Степана
stepa_apartment_door = obj {
	nam = 'дверь',
	dsc = 'Напротив расположена {дверь} в квартиру Степана.',
	act = function()
		if not memo._is_memo1 then
			memo._is_memo1 = true;
		end
		if me()._is_seen_d111human and me()._is_read_intro
			and not me()._is_hear_stepa
			and not partition._no_stepan_speak then
			me()._is_hear_stepa = true;
			return walk('scn_stepatalk');
		else
			return 'Лучше его не тревожить.';
		end
	end,
};

--Перегородка
partition = room {
	nam = 'Перегородка',
	dsc = 'Это наша перегородка.',
	obj = {'my_apartment_door', 'stepa_apartment_door'},
	way = {'d73level2'},
	enter = function(s, f)
		if s._no_stepan_speak then
			s._no_stepan_speak = false;
		end
		if f == 'd73level2' then
			p 'Я открыл дверь и вошёл в перегородку.';
		end
		if me()._is_seen_d111human and me()._is_read_intro
			and not me()._is_hear_stepa then
			p 'Я слышу голос Степана из его двери.';
			set_sound('snd/stepan.ogg');
		end
	end,
	pic = 'img/partition.png',
	_no_stepan_speak = false, --не слышен голос Степана
};

--2-й этаж
d73level2 = room {
	nam = function(s)
		if here() == partition then
			return 'Выход';
		else
			return set_lev_title(s, 'Этаж 2');
		end
	end,
	dsc = [[Я нахожусь на своём этаже. Тут моя квартира.]],
	way = {'d73level12', 'd73level23'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'partition_doors'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	enter = function()
		me()._dom = 73;
		me()._pod = 1;
	end,
	pic = function()
		pr 'img/level73.png;img/gr05.png@339,54';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--2-3 этаж
d73level23 = room {
	nam = lev_title('Площадка между этажами 2-3'),
	dsc = [[Я нахожусь на площадке между этажами 2-3.]],
	way = {'d73level2', 'd73level3'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr273.png@219,114;img/gr01.png@128,46',
};

--3 этаж
d73level3 = room {
	nam = lev_title('Этаж 3'),
	dsc = [[Я нахожусь на этаже 3.]],
	way = {'d73level23', 'd73level34'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/elevator_key3.png@197,113;img/gr06.png@307,75';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--3-4 этаж
d73level34 = room {
	nam = lev_title('Площадка между этажами 3-4'),
	dsc = [[Я нахожусь на площадке между этажами 3-4.]],
	way = {'d73level3', 'd73level4'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr373.png@219,114',
};

--4 этаж
d73level4 = room {
	nam = lev_title('Этаж 4'),
	dsc = [[Я нахожусь на этаже 4.]],
	way = {'d73level34', 'd73level45'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--4-5 этаж
d73level45 = room {
	nam = lev_title('Площадка между этажами 4-5'),
	dsc = [[Я нахожусь на площадке между этажами 4-5.]],
	obj = {'chute2'},
	way = {'d73level4', 'd73level5'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr473.png@219,114',
};

--5 этаж
d73level5 = room {
	nam = lev_title('Этаж 5'),
	dsc = [[Я нахожусь на этаже 5.]],
	way = {'d73level45', 'd73level56'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/elevator_key5.png@195,111;img/gr04.png@312,107';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--5-6 этаж
d73level56 = room {
	nam = lev_title('Площадка между этажами 5-6'),
	dsc = [[Я нахожусь на площадке между этажами 5-6.]],
	way = {'d73level5', 'd73level6'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr573.png@219,114',
};

--6 этаж
d73level6 = room {
	nam = lev_title('Этаж 6'),
	dsc = [[Я нахожусь на этаже 6.]],
	way = {'d73level56', 'd73level67'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/gr07.png@171,60';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--6-7 этаж
d73level67 = room {
	nam = lev_title('Площадка между этажами 6-7'),
	dsc = [[Я нахожусь на площадке между этажами 6-7.]],
	way = {'d73level6', 'd73level7'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr673.png@219,114',
};

--7 этаж
d73level7 = room {
	nam = lev_title('Этаж 7'),
	dsc = [[Я нахожусь на этаже 7.]],
	way = {'d73level67', 'd73level78'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/elevator_key7.png@196,114';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--7-8 этаж
d73level78 = room {
	nam = lev_title('Площадка между этажами 7-8'),
	dsc = [[Я нахожусь на площадке между этажами 7-8.]],
	way = {'d73level7', 'd73level8'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr773.png@219,114',
};

--8 этаж
d73level8 = room {
	nam = lev_title('Этаж 8'),
	dsc = [[Я нахожусь на этаже 8.]],
	way = {'d73level78', 'd73level89'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/elevator_key3.png@197,113;img/gr01.png@350,75';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--8-9 этаж
d73level89 = room {
	nam = lev_title('Площадка между этажами 8-9'),
	dsc = [[Я нахожусь на площадке между этажами 8-9.]],
	way = {'d73level8', 'd73level9'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr873.png@219,114',
};

--9 этаж
d73level9 = room {
	nam = lev_title('Этаж 9'),
	dsc = [[Я нахожусь на этаже 9.]],
	way = {'d73level89'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_attic'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	pic = function()
		pr 'img/level73.png;img/level9.png@1,15';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};
--к73-1-----------------------------------------------------------------

--77-1------------------------------------------------------------------
--кнопки
d77p1l1 = obj {
	nam = '1',
	dsc = '{1},',
	act = function()
		return walk('d77p1level1');
	end,
};

d77p1l2 = obj {
	nam = '2',
	dsc = '{2},',
	act = function()
		return walk('d77p1level2');
	end,
};

d77p1l3 = obj {
	nam = '3',
	dsc = '{3},',
	act = function()
		return walk('d77p1level3');
	end,
};

d77p1l4 = obj {
	nam = '4',
	dsc = '{4},',
	act = function()
		return walk('d77p1level4');
	end,
};

d77p1l5 = obj {
	nam = '5',
	dsc = '{5},',
	act = function()
		return walk('d77p1level5');
	end,
};

d77p1l6 = obj {
	nam = '6',
	dsc = '{6},',
	act = function()
		return walk('d77p1level6');
	end,
};

d77p1l7 = obj {
	nam = '7',
	dsc = '{7},',
	act = function()
		return walk('d77p1level7');
	end,
};

d77p1l8 = obj {
	nam = '8',
	dsc = '{8},',
	act = function()
		return walk('d77p1level8');
	end,
};

d77p1l9 = obj {
	nam = '9',
	dsc = '{9},',
	act = function()
		return walk('d77p1level9');
	end,
};

d77p1stop = obj {
	nam = 'стоп',
	dsc = '{Стоп},',
	act = 'Никакого эффекта.'
};

d77p1call_disp = obj {
	nam = 'вызов',
	dsc = '{Вызов} диспетчера.',
	act = 'Никакого эффекта.',
};

--панель кнопок в лифте
d77p1elevator_panel = obj {
	nam = 'панель',
	dsc = 'Здесь расположена {панель} с кнопками:',
	act = 'Грязная, старая панель с кнопками.',
	obj = {'d77p1l1', 'd77p1l2', 'd77p1l3', 'd77p1l4', 'd77p1l5', 'd77p1l6', 'd77p1l7', 'd77p1l8', 'd77p1l9', 'd77p1stop', 'd77p1call_disp'},
};

--Лифт
d77p1elevator = room {
	nam = lev_title('Лифт'),
	dsc = 'Я в лифте.',
	obj = {'d77p1elevator_panel'},
	exit = function()
		set_sound('snd/elevator_close.ogg');
	end,
	pic = 'img/elevator.png',
};

--1-й этаж
d77p1level1 = room {
	nam = lev_title('Этаж 1'),
	dsc = [[Я нахожусь на этаже 1.]],
	way = {'d77', 'd77p1level12'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'hatch_basement'},
	enter = function(s, f)
		if f == 'd77p1door' then
			me()._dom = 77;
			me()._pod = 1;
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
d77p1level12 = room {
	nam = lev_title('Площадка между этажами 1-2'),
	dsc = [[Я нахожусь на площадке между этажами 1-2.]],
	way = {'d77p1level1', 'd77p1level2'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr1.png@219,114',
};

--2-й этаж
d77p1level2 = room {
	nam = lev_title('Этаж 2'),
	dsc = [[Я нахожусь на этаже 2.]],
	way = {'d77p1level12', 'd77p1level23'},
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
d77p1level23 = room {
	nam = lev_title('Площадка между этажами 2-3'),
	dsc = [[Я нахожусь на площадке между этажами 2-3.]],
	way = {'d77p1level2', 'd77p1level3'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr2.png@219,114;img/gr01.png@128,46',
};

--3 этаж
d77p1level3 = room {
	nam = lev_title('Этаж 3'),
	dsc = [[Я нахожусь на этаже 3.]],
	way = {'d77p1level23', 'd77p1level34'},
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
d77p1level34 = room {
	nam = lev_title('Площадка между этажами 3-4'),
	dsc = [[Я нахожусь на площадке между этажами 3-4.]],
	way = {'d77p1level3', 'd77p1level4'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr3.png@219,114',
};

--4 этаж
d77p1level4 = room {
	nam = lev_title('Этаж 4'),
	dsc = [[Я нахожусь на этаже 4.]],
	way = {'d77p1level34', 'd77p1level45'},
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
d77p1level45 = room {
	nam = lev_title('Площадка между этажами 4-5'),
	dsc = [[Я нахожусь на площадке между этажами 4-5.]],
	obj = {'chute2'},
	way = {'d77p1level4', 'd77p1level5'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr4.png@219,114',
};

--5 этаж
d77p1level5 = room {
	nam = lev_title('Этаж 5'),
	dsc = [[Я нахожусь на этаже 5.]],
	way = {'d77p1level45', 'd77p1level56'},
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
d77p1level56 = room {
	nam = lev_title('Площадка между этажами 5-6'),
	dsc = [[Я нахожусь на площадке между этажами 5-6.]],
	way = {'d77p1level5', 'd77p1level6'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr5.png@219,114',
};

--6 этаж
d77p1level6 = room {
	nam = lev_title('Этаж 6'),
	dsc = [[Я нахожусь на этаже 6.]],
	way = {'d77p1level56', 'd77p1level67'},
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
d77p1level67 = room {
	nam = lev_title('Площадка между этажами 6-7'),
	dsc = [[Я нахожусь на площадке между этажами 6-7.]],
	way = {'d77p1level6', 'd77p1level7'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr6.png@219,114',
};

--7 этаж
d77p1level7 = room {
	nam = lev_title('Этаж 7'),
	dsc = [[Я нахожусь на этаже 7.]],
	way = {'d77p1level67', 'd77p1level78'},
	obj = {'elevator_door', 'elevator_key', 'bells'},
	exit = function()
		me()._elevator_key_pressed = false;
	end,
	enter = function()
		if me()._is_seen_stepan_run then
			return [[Я видел, что Степан поднялся наверх. Значит, остальные
члены банды скорее всего где-то внизу. Лучше не спускаться вниз.]], false;
		end
	end,
	pic = function()
		pr 'img/level.png;img/elevator_key7.png@196,114;img/gr01.png@322,35';
		if me()._elevator_key_pressed then
			pr ';img/elevator_open.png@217,58';
		end
	end,
};

--7-8 этаж
d77p1level78 = room {
	nam = lev_title('Площадка между этажами 7-8'),
	dsc = [[Я нахожусь на площадке между этажами 7-8.]],
	way = {'d77p1level7', 'd77p1level8'},
	obj = {'chute1'},
	pic = 'img/levelp.png;img/tr1.png@57,0;img/gr7.png@219,114',
};

--8 этаж
d77p1level8 = room {
	nam = function(s)
		if deref(here()) == 'dima_corridor' then
			return 'Выход';
		else
			return set_lev_title(s, 'Этаж 8');
		end
	end,
	dsc = [[Я нахожусь на этаже 8.]],
	way = {'d77p1level78', 'd77p1level89'},
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
d77p1level89 = room {
	nam = lev_title('Площадка между этажами 8-9'),
	dsc = [[Я нахожусь на площадке между этажами 8-9.]],
	way = {'d77p1level8', 'd77p1level9'},
	obj = {'chute2'},
	pic = 'img/levelp.png;img/tr2.png@57,0;img/gr8.png@219,114',
};

--люк на чердак 77-1
d77p1_hatch_attic = obj {
	nam = 'люк на чердак',
	dsc = function(s)
		p [[Вверху есть {люк}, ведущий на чердак.]];
		if me()._is_seen_stepan_run and not s.obj:look('hatch_lock') then
			p [[Похоже, люк открыт.]];
		end
	end,
	act = function(s)
		if me()._is_seen_stepan_run then
			if s.obj:look('hatch_lock') then
				return [[На люке навесной замок.]];
			else
				return [[Люк открыт. Наверное его открыл Степан.]];
			end
		else
			return [[Люк закрыт на навесной замок.]];
		end
	end,
};

--9 этаж
d77p1level9 = room {
	nam = lev_title('Этаж 9'),
	dsc = [[Я нахожусь на этаже 9.]],
	way = {'d77p1level89'},
	obj = {'elevator_door', 'elevator_key', 'bells', 'd77p1_hatch_attic'},
	exit = function()
		me()._elevator_key_pressed = false;
		enable('label_gl1');
	end,
	pic = function()
		pr 'img/level.png;img/level9.png@1,15;';
		if me()._elevator_key_pressed then
			pr 'img/elevator_open.png@217,58;';
		end
		if seen('label_gl1') then
			pr 'img/gl1label.png@225,81';
		end
	end,
};
--к77-1-----------------------------------------------------------------

input.click = function(s, press, mb, x, y, px, py)
	if press and px then
		--кликабельная карта двора
		if here() == yard then
			if px > 208 and px < 247 and py > 247 and py < 281 then
				walk('d71');
				return "look";
			elseif px > 177 and px < 208 and py > 252 and py < 284 then
				walk('d73');
				return "look";
			elseif px > 143 and px < 174 and py > 244 and py < 276 then
				walk('d77');
				return "look";
			elseif px > 113 and px < 142 and py > 249 and py < 283 then
				walk('d79');
				return "look";
			elseif px > 61 and px < 109 and py > 244 and py < 283 then
				walk('d838587');
				return "look";
			elseif px > 50 and px < 95 and py > 190 and py < 232 then
				walk('d838587');
				return "look";
			elseif px > 23 and px < 56 and py > 234 and py < 260 then
				walk('d838587');
				return "look";
			elseif px > 227 and px < 271 and py > 135 and py < 238 then
				walk('d130134');
				return "look";
			elseif px > 226 and px < 267 and py > 15 and py < 123 then
				walk('d130134');
				return "look";
			elseif px > 80 and px < 116 and py > 129 and py < 181 then
				walk('d111');
				return "look";
			end
		end
	end
end

--Карта
yard = room {
	nam = 'Двор',
	dsc = function()
		if me()._is_day_m then
			return [[Лето проходит. Уже не так жарко, как было раньше.]];
		elseif me()._is_morning3 then
			return [[Сегодня пасмурно. Но всё же ощущается летняя погода.]];
		elseif me()._is_morning2 then
			if not me()._is_seen_labelvved then
				return [[Раннее утро на улице. Уже почти рассвело.
Немного прохладно...]];
			else
				return [[Улица... Лето... И солнце! Птички поют...]];
			end
		else
			if me()._is_hear_stepa then
				return [[Уже вечер. И меня клонит ко сну.]];
			else
				return [[Улица... Лето... Немного облачно. Но солнечные
лучи пробиваются сквозь облака. Лёгкий ветер колышет деревья.]];
			end
		end
	end,
	way = {'d71', 'd73', 'd77', 'd79', 'd838587', 'd130134', 'd111'},
	exit = function(s, t)
		if me()._is_seen_gl12 and not (me()._is_cat_agree or me()._is_cat_discard) then
			if t ~= 'mobil_tel_in' and t ~= 'mob_dima_dlg' then --чтобы снова не вкл. если отвечаем на звонок с карты
				lifeon('telephone_dima');
			end
		end
	end,
	pic = function()
		pr 'img/yard.png;';
		if ways():look('garages') then
			pr 'img/yard_garages.png@188,136';
		end
	end,
};

--71-1
d71p1 = obj {
	nam = 'дверь',
	dsc = 'С левой стороны находится {дверь} в 1-й подъезд.',
	act = function()
		return walk('d71p1door');
	end,
};

--71-2
d71p2 = obj {
	nam = 'дверь',
	dsc = 'Справа — {дверь} во 2-й подъезд.',
	act = function()
		return walk('d71p2door');
	end,
};

--71
d71 = room {
	nam = function()
		if here() == d71p1level1 or here() == d71p2level1 then
			return 'Выход';
		elseif here() == d71p1door or here() == d71p2door then
			return 'Отойти';
		else
			return 'Дом 71';
		end
	end,
	dsc = 'Я нахожусь во дворе 71-го дома.',
	way = {'yard'},
	obj = {'d71p1', 'd71p2'},
	enter = music('snd/yard1.ogg'),
	pic = 'img/d7n1.png',
};

--замок двери подъезда 73-1
d73p1lock = obj {
	nam = 'замок',
	dsc = 'Дверь закрыта на {замок}. Нужен ключ.',
	act = 'Нужен ключ. Конечно, можно подождать кого-то. Но я ненавижу ждать.',
	used = function(s, w)
		if w == 'home_key' then
			return walk('d73level1');
		elseif w == 'fake_key' then
			return [[Хм... У меня есть ключи вообще-то.]];
		end
	end,
};

--Дверь 73-1
d73p1door = room {
	nam = 'Дверь (д.73, п.1)',
	dsc = 'Передо мной зелёная дверь. Моя квартира в этом подъезде.',
	obj = {'d73p1lock'},
	way = {'d73'},
	pic = 'img/d73p1door.png',
};

--замок двери подъезда 73-2
d73p2lock = obj {
	nam = 'замок',
	dsc = 'Дверь закрыта на {замок}. Нужен ключ.',
	act = 'Нужен ключ. Конечно, можно подождать кого-то. Но я ненавижу ждать.',
	used = function(s, w)
		if w == 'home_key' then
			return [[Эти ключи не подойдут.]];
		elseif w == 'fake_key' then
			return [[Не время шастать по ненужным подъездам.]];
		end
	end,
};

--Дверь 73-2
d73p2door = room {
	nam = 'Дверь (д.73, п.2)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d73p2lock'},
	way = {'d73'},
	pic = 'img/d73p2door.png',
};

--73-1
d73p1 = obj {
	nam = 'дверь',
	dsc = 'С левой стороны находится {дверь} в 1-й подъезд.',
	act = function()
		return walk('d73p1door');
	end,
};

--73-2
d73p2 = obj {
	nam = 'дверь',
	dsc = 'Справа — {дверь} во 2-й подъезд.',
	act = function()
		return walk('d73p2door');
	end,
};

--73
d73 = room {
	nam = function()
		if here() == d73level1 then
			return 'Выход';
		elseif here() == d73p1door or here() == d73p2door then
			return 'Отойти';
		else
			return 'Дом 73';
		end
	end,
	dsc = 'Я нахожусь во дворе 73-го дома. В этом доме моя квартира.',
	way = {'yard'},
	obj = {'d73p1', 'd73p2'},
	enter = music('snd/yard1.ogg'),
	pic = 'img/d7n2.png',
};

--поле ввода домофона
dphone_string = obj {
	nam = 'ввод',
	dsc = function(s)
		return [[^^Ввод: «]]..s._dphone_str..img('img/d_cursor.gif')..[[»]];
	end,
	_dphone_str = '',
};

dphone_kd = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
	'*', '#', 'Вызов', 'Сброс'};

--домофон двери подъезда 77-1
d77p1lock = obj {
	nam = 'домофон',
	dsc = 'Дверь закрыта. На ней {домофон}. Нужен ключ. Либо можно кому-то позвонить.',
	act = function(s, w)
		if w == nil then
			return [[Это домофон. Марка «Lendas».]];
		else
			if string.len(dphone_string._dphone_str) < 12 then
				if w == 13 then
					--if dphone_string._dphone_str == '*154#2222#' then
					--	return walk('d79p2level1');
					if string.len(dphone_string._dphone_str) == 2 then
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

--Дверь 77-1
d77p1door = room {
	nam = 'Дверь (д.77, п.1)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d77p1lock'},
	way = {'d77'},
	exit = function()
		dphone_string._dphone_str = '';
	end,
	pic = 'img/d77p1door.png',
};

--77-1
d77p1 = obj {
	nam = 'дверь',
	dsc = 'С левой стороны находится {дверь} в 1-й подъезд.',
	act = function()
		if me()._is_cat_agree and not me()._have_key_771_31 then
			return walk('scn_dimakeygive');
		else
			return walk('d77p1door');
		end
	end,
};

--домофон двери подъезда 77-2, 79-1
d77p2d79p1lock = obj {
	nam = 'домофон',
	dsc = 'Дверь закрыта. На ней {домофон}. Нужен ключ. Либо можно кому-то позвонить.',
	act = function(s, w)
		if w == nil then
			return [[Это домофон. Марка «Lendas».]];
		else
			if string.len(dphone_string._dphone_str) < 12 then
				if w == 13 then
					--if dphone_string._dphone_str == '*154#2222#' then
					--	return walk('d79p2level1');
					if me()._is_morning2 and
						not me()._is_seen_labelvved and
						deref(here()) == 'd79p1door' then
						if dphone_string._dphone_str == '12' then
							return [[Кажется, они не отвечают. А почему у них тогда свет горит?!]];
						elseif dphone_string._dphone_str == '24' then
							return walk('d79p1dphone_dlg');
						elseif string.len(dphone_string._dphone_str) == 2 then
							return [[Не отвечают.]];
						else
							return [[Ошибка.]];
						end
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

--Дверь 77-2
d77p2door = room {
	nam = 'Дверь (д.77, п.2)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d77p2d79p1lock'},
	way = {'d77'},
	exit = function()
		dphone_string._dphone_str = '';
	end,
	pic = 'img/d77p2door.png',
};

--77-2
d77p2 = obj {
	nam = 'дверь',
	dsc = 'Справа — {дверь} во 2-й подъезд.',
	act = function()
		return walk('d77p2door');
	end,
};

--77
d77 = room {
	nam = function()
		if here() == d77p1level1 then
			return 'Выход';
		elseif here() == d77p1door or here() == d77p2door then
			return 'Отойти';
		else
			return 'Дом 77';
		end
	end,
	dsc = 'Я нахожусь во дворе 77-го дома.',
	way = {'yard'},
	obj = {'d77p1', 'd77p2'},
	enter = function()
		set_music('snd/yard1.ogg');
		if not me()._peace and me()._is_read_gl2true then
			return walk('scn_stepanivan');
		end
	end,
	pic = 'img/d7n1.png',
};

--домофон двери подъезда 79-2
d79p2lock = obj {
	nam = 'домофон',
	dsc = 'Дверь закрыта. На ней {домофон}.',
	act = function(s, w)
		if w == nil then
			return [[Это домофон. Марка «Lendas».]];
		else
			if string.len(dphone_string._dphone_str) < 12 then
				if w == 13 then
					--if dphone_string._dphone_str == '*154#2222#' then
					--	return walk('d79p2level1');
					if me()._is_morning2 and
						not me()._is_seen_labelvved then
						if dphone_string._dphone_str == '53' then
							return walk('dphone792_dlg');
						end
					end
					if string.len(dphone_string._dphone_str) == 2 then
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

--табличка с номерами квартир
d79p2_flats_label = obj {
	nam = 'табличка',
	dsc = [[Над дверью висит {табличка} с номерами квартир в этом
подъезде.]],
	act = [[На табличке написано:^
«Д.79, п.2^
Кв. 37-72»]],
};

--Дверь 79-2
d79p2door = room {
	nam = 'Дверь (д.79, п.2)',
	dsc = 'Передо мной зелёная дверь.',
	obj = {'d79p2_flats_label', 'd79p2lock'},
	way = {'d79'},
	exit = function()
		dphone_string._dphone_str = '';
	end,
	pic = 'img/d79p2door.png',
};

--Дверь 79-1
d79p1door = room {
	nam = 'Дверь (д.79, п.1)',
	dsc = 'Передо мной серая дверь.',
	obj = {'d77p2d79p1lock'},
	way = {'d79'},
	exit = function()
		dphone_string._dphone_str = '';
	end,
	pic = 'img/d79p1door.png',
};

--79-1
d79p1 = obj {
	nam = 'дверь',
	dsc = 'С левой стороны находится {дверь} в 1-й подъезд.',
	act = function()
		return walk('d79p1door');
	end,
};

--79-2
d79p2 = obj {
	nam = 'дверь',
	dsc = 'Справа — {дверь} во 2-й подъезд.',
	act = function()
		if me()._is_seen_human2 and not me()._is_seen_79_band then
			return [[В этом подъезде сейчас орудует банда
лифто-маньяков. Лучше потом вернуться.]];
		else
			return walk('d79p2door');
		end
	end,
};

--79
d79 = room {
	nam = function()
		if here() == d79p2level1 then
			return 'Выход';
		elseif here() == d79p1door or here() == d79p2door then
			return 'Отойти';
		else
			return 'Дом 79';
		end
	end,
	dsc = function()
		p 'Я нахожусь во дворе 79-го дома.';
		if me()._is_morning2 and not me()._is_seen_labelvved then
			p [[Сейчас раннее утро, но в некоторых квартирах горит свет.
В квартире 1-го подъезда на 3-м этаже справа и на 6-м тоже справа. 
Во 2-м подъезде только на 5-м этаже слева.]];
		end
	end,
	way = {'yard'},
	obj = {'d79p1', 'd79p2'},
	enter = function()
		if me()._is_read_gl1 and me()._is_read_gl2 and me()._have_key_771_31 and not me()._is_seen_79_band then
			return walk('scn_d79band');
		end
		set_music('snd/yard1.ogg');
	end,
	pic = 'img/d7n2.png',
};

--Дома 83, 85, 87
d838587 = room {
	nam = 'Дома 83/85/87',
	dsc = [[Я нахожусь во дворе домов 83, 85, 87. В одном из домов
живёт Лена. Поэтому лучше я не буду много бегать здесь.]],
	way = {'yard'},
	enter = function()
		if me()._is_morning2 and me()._lena_talk2 and not me()._lena_meet then
			return walk('scn_lenameet');
		end
	end,
	pic = 'img/d838587.png',
};

--Дома 130, 134
d130134 = room {
	nam = 'Дома 130/134',
	dsc = [[Я недалеко от домов 130, 134. В одном из этих домов живёт
моя бабушка. Лучше я ближе подходить не буду. Если она меня увидит,
то мне придётся идти к ней в гости на пол дня. Только не сейчас...^^
А потом я обязательно схожу, это я обещаю...]],
	way = {'yard'},
	pic = 'img/d130134.png',
};

--проход
d111passage = obj {
	nam = 'проход',
	dsc = 'В заборе есть закрытый с внутренней стороны {проход}.',
	act = function()
		if me()._is_seen_d111stepan then
			return [[Я попробовал оттолкнуть всякое барахло, закрывающее
проход. Безрезультатно... Что-то держит его с внутренней стороны.]];
		else
			return [[Мне, конечно, интересно побывать за забором. Но не
настолько чтобы туда лезть.]];
		end
	end,
};

--забор четырнадцатиэтажки
d111fence = obj {
	nam = 'забор',
	dsc = 'Передо мной бетонный {забор}.',
	obj = {vobj(1, 'надпись', 'На нём {надпись}.')},
	act = function(s, w)
		if w == 1 then
			return [[«Проникновение на территорию строго запрещено».
Интересно кем?]];
		elseif not s._seen then
			s.obj:add('d111passage');
			s._seen = true;
		end
		return [[Интересно... Две соседние плиты забора раздолблены так, что
образовался проход. Но с внутренней стороны какие-то обломки его
закрывают.]];
	end,
	_seen = false,
};

--здание 14-ти-эт.
d111build = obj {
	nam = 'четырнадцатиэтажка',
	dsc = 'За забором возвышается {здание четырнадцатиэтажки}.',
	act = [[Выглядит четырнадцатиэтажка мрачновато. Вся обшарпанная,
окна выбиты... или сняты.]],
};

--111
d111 = room {
	nam = function(s)
		if here() == s then
			return 'Дом 111 (четырнадцатиэтажка)';
		elseif deref(here()) == 'west_side' or deref(here()) == 'east_side' then
			return 'Южная сторона';
		else
			return 'Дом 111';
		end
	end,
	dsc = [[Я нахожусь возле 111-го дома — чертынадцатиэтажки. Это
«дом-призрак». Из-за того, что он был построен не совсем правильно, он со
временем начал клониться к земле. Именно поэтому людей, живших в нём,
переселили в другую (построенную к тому времени) четырнадцатиэтажку.
Чтобы никто не лез вовнутрь, это здание обнесли бетонным забором.]],
	obj = {'d111fence', 'd111build'},
	way = {'yard', 'west_side', 'east_side'},
	exit = function(s, t)
		if not me()._is_seen_d111stepan then
			--если уходит с данной локации
			if photo._is_photo1 and t == 'yard' then
				me()._is_seen_d111stepan = true;
				return walk('scn_d111stepan');
			end
		end
	end,
	pic = 'img/d111.png;img/d111map.png;img/pl_t.png@48,159',
};

--забор с восточной стороны
esfence = obj {
	nam = 'забор',
	dsc = [[Слева от меня бетонный {забор}, закрывающий здание
четырнадцатиэтажки.]],
	act = 'Забор цел, в нём нет каких-либо пробоин или щелей.',
};

--дорожка
small_way = obj {
	nam = 'дорожка',
	dsc = [[Справа протоптаная {дорожка} вдоль забора.]],
	act = [[Видимо, люди по дорожке ходят к свалке и диспетчерскому
пункту, которые находятся чуть дальше.]],
};

--Восточная сторона
east_side = room {
	nam = function(s)
		if here() == s then
			return 'Восточная сторона (Дом 111)';
		else
			return 'Восточная сторона';
		end
	end,
	dsc = [[Я нахожусь возле восточной стороны четырнадцатиэтажки.]],
	obj = {'esfence', 'small_way'},
	way = {'d111', 'north_side', 'dipetch'},
	pic = 'img/east_side.png;img/d111map.png;img/pl_t.png@99,146',
};

--забор с западной стороны
wsfence = obj {
	nam = 'забор',
	dsc = [[Справа от меня бетонный {забор}, закрывающий здание
четырнадцатиэтажки.]],
	act = 'Забор цел, в нём нет каких-либо пробоин или щелей.',
};

--Западная сторона
west_side = room {
	nam = function(s)
		if here() == s then
			return 'Западная сторона (Дом 111)';
		else
			return 'Западная сторона';
		end
	end,
	dsc = [[Я нахожусь возле западной стороны четырнадцатиэтажки.]],
	obj = {'wsfence'},
	way = {'d111', 'north_side'},
	pic = 'img/west_side.png;img/d111map.png;img/pl_t.png@6,146',
};

--записка Введение
note_intro = obj {
	nam = function()
		pr(img('img/note_intro.png'));
		if me()._is_read_intro then
			pr '«Введение»';
		else
			pr 'бумага';
		end
	end,
	inv = function()
		me()._is_read_intro = true;
		--если прочитал Введение в перегородке, то ещё не слышен
		--голос Степана
		partition._no_stepan_speak = true;
		return [[Это бумага, найденная на свалке возле четырнадцатиэтажки.
Она была разорвана. Мне удалось склеить. Распечатана на принтере.
Тут написано:^^
«Введение. Смерть манекена^^
Манекен заходит в лифт на первом этаже. Поднимается на девятый. Но,
доехав до нужного этажа, он застряёт.^^
Затем приходит лифтёр. Он замечает странную надпись на дверях лифта:
«Введение. Смерть манекена.» Особого смысла он в ней не видит.^^
Лифтёр открывает двери лифта. Вдруг кабина вместе с манекеном летит
вниз. На первом этаже манекена встречает «Лифтёр». «Лифтёр» убивает
манекена и скрывается.^^
Когда же лифтёр с девятого этажа спускается, он
видит мёртвого манекена. Но что произошло не понимает.»^^
Бред какой-то... И почему есть просто лифтёр, и ещё лифтёр в кавычках?^^
Это только введение. Наверное написана целая повесть. Или она пишется?
Интересно было бы почитать другие части.]];
	end,
};

--клочки бумаги
parts_of_note = obj {
	nam = img('img/icn_parts_of_note.png')..'клочки бумаги',
	inv = [[Похоже, что эти клочки — это части одной бумаги. Если бы их
чем-то соединить...]],
	used = function(s, w)
		if w == 'scotch' then
			if here() ~= mobil_tel_in then
				if here() ~= partition then
					inv():del(s);
					inv():add('note_intro');
					return 'Получилось склеить в одну бумагу!';
				else
					return [[В перегородке это лучше не клеить.
Может выйти мой сосед Степан.]];
				end
			else
				return 'Нужно убрать мобильный телефон.';
			end
		end
	end,
	use = function(s, w)
		if w == 'scotch' then
			return 'Скотч... Точно!';
		end
	end,
};

--мусор
container_trash = obj {
	nam = 'мусор',
	dsc = [[Возле контейнеров лежит {мусор}, который я высыпал из одного
контейнера.]],
	act = function(s)
		if not s._seen then
			s._seen = true;
			return [[Копаться в мусоре?! Нет... Стоп. Я вижу в нём клочок
бумаги. Там написано: «Введение. Смерть манекена...» Может стоит ещё
посмотреть что там в мусоре?]];
		else
			if not have('parts_of_note') and not have('note_intro') then
				inv():add('parts_of_note');
				return [[Я порылся получше, и нашёл много таких клочков бумаги
с надписями. Все их я взял.]];
			else
				return [[Больше в мусоре нет ничего интересного.]];
			end
		end
	end,
	_seen = false,
};

--контейнеры
containers = obj {
	nam = 'контейнеры',
	dsc = '^^На свалке стоят полные {контейнеры} с мусором.',
	act = function()
		if not seen('container', 'north_side') then
			if me()._is_seen_d111stepan then
				if not have('container') then
					inv():add('container');
					if container._trash then
						p 'Я схватил руками контейнер с мусором.';
					else
						p 'Я схватил руками пустой контейнер.';
					end
				else
					p 'Я уже держу один контейнер.';
				end
			else
				p 'Грязные контейнеры, набитые мусором.';
			end
		else
			p 'Грязные контейнеры, набитые мусором. Но один мне помог!';
		end
		if me()._is_read_intro then
			p [[Подумал порыться в мусоре контейнеров чтобы поискать
остатки бумаг. Но их запах отбил у меня это желание. Тем более, что
даже если выбрасывали остатки бумаг, то они все разъелись под этим
мусором. Это те клочки были сверху, к тому же свежие. Поэтому их удалось
спасти.]];
		end
	end,
};

--контейнер
container = obj {
	nam = img('img/icn_container.png')..'контейнер',
	dsc = 'Под забором стоит перевёрнутый {контейнер}.';
	inv = function(s)
		if s._trash then
			return 'Я держу контейнер с мусором.';
		else
			return 'Я держу пустой контейнер.';
		end
	end,
	use = function(s, w)
		if w == 'heap' then
			if s._trash then
				north_side.obj:add('container_trash');
				s._trash = false;
				return 'Я высыпал мусор на свалку!';
			end
		elseif w == 'containers' then
			inv():del('container');
			return 'Я оставил пустой контейнер возле других контейнеров.';
		elseif w == 'nsfence' then
			if not cask._fence then
				if not s._trash then
					inv():del(s);
					north_side.obj:add(s, 2);
					return 'Я поставил пустой контейнер к забору.';
				else
					return [[Не выйдет. Контейнер тяжёлый, так как в нём
много мусора.]];
				end
			else
				return [[Под забором стоит бочка.]];
			end
		end
	end,
	tak = 'Я схватил контейнер.';
	_trash = true,
};

--бочка
cask = obj {
	nam = img('img/icn_cask.png')..'бочка',
	dsc = function(s)
		if deref(here()) == 'fence' then
			return [[Под забором, во дворе четырнадцатиэтажки, стоит
металлическая {бочка}.]];
		elseif not s._fence then
			return 'Возле контейнеров стоит пустая металлическая {бочка}.';
		else
			return 'Под забором стоит металлическая {бочка}.';
		end
	end,
	tak = function(s)
		s._fence = false;
		return 'Я взял бочку. Она совсем лёгкая.';
	end,
	inv = 'Лёгкая металлическая бочка.',
	use = function(s, w)
		if w == 'containers' then
			inv():del('cask');
			north_side.obj:add('cask');
			return 'Я оставил бочку возле контейнеров.';
		elseif w == 'heap' then
			return [[Выбрасывать бочку? Может тогда лучше поставить её
там, где она раньше стояла: у контейнеров?]];
		elseif w == 'ground111' then
			inv():del('cask');
			ground111.obj:add('cask');
			return [[Я поставил бочку с другой стороны забора.]];
		end
		if w == 'nsfence' then
			if me()._is_seen_d111stepan then
				if not seen('container') then
					s._fence = true;
					inv():del(s);
					north_side.obj:add(s, 2);
					return 'Я поставил бочку под забор.';
				else
					return 'Под забором стоит контейнер.';
				end
			else
				return [[Поставить то можно под забор. Только зачем?]];
			end
		end
	end,
	_fence = false,
};

--свалка
heap = obj {
	nam = 'ящики',
	dsc = 'Возле забора образовалась {свалка}.',
	obj = {'containers', 'cask'},
	act = [[Да... На свалке мусора много. Много водочных бутылок,
бутылок из-под пива. Бутылки либо пластиковые, либо разбитые. Видно,
целые бутылки забрали и сдали. Также полно порванных пакетов. Есть даже
одежда! Но она слишком разодрана.]],
};

--забор с северной стороны
nsfence = obj {
	nam = 'забор',
	dsc = [[Передо мной бетонный {забор}.]],
	obj = {vobj(1, 'надпись', 'На нём есть большая {надпись}.')},
	act = function(s, w)
		if w == 1 then
			return [[«Бросайте мусор в конт... Штраф...». Наверное
просят мусор выбрасывать в контейнеры, а то оштрафуют. Интересно,
кого-нибудь оштрафовали?]];
		elseif cask._fence or seen('container') then
			return walk('fence');
		else
			if me()._is_seen_d111stepan then
				return [[Забор цел, в нём нет каких-либо пробоин или
щелей. Если бы перелезть через него... Но как?]];
			else
				return [[Бетонный забор, закрывающий здание
четырнадцатиэтажки.]];
			end
		end
	end,
};

--Северная сторона
north_side = room {
	nam = function(s)
		if here() == s then
			return 'Северная сторона (Дом 111)';
		else
			return 'Северная сторона';
		end
	end,
	dsc = [[Я нахожусь возле северной стороны четырнадцатиэтажки.]],
	obj = {'nsfence', 'heap'},
	way = {'east_side', 'west_side'},
	exit = function(s, t)
		if have('container') and have('cask') and t ~= 'fence' then
			inv():del('container');
			inv():del('cask');
			north_side.obj:add('cask');
			return [[Я оставил контейнер и бочку возле других
контейнеров на свалке.]];
		elseif have('container') then
			inv():del('container');
			return [[Я оставил контейнер на свалке возле других
контейнеров.]];
		elseif have('cask') and t ~= 'fence'  then
			inv():del('cask');
			north_side.obj:add('cask');
			return [[Я оставил бочку возле контейнеров на свалке. Она
хоть и лёгкая, но большая.]];
		end
	end,
	enter = music('snd/yard1.ogg'),
	pic = function()
		pr 'img/north_side.png;img/d111map.png;img/pl_b.png@47,66;';
		if seen('container') then
			pr 'img/container_b.png@217,84;';
		elseif not have('container') then
			if container._trash then
				pr 'img/container.png@400,86;';
			else
				pr 'img/container_notr.png@400,86;';
			end
		end
		if seen('cask') then
			if cask._fence then
				pr 'img/cask.png@217,75;';
			else
				pr 'img/cask.png@434,114;';
			end
		end
		if seen('container_trash') then
			pr 'img/trash.png@222,126;';
		end
	end,
};

--Четырнадцатиэтажка и Степан
scn_d111stepan = room {
	nam = 'Четырнадцатиэтажка и Степан',
	dsc = [[Я только отошёл от четырнадцатиэтажки, как вдруг увидел
Степана. Да! Это был он. Он выходил из-под забора. Ему кто-то помог
выбраться. Что он там делал? Странно это.^^
Я проследил за ним. Он пошёл домой.]],
	obj = {vway('Продолжить', '{Продолжить}', 'd73')},
	enter = function(s)
		s._mus = get_music();
		set_music('snd/act1.ogg');
	end,
	exit = function(s)
		set_music(s._mus);
	end,
	nomobil = true,
	pic = 'img/scn_d111stepan.png',
};

--двор 14-тиэт.
to_yard111 = obj {
	nam = 'Перелезть во двор',
	dsc = '^^{Перелезть во двор}',
	act = function()
		if seen('cask') then
			walk('north_yard111');
			return 'Я перелез через забор во двор четырнадцатиэтажки.';
		else
			return [[Если я перелезу через забор, то как я вернусь
обратно? Я не смогу потом перелезть через этот высокий забор с
внутренней стороны. Нужно что-то придумать...]];
		end
	end,
};

--земля в 111
ground111 = obj {
	nam = 'земля',
	dsc = [[За забором {земля} двора четырнадцатиэтажки.]],
	act = [[На земле много камней.]],
};

--Забор (север)
fence = room {
	nam = 'Забор',
	dsc = function()
		if cask._fence then
			p [[Я залез на бочку.]];
		else
			p [[Я залез на контейнер.]];
		end
		p [[Теперь можно перелезть через забор во двор
четырнадцатиэтажки.]];
	end,
	obj = {'ground111', 'to_yard111',
		vway('Спуститься', '^{Спуститься}', 'north_side')},
	enter = function()
		if me()._is_seen_79_band then
			return [[Я теперь туда ни ногой! Там опасно!]], false;
		elseif me()._is_seen_gl12 then
			return [[Нет. Я туда не полезу. В любую минуту может
вернуться тот бугай.]], false;
		elseif me()._is_seen_d111human then
			if not me()._is_seen_human2 then
				return 'Думаю, лучше пока туда не соваться.', false;
			else
				return [[Пока что тот человек в 79-м доме. Надеюсь, за
забором никого нет.]];
			end
		end
	end,
	pic = function()
		pr 'img/fence.png;';
		if seen('cask') then
			pr 'img/cask_in.png@104,54;';
		end
		if seen('container', 'north_side') then
			pr 'img/container_f.png@76,111;';
		else
			pr 'img/cask_f.png@55,121;';
		end
	end,
};

--бочка (во дворе)
y_cask = obj {
	nam = 'бочка',
	dsc = 'Под забором стоит {бочка}.',
	act = [[Металлическая бочка. С помощью неё я смогу перелезть обратно
через забор.]],
};

--забор (двор, север)
nyfence = obj {
	nam = 'забор',
	dsc = 'Сзади стоит бетонный {забор}.',
	obj = {'y_cask'},
	act = function()
		walk('north_side');
		return [[Я взобрался на бочку и перелез обратно через забор.]];
	end,
};

--окна (север)
nyd111windows = obj {
	nam = 'окна',
	dsc = [[В здании есть пустые {оконные проёмы}.]],
	act = [[Мрачные оконные проёмы...]],
};

--здание (север)
nyd111build = obj {
	nam = 'здание',
	dsc = [[Передо мной мрачное {здание} четырнацдатиэтажного
дома-призрака.]],
	act = [[Это задняя сторона заброшенного дома. Когда-то в нём жили
люди.]],
	obj = {'nyd111windows'},
};

--Двор 14, север
north_yard111 = room {
	nam = 'Двор дома 111 (север)',
	dsc = [[Я во дворе четырнадцатиэтажки.]],
	obj = {'nyd111build', 'nyfence'},
	way = {'east_yard111', 'west_yard111'},
	enter = function()
		if not me()._was_in_yard_d111 then
			me()._was_in_yard_d111 = true;
		end
		set_music('snd/111.ogg');
	end,
	pic = 'img/north_yard111.png;img/d111map.png;img/pl_b.png@51,85',
};

--забор (двор, восток)
eyfence = obj {
	nam = 'забор',
	dsc = 'Слева стоит бетонный {забор}.',
	act = 'Через него не получится перелезть. Он высокий.',
};

--окна (восток)
eyd111windows = obj {
	nam = 'окна',
	dsc = [[В здании есть пустые {оконные проёмы}... Хотя некоторые
зацементированы.]],
	act = [[Некоторые окна на первом этаже зацементированы кирпичами.
Может, это сделали, чтобы никто не лез туда?]],
};

--здание (восток)
eyd111build = obj {
	nam = 'здание',
	dsc = [[Передо мной мрачное {здание} четырнацдатиэтажного
дома-призрака.]],
	act = [[Это боковая сторона заброшенного дома. Когда-то в нём жили
люди.]],
	obj = {'eyd111windows'},
};

--Двор 14, восток
east_yard111 = room {
	nam = 'Двор дома 111 (восток)',
	dsc = [[Я во дворе четырнадцатиэтажки.]],
	obj = {'eyd111build', 'eyfence'},
	way = {'south_yard111', 'north_yard111'},
	pic = 'img/east_yard111.png;img/d111map.png;img/pl_l.png@80,115',
};

--забор (двор, запад)
wyfence = obj {
	nam = 'забор',
	dsc = 'справа стоит бетонный {забор}.',
	act = 'Через него не получится перелезть. Он высокий.',
};

--окна (запад)
wyd111windows = obj {
	nam = 'окна',
	dsc = [[В здании есть пустые {оконные проёмы}.]],
	act = [[Мрачные оконные проёмы...]],
};

--здание (запад)
wyd111build = obj {
	nam = 'здание',
	dsc = [[Передо мной мрачное {здание} четырнацдатиэтажного
дома-призрака.]],
	act = [[Это боковая сторона заброшенного дома. Когда-то в нём жили
люди.]],
	obj = {'wyd111windows'},
};

--Двор 14, запад
west_yard111 = room {
	nam = 'Двор дома 111 (запад)',
	dsc = [[Я во дворе четырнадцатиэтажки.]],
	obj = {'wyd111build', 'wyfence'},
	way = {'north_yard111', 'south_yard111'},
	pic = 'img/west_yard111.png;img/d111map.png;img/pl_r.png@27,111',
};

--вход (лестница)
d111enter1 = obj {
	nam = 'вход 1',
	dsc = [[С этой стороны здания находятся два входа:
{вход к лестнице},]],
	act = [[Этот вход ведёт на площадку с лестницой.]],
};

--вход (лифты)
d111enter2 = obj {
	nam = 'вход 2',
	dsc = [[{вход к лифтам}.]],
	act = [[Этот вход ведёт на площадку с лифтами.]],
};

--окна (юг)
syd111windows = obj {
	nam = 'окна',
	dsc = [[В здании есть пустые {оконные проёмы}.]],
	act = [[Мрачные оконные проёмы.]],
};

--здание (юг)
syd111build = obj {
	nam = 'здание',
	dsc = [[Передо мной мрачное {здание} четырнацдатиэтажного
дома-призрака.]],
	act = [[Это лицевая сторона заброшенного дома. Когда-то в нём жили
люди.]],
	obj = {'syd111windows', 'd111enter1', 'd111enter2'},
};

--хлам
sylumber = obj {
	nam = 'хлам',
	dsc = [[Под забором много {хлама}.]],
	act = [[Видимо, этот хлам загораживает проход. Чтобы его сдвинуть нужно
приложить много усилий.]],
};

--забор (двор, юг)
syfence = obj {
	nam = 'забор',
	dsc = 'Сзади стоит бетонный {забор}.',
	act = 'Через него не получится перелезть. Он высокий.',
	obj = {'sylumber'},
};

--Двор 14, юг
south_yard111 = room {
	nam = function()
		if deref(here()) == 'd111level1' or deref(here()) == 'l1_staircase' then
			return 'Выход';
		else
			return 'Двор дома 111 (юг)';
		end
	end,
	dsc = [[Я во дворе четырнадцатиэтажки.]],
	obj = {'syd111build', 'syfence'},
	way = {'l1_staircase', 'd111level1', 'west_yard111', 'east_yard111'},
	enter = function(s, f)
		if f == 'd111level1' then
			if me()._is_seen_human2 then
				if have('lock1') and have('lock_key') and photo._is_photo2 then
					return [[Пора смываться отсюда, пока не вернулось
то быдло.]];
				else
					return [[Нет. Ещё рано отсюда уходить.]], false;
				end
			end
		end
	end,
	pic = 'img/south_yard111.png;img/d111map.png;img/pl_t.png@47,138',
};

--111-------------------------------------------------------------------

--труба мусоропровода
d111chute = obj {
	nam = 'труба',
	dsc = 'Слева находятся: {труба} мусоропровода,',
	act = [[Раздолбанная труба. Ничего полезного.]],
};

--грузовой лифт
d111load_elevator = obj {
	nam = 'грузовой лифт',
	dsc = '{грузовой лифт},',
	act = [[От лифта осталась только шахта. Ни дверей, ни кнопок нет.
Воспользоваться не получится.]],
};

--пассажирский лифт
d111pas_elevator = obj {
	nam = 'пассажирский лифт',
	dsc = '{пассажирский лифт}.',
	act = [[От лифта осталась только шахта. Ни дверей, ни кнопок нет.
Воспользоваться не получится.]],
};

--коридор справа
corridor_r = obj {
	nam = 'коридор',
	dsc = 'Справа тоже есть {коридор} к квартирам.',
	act = [[Странно, в коридоре есть приоткрытая дверь. Из неё идёт
свет. Откуда здесь вообще дверь? По-моему, все окна и двери давно
унесены.]],
};

--коридор впереди
corridor_f = obj {
	nam = 'коридор',
	dsc = 'Впереди есть {коридор}, ведущий к бывшим квартирам.',
	act = [[В коридоре темно.]],
};

--Этаж 1
d111level1 = room {
	nam = function()
		if deref(here()) == 'l1_corridor_f' or deref(here()) == 'l1_corridor_r' then
			return 'Выход';
		else
			return 'Этаж 1';
		end
	end,
	dsc = [[Я нахожусь на этаже 1.]],
	obj = {'d111chute', 'd111load_elevator', 'd111pas_elevator', 'corridor_f', 'corridor_r'},
	way = {'south_yard111', 'l1_corridor_f', 'l1_corridor_r'},
	pic = 'img/d111level1.png',
};

--ступеньки 1-го эт.
l1_stair  = obj {
	nam = 'ступеньки',
	dsc = [[Передо мной {ступеньки}, ведущие на этаж 2.]],
	act = [[Ступеньки совсем развалились. По ним нельзя подняться.]],
};

--Лестница
l1_staircase = room {
	nam = 'Лестница этажа 1',
	dsc = [[Я нахожусь на лестничной площадке этажа 1.]],
	obj = {'l1_stair'},
	way = {'south_yard111'},
	pic = 'img/l1_staircase.png',
};

--дверь в кв. 4
door_flat4 = obj {
	nam = 'дверь',
	dsc = function(s)
		if me()._is_seen_human2 then
			if s.obj:look('d111f4_lock') then
				return [[{Дверь} в квартиру 4 закрыта.]];
			else
				return [[{Дверь} в квартиру 4 открыта.]];
			end
		else
			return [[Слева, из {двери} в бывшую квартиру 4, виднеется
свет.]];
		end
	end,
	act = function(s)
		if me()._is_seen_human2 then
			if s.obj:look('d111f4_lock') then
				return [[Дверь просто так не открыть.]];
			else
				if me()._is_seen_gl12 then
					return [[Открытая дверь. Место для петель
раздолбано.]];
				else
					return [[Дверь открыта!]];
				end
			end
		else
			return [[Дверь новая. Из неё идёт свет. Кому понадобилось
здесь ставить дверь?]];
		end
	end,
};

--обломки
fragments = obj {
	nam = img('img/icn_fragments.png')..'обломки',
	dsc = [[На полу лежат {обломки} стен.]],
	act = [[Обломки. Стены уже разваливаются.]],
	tak = function()
		if me()._is_seen_human2 then
			return [[Я взял обломки.]];
		end
	end,
	inv = [[Обломки стен. Они рассыпаются.]],
	use = function(s, w)
		if w == 'd111f4_lock' then
			s._crash = true;
			inv():del(s);
			return [[Обломки стены не помогли. Они просто развалились.
Нужно что-то покрепче.]];
		end
	end,
	_crash = false,
};

--Коридор справа
l1_corridor_r = room {
	nam = 'Правый коридор',
	dsc = [[Серые, ободранные стены коридора вокруг меня. В этом
коридоре есть две квартиры.]],
	obj = {'door_flat4', 'fragments'},
	way = {'d111level1', 'flat4', 'flat5'},
	enter = music('snd/111.ogg');
	pic = function()
		if me()._is_seen_human2 then
			pr 'img/l1_corridor_r2.png;';
			if seen('rock') then
				pr 'img/no_lock.png@44,88;';
			end
			if seen('lock1') then
				pr 'img/fallen_lock.png@59,124;';
			end
		else
			pr 'img/l1_corridor_r.png';
		end
	end,
};

--Коридор впереди
l1_corridor_f = room {
	nam = 'Передний коридор',
	dsc = [[Серые, ободранные стены коридора вокруг меня. В коридоре
есть три квартиры.]],
	way = {'d111level1', 'flat1', 'flat2', 'flat3'},
	pic = 'img/l1_corridor_f.png',
};

--пол
d111floor = obj {
	nam = 'пол',
	dsc = [[Подо мной {пол}, который устелен обвалившейся штукатуркой и
прочим хламом.]],
	act = [[Хм... Если присмотреться, то видны кое-где одноразовые
шприцы, тюбики из-под клея и стёкла от бутылок. Выводы сделать
не сложно.]],
};

--бумаги (гл. 1, 2)
note_12 = obj {
	nam = 'бумаги',
	dsc = [[В нём есть {бумаги}.]],
	act = function()
		if me()._is_seen_gl12 then
			p [[Бумаги, в которых описаны главы 1, 2.]];
			if photo._is_photo2 then
				p [[Я их уже сфотографировал на телефон.]];
			else
				p [[Нужно их как-то запечатлить.]];
			end
		else
			return walk('scn_gl12');
		end
	end,
};

--шкафчик в столу
table_box = obj {
	nam = 'шкафчик',
	dsc = function(s)
		if s._opened then
			return [[В столу есть открытый {шкафчик}.]];
		else
			return [[В столу есть закрытый {шкафчик}.]];
		end
	end,
	act = function(s)
		s._opened = not s._opened;
		if s._opened then
			s.obj:add('note_12');
			return [[Я открыл шкафчик в столу.]];
		else
			s.obj:del('note_12');
			return [[Я закрыл шкафчик в столу.]];
		end
	end,
	_opened = false,
};

--деревянный стол
wood_table = obj {
	nam = 'стол',
	dsc = [[В комнате стоит деревянный {стол}.]],
	act = [[Крепкий деревянный стол.]],
	obj = {'table_box'},
};

--хлам
lumber = obj {
	nam = 'хлам',
	dsc = [[В нём лежим много разного {хлама}.]],
	act = function(s)
		p [[Тут много разных инструментов. Есть несколько навесных
замков с привязанными к ним ключами.]];
		if not s._seen_key then
			s.obj:add('lock_key');
			s._seen_key = true;
			p [[Хм... Один ключ без замка.]];
		end
	end,
	_seen_key = false,
};

--шкаф
dresser = obj {
	nam = 'шкаф',
	dsc = function(s)
		if s._opened then
			return [[В углу стоит открытый {шкаф}.]];
		else
			return [[В углу стоит закрытый {шкаф}.]];
		end
	end,
	act = function(s)
		s._opened = not s._opened;
		if s._opened then
			s.obj:add('lumber');
			return [[Я открыл шкаф.]];
		else
			s.obj:del('lumber');
			return [[Я закрыл шкаф.]];
		end
	end,
	_opened = false,
};

--проход в комнаты (кв. 4)
enter_rooms = obj {
	nam = 'проход',
	dsc = [[Справа находится {проход} в другие комнаты квартиры.]],
	act = [[Окна в остальных комнатах заложены кирпичами. Наверное чтобы
не попасть в эту секретную комнату.]],
};

--Квартира 4
flat4 = room {
	nam = 'Квартира 4',
	dsc = [[Квартира.]],
	obj = {'wood_table', 'dresser', 'enter_rooms'},
	way = {'l1_corridor_r'},
	enter = function()
		if me()._is_seen_human2 then
			if door_flat4.obj:look('d111f4_lock') then
				return [[На двери замок.]], false;
			end
		else
			me()._is_seen_d111human = true;
			return walk('scn_d111escape');
		end
	end,
	exit = function(s, t)
		if t == 'l1_corridor_r' then
			if dresser._opened then
				dresser.obj:del('lumber');
				dresser._opened = false;
				p [[Я закрыл шкаф.]];
			end
			if table_box._opened then
				table_box.obj:del('note_12');
				table_box._opened = false;
				p [[Я закрыл шкафчик в столу.]];
			end
		end
	end,
	pic = 'img/flat4.png',
};

--Квартира 5
flat5 = room {
	nam = 'Квартира 5',
	dsc = [[В квартире голые серые стены, в которых есть оконные и
дверные проёмы.]],
	obj = {'d111floor'},
	way = {'l1_corridor_r'},
	pic = 'img/flat5.png',
};

--Квартира 1
flat1 = room {
	nam = 'Квартира 1',
	dsc = [[В квартире голые серые стены, в которых есть оконные и
дверные проёмы.]],
	obj = {'d111floor'},
	way = {'l1_corridor_f'},
	pic = 'img/flat1.png',
};

--камень
rock = obj {
	nam = img('img/icn_rock.png')..'камень',
	dsc = [[На полу лежит большой {камень}.]],
	act = [[Большой камень. Выглядит крепким и тяжёлым. Поднимать
такую тяжесть не хочется.]],
	tak = function(s)
		if fragments._crash and not seen(s, 'l1_corridor_r') then
			return [[Я взял тяжёлый камень в руки.]];
		end
	end,
	inv = [[Тяжёлый камень.]],
	use = function(s, w)
		if w == 'd111f4_lock' then
			inv():del(s);
			l1_corridor_r.obj:add(s);
			door_flat4.obj:del('d111f4_lock');
			l1_corridor_r.obj:add('lock1');
			return [[Я сбил камнем замок вместе с петлями!]];
		end
	end,	
};

--Квартира 2
flat2 = room {
	nam = 'Квартира 2',
	dsc = [[В квартире голые серые стены, в которых есть оконные и
дверные проёмы.]],
	obj = {'d111floor', 'rock'},
	way = {'l1_corridor_f'},
	pic = 'img/flat2.png',
};

--Квартира 3
flat3 = room {
	nam = 'Квартира 3',
	dsc = [[В квартире голые серые стены, в которых есть оконные и
дверные проёмы.]],
	obj = {'d111floor'},
	way = {'l1_corridor_f'},
	pic = 'img/flat3.png',
};

--к111------------------------------------------------------------------

--Побег из четырнадцатиэтажки
scn_d111escape = room {
	nam = 'Побег из четырнадцатиэтажки',
	dsc = [[Только я приоткрыл дверь, я увидел человека. Он был очень
большим и очень страшным.^^
В попыхах я убежал оттуда. Я залез на бочку и перелез через забор.^^
Когда я перелазил, я его видел. Он смотрел на меня. Это было чудовище...]],
	obj = {vway('Продолжить', '{Продолжить}', 'north_side')},
	enter = function(s)
		s._mus = get_music();
		set_music('snd/act1.ogg');
	end,
	exit = function(s)
		set_music(s._mus);
	end,
	nomobil = true,
	pic = 'img/scn_d111escape.png'
};

--Разговор Степана по телефону
scn_stepatalk = room {
	nam = 'Разговор Степана по телефону',
	dsc = [[Я прислушался у двери Степана. Он разговаривал по телефону:
— Да, я понял. Я сделаю надпись... Сегодня... Завтра проведём...
Введение... Завтра днём... Да... 79-й дом, 2-й подъезд.^^
Введение? А не то ли это введение? У меня есть соответствующая
бумага... Сегодня Степан сделает надпись? Наверно, мне надо выпить...]],
	obj = {vway('Продолжить', '{Продолжить}', 'partition')},
	enter = function(s)
		s._mus = get_music();
		set_music('snd/act1.ogg');
	end,
	exit = function(s)
		set_music(s._mus);
		return 'Меня клонит ко сну.';
	end,
	nomobil = true,
	pic = 'img/scn_stepatalk.png',
};

--дверь д.п.
dipetch_door = obj {
	nam = 'дверь',
	dsc = [[Передо мной крепкая железная {дверь}.]],
	act = [[Дверь закрыта.]],
};

--звонок д.п.
dipetch_bell = obj {
	nam = 'звонок',
	dsc = [[Справа от двери висит {звонок}.]],
	act = function()
		--звук звонка
		return walk('dipetch_dlg');
	end,
};

--Диспетчерский пункт
dipetch = room {
	nam = 'Диспетчерский пункт',
	dsc = [[Я нахожусь возле диспетчерского пункта. В нём наверное
всякие лифтёры и прочие рабочие, которые возятся с оснащением
многоэтажных домов.]],
	obj = {'dipetch_door', 'dipetch_bell'},
	way = {'east_side'},
	pic = 'img/dipetch.png;img/d111map.png;img/pl_l.png@125,15',
};

--Разговор с диспечтером
dipetch_dlg = dlg {
	nam = 'Разговор с диспетчером',
	dsc = [[Я позвонил в звонок. Дверь открыла женщина.]],
	obj = {
	[1] = phr('Вы диспетчер?', 'Да.'),
	[2] = phr('Как работа?', 'Молодой человек, что вам нужно?'),
	[3] = phr('У вас Степан работает? Лифтёр.', 'Да. Есть такой алкаш. С Иваном пьют постоянно.'),
	[4] = phr('А часто бывают ложные вызовы?', 'Бывают. Иногда даже наглости хватает прямо сюда приходить.'),
	[5] = phr('У вас коты есть?', 'Живёт несколько.'),
	[6] = phr('До свидания.', 'Счастливо.', [[return back()]]),
	},
	exit = function(s)
		s:pon(1);
		s:pon(2);
		s:pon(3);
		s:pon(4);
		s:pon(5);
		s:pon(6);
	end,
	pic = 'img/dipetch_dlg.png',
};

--Сон
sleep12 = room {
	nam = 'Диван',
	dsc = [[Я прилёг на диван.]],
	obj = {
		vway('Спать', '{Спать}', 'morning2'),
		vway('Встать', '^{Встать}', 'my_apartment')},
	nomobil = true,
	pic = 'img/sleep.png',
};
