PROGRAM 
    VAR
    //Входы и выходы с физическими адресами
    unknownFrequencyInput AT %IX0.0.1: BOOL; // Сигнал неизвестной частоты
    startButton AT %IX0.0.2: BOOL; // Кнопка старт
    stop_resetButton AT %IX0.0.3: BOOL; //  Кнопка пуск и сброс
    //Внутренние переменные
    latchbit: BOOL; //Флаг хранения статуса запуска
    timer1sec: TON; // Таймер на 1 секунду
    counterFr: CTU; // Счетчик
    doneFlag: BOOL; // Флаг окончания измерения
    finalFreqValue: DINT; // Значение для дисплея
    END_VAR
    timer1sec.PT = T#1s; //настройка таймера
//Самоблокировка 
    IF startButton AND NOT stop_resetButton THEN
        latchbit:=TRUE;
      ELSIF stop_resetButton THEN
          latchbit:=FALSE; 
    END_IF;

    timer1sec.IN:=latchbit; //работает пока latchbit:=TRUE
    timer1sec();
// Счетчик импульсов
    IF latchbit AND NOT timer1sec.Q THEN
        counterFr.CU:= unknownFrequencyInput; //по фронту unknownFrequencyInput (CTU сам обрабатывает фронт на входе CU)
        ELSE counterFr.CU := FALSE;
    END_IF;
    counterFr(); 

//Сброс счётчика (RES) - только по Stop
    IF stop_resetButton THEN
        counterFr.RESET:= TRUE;
    ELSE
        counterFr.RESET:= FALSE;
    END_IF;
     
    finalFreqValue := Counter.CV;   // текущее значение частоты в Герцах (кол-во импульсов за секунду)
END_PROGRAM
