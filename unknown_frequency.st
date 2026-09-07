PROGRAM VAR
    //Входы и выходы с физическими адресами
    unknownFrequencyInput AT %IX0.0.1: BOOL; // Сигнал неизвестной частоты
    startButton AT %IX0.0.2: BOOL; // Кнопка старт
    stop_resetButton AT %IX0.0.3: BOOL; //  Кнопка пуск и сброс
    dispaly AT %Q*: WORD;
    //Внутренние переменные
    latchbit: BOOL; //Флаг хранения статуса запуска
    timer1sec: TON; // Таймер на 1 секунду
    counter: CTU; // Счетчик
    doneFlag: BOOL; // Флаг окончания измерения
    BCDoutput: WORD; // Значение для дисплея
END_VAR
    
END_PROGRAM
