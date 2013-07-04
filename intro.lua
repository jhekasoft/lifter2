GUEST_DSC = [[Я посмотрел на гостей. Из одноклассников Димы
только я. Рядом с ним сидят двое его друзей с работы, родители, его
младшая сестра. Она учится в той же школе, где и мы с Димой учились.
Интересно, что здесь присутствует мой сосед Степан. Он раньше
работал с отцом Димы на заводе. Но из-за пьянства его уволили. Теперь
он работает, кажется, лифтёром.^^
С другой стороны именинника сидит его девушка — Юля. Но моё
внимание больше склонно к её подруге Лене...^^
Юля и Лена учились в нашей школе, только на класс младше, чем мы с
Димой. Лена мне нравилась ещё со школы. Но я тогда боялся что-то
начать. А сейчас так сложилось, что у меня есть шанс...]];

me()._lena_speak = false; --можно ли разговаривать с Леной
me()._stepan_spoke = false; --поговорил ли со Степаном
me()._syster_spoke = false; --поговорил ли с сестрой Димы
me()._noreturn = false; --не нужен ли вывод при выходе из диалога

--На всякий случай
main = room {
	nam = 'На всякий случай...',
	dsc = txtc(txtb('ВНИМАНИЕ!!!'))..
[[^^Все имена персонажей, названия аппаратуры, номера мобильных телефонов,
адреса являются выдуманными. Все события также являются выдуманными.
Соответственно, любое совпадение псевдослучайно (ибо ничего случайного нет
в мире!).^^
Автор игры не поощряет воспроизведение событий игры в реальной жизни.]],
	obj = {vway('Продолжить', '{Продолжить}', 'guest0')},
	pic = 'img/warning.png',
};

--В гостях (тост)
guest0 = room {
	nam = 'В гостях',
	dsc = [[Я стою перед столом. Вокруг множество людей, которые
смотрят на меня с ожиданием. У всех в руках бокалы. У меня тоже...^^
Вдруг один парень говорит мне:^^
— Ну, давай Макс! Говори тост за именинника!^^
Именинник — это мой одноклассник Дима. Уже прошло лет семь как мы окончили
школу... После школы не часто виделись. Лишь иногда договаривались о
встрече по телефону. Ещё бывали на встречах выпускников. Это давно
было. Но он не забыл обо мне. Ведь когда-то мы были лучшими друзьями. И,
вот, пригласил на свой день рождения...^^
Что-то у меня нет совсем настроения... Но надо сказать тост.]],
	obj = {vway('Тост1', '{— За именинника!^}', 'guest1'),
		vway('Тост2', [[{— Я знаю Диму давно. Мы с первого класса вместе!
И поэтому могу сказать, что он всегда старался быть честным. Даже как-то
признался... (кажется, в 5-м классе) учительнице, что он списал на
контрольной. Хоть честность Димы ему иногда делала только плохо,
всё же это хорошо! Поэтому давайте выпьем за то, чтобы Дмитрий был
всегда таким же честным!}]], 'guest2')},
	enter = music('snd/guest1.ogg');
	pic = 'img/guest_main.png',
};

--В гостях (1 тост)
guest1 = room {
	nam = 'В гостях',
	dsc = [[После произнесённого мною не очень оригинально тоста все
начали радостно кричать. Мы выпили по бокалу. И все продолжили
разговаривать.^^]]..GUEST_DSC,
	obj = {vway('Продолжить', '{Продолжить}', 'guest')},
	enter = function()
		me()._lena_speak = false;
	end,
	pic = 'img/guest_main.png',
};

--В гостях (2 тост)
guest2 = room {
	nam = 'В гостях',
	dsc = [[После произнесённого мною тоста всем стало весело, на меня
обратили внимание. Мы выпили по бокалу. И все продолжили
разговаривать.^^]]..GUEST_DSC..[[^^Краем ока я заметил, что она на меня
смотрит.]],
	obj = {vway('Продолжить', '{Продолжить}', 'guest')},
	enter = function()
		me()._lena_speak = true;
	end,
	pic = 'img/guest_main.png',
};

--В гостях
guest = room {
	nam = 'В гостях',
	dsc = [[Все гости начали разговаривать друг с другом. Надо бы и мне
поговорить с кем-то.]],
	obj = {'dima', 'parents', 'syster', 'friends', 'stepan', 'yulya', 'lena'},
	enter = music('snd/guest1.ogg'),
	pic = function()
		pr 'img/guest.png;';
		if me()._lena_speak then
			pr 'img/guest_n.png@81,24;';
		end
	end,
};

dima = obj {
	nam = 'Дима',
	dsc = 'За столом сидят: {Дима},',
	act = function()
		if me()._lena_speak then
			return 'Он разговаривает с Юлей. Лучше не отвлекать влюблённых.';
		else
			return 'Он разговаривает со своими друзьями.';
		end
	end,
};

parents = obj {
	nam = 'родители',
	dsc = 'его {родители},',
	act = 'Отец Димы рассказывает жене о горячем стаже...',
};

syster = obj {
	nam = 'сестра',
	dsc = '{сестра},',
	act = function()
		return walk('syster_dlg');
	end,
};

friends = obj {
	nam = 'друзья',
	dsc = '{друзья} Димы с работы,',
	act = [[Они о своём. Кажется, о рейтинге на торрент-трекерах. У
одного рейтинг 30. Помешаны на компьютерах. Прям как дети. Ну, разве
так можно?]],
};

stepan = obj {
	nam = 'Степан',
	dsc = '{Степан},',
	act = function()
		return walk('stepan_dlg');
	end,
};

yulya = obj {
	nam = 'Юля',
	dsc = 'девушка Димы {Юля},',
	act = function()
		if me()._lena_speak then
			return 'Она разговаривает с Димой. Лучше не отвлекать влюблённых.';
		else
			return 'Она разговаривает с Леной. Не буду их отвлекать.';
		end
	end,
};

lena = obj {
	nam = 'Лена',
	dsc = '{Лена}.',
	act = function()
		if me()._lena_speak then
			return walk('lena_dlg');
		else
			return 'Пока лучше не трогать её. Она разговаривает с подругой.';
		end
	end,
};

syster_dlg = dlg {
	nam = 'Диалог с сестрой Димы',
	dsc = [[Сестра Димы смотрит на меня внимательно. Кажется, она самая
трезвая из гостей.]],
	obj = {
	[1] = phr('Настя, в каком классе сейчас учишься?', 'В 10-й перешла.'),
	[2] = phr('Как учёба?', 'Каникулы сейчас же. Лето. А вообще с физикой проблемы.', [[pon(3);]]),
	[3] = _phr('С физикой у многих проблемы. Ничего. Одолеешь!', 'Надеюсь...'),
	[4] = phr('Не буду тебе надоедать...', '...', [[return back();]]),
	},
	exit = function()
		pon(4);
		if not me()._lena_speak then
			me()._syster_spoke = true;
			if me()._stepan_spoke then
				me()._lena_speak = true;
				return 'Юля теперь разговаривает с Димой. Самое время поговорить с Леной.';
			else
				return 'Кажется, Насте скучно с нами.';
			end
		else
			return 'Кажется, Настя чувствует себя не в своей тарелке.';
		end
	end,
	pic = 'img/syster_dlg.png',
};

stepan_dlg = dlg {
	nam = 'Диалог со Степаном',
	dsc = [[Степан смотрит на меня щуря глаза. Кажется он уже не совсем трезвый.]],
	obj = {
	[1] = phr('Стёпа, как жизнь?', 'Та...'),
	[2] = phr('Давай по маленькой?', 'Давай!'),
	[3] = phr('Ты сейчас лифты чинишь?', 'Типа того... Людей там вытаскиваем...', [[pon(4); poff(2);]]),
	[4] = _phr('Давай ещё по маленькой?', 'Конечно!', [[pon(5);]]),
	[5] = _phr('А у тебя напарник что ли есть? Раз вытаскиваете...', 'Да! Ванька! Вот такой человек!', [[pon(6);]]),
	[6] = _phr('Может ещё?', 'Наливай!', [[pon(7); poff(9);]]),
	[7] = _phr('Вроде... су.. соседи, а не знали с тоб... бой друг друга особо...', 'Да... Быв... вает.', [[pon(8);]]),
	[8] = _phr('Давай набруд... бруда... будапешт. Тьфу! Бруд...', 'Дав.. давай! За тебя!', [[me()._noreturn = true; return walk('guest_end2');]]),
	[9] = phr('Ладно...', '...', [[return back();]]),
	},
	exit = function()
		pon(9);
		if not me()._noreturn then
			if not me()._lena_speak then
				me()._stepan_spoke = true;
				if me()._syster_spoke then
					me()._lena_speak = true;
					return 'Юля теперь разговривает с Димой. Самое время поговорить с Леной.';
				else
					return 'Степан продолжил пить.';
				end
			else
				return 'Степан пьёт.';
			end
		end
	end,
	pic = 'img/stepan_dlg.png',
};

lena_dlg = dlg {
	nam = 'Диалог с Леной',
	dsc = [[Лена улыбаясь смотрит на меня. Главное не растеряться...]],
	obj = {
	[1] = phr('Лена, как дела?', 'Отлично.'),
	[2] = phr('Хм...', 'Ты что, стесняешься что ли?', [[pon(3);]]),
	[3] = _phr('Признаться, немного стесняюсь. Перед такой девушкой...', 'О. Какая же я?', [[pon(4);]]),
	[4] = _phr('Ты интересная.', 'Спасибо за комплимент, но давай о чём-нибудь другом поговорим...', [[me()._noreturn = true; return walk('guest_end1');]]),
	[5] = phr('Не буду тебе надоедать...', '...', [[return back();]]),
	},
	exit = function()
		pon(5);
		if not me()._noreturn then
			return 'Лена всё-равно смотрит на меня. Кажется ей не с кем больше поговорить.';
		end
	end,
	pic = 'img/lena_dlg.png',
};

--Окончание д.р. 1
guest_end1 = room {
	nam = 'После...',
	dsc = [[После этого мы с Леной разговорились. Я её так мало знал, но
казалось, что знаю всю вечность. Вот ведь... Так в романах пишут.^^
Я увлекаюсь классической музыкой, она тоже. Мне нравятся животные, ей
тоже. Я играю на гитаре, она любит как она звучит.^^
Мы ведь уже не малолетки, а разговаривали с ней как-будто нам по 17 лет...^^
После празднования я проводил её домой. И она дала мне свой номер
мобильного телефона. Я был счастлив.^^
Но пришлось вернуться и помочь донести Степана домой... Мы же всё-таки соседи
с этим лифтёром...]],
	obj = {vway('Продолжить', '{Продолжить}', 'screen')},
	pic = 'img/lena_dlg.png',
};

--Окончание д.р. 2
guest_end2 = room {
	nam = 'После...',
	dsc = [[Мы со Степаном сильно напились... Пришлось нас тащить домой.
Я смутно всё помнил... К счастью на следующее утро мне позвонил Дима и
всё рассказал. Как мне было стыдно...^^
Оказывается, я пьяный признавался Лене в любви. Вот, блин... Она хоть и
была зла на меня, но всё-таки дала свой номер мобильного телефона. Так
что надо будет ей позвонить.^^
Эх, зачем я пил с этим лифтёром Степаном?]],
	obj = {vway('Продолжить', '{Продолжить}', 'screen')},
	pic = 'img/lena_dlg.png',
};