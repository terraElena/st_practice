PROGRAM Unknown_frequency
    VAR
    //Входы и выходы с физическими адресами
    unknownFrequencyInput: BOOL; // Сигнал неизвестной частоты
    startButton: BOOL; // Кнопка старт
    stop_resetButton: BOOL; //  Кнопка пуск и сброс
    //Внутренние переменные
    latchbit: BOOL; //Флаг хранения статуса запуска
    timer1sec: TON; // Таймер на 1 секунду
    counterFr: CTU; // Счетчик
    doneFlag: BOOL; // Флаг окончания измерения
    finalFreqValue: DINT; // Значение для дисплея
    counterCU_signal: BOOL := FALSE; // Cигнал на вход CU счётчика
    END_VAR
    timer1sec.PT := T#1s; //настройка таймера
//Самоблокировка 
    IF startButton AND NOT stop_resetButton THEN
        latchbit:=TRUE;
      ELSIF stop_resetButton THEN
          latchbit:=FALSE; 
    END_IF;

    timer1sec(IN := latchbit, PT := T#1s);
// Счетчик импульсов
    counterCU_signal := latchbit AND NOT timer1sec.Q AND unknownFrequencyInput;

//Сброс счётчика (RES) - только по Stop
    counterFr(CU := counterCU_signal, R := stop_resetButton, PV := 0);
     
    finalFreqValue :=  counterFr.CV;   // текущее значение частоты в Герцах (кол-во импульсов за секунду)
END_PROGRAM
