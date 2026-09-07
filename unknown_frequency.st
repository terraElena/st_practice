PROGRAM Unknown_frequency
    VAR
    //Входы и выходы с физическими адресами
    unknownFrequencyInput: BOOL; // Сигнал неизвестной частоты
    startButton: BOOL; // Кнопка старт
    stop_resetButton: BOOL; //  Кнопка пуск и сброс
    //Внутренние переменные
    latchbit: BOOL; //Флаг хранения статуса запуска
    timer10sec: TON; // Таймер на 1 секунду
    counterFr: CTU; // Счетчик
    finalFreqValue: DINT; // Значение для дисплея
    counterCU_signal: BOOL; // Cигнал на вход CU счётчика
    elapsedTime : TIME := T#0s;
    END_VAR

//Самоблокировка 
    IF startButton AND NOT stop_resetButton THEN
        latchbit:=TRUE;
      ELSIF stop_resetButton THEN
          latchbit:=FALSE; 
    END_IF;

    timer10sec(IN := latchbit, PT := T#1s);
    elapsedTime := timer10sec.ET;
// Счетчик импульсов
    counterCU_signal := latchbit AND NOT timer10sec.Q AND unknownFrequencyInput;

    finalFreqValue :=  counterFr.CV;   // текущее значение частоты в Герцах (кол-во импульсов за секунду)
//Сброс счётчика (RES) - только по Stop
    counterFr(CU := counterCU_signal, R := stop_resetButton, PV := 0);
     
END_PROGRAM
