within MODEST.Componentes;

block ControladorEsteira "Controlador do bloco Esteira"
  extends Modelica.Blocks.Icons.Block;
  extends MODEST.Icons.Chip;

  parameter Integer qtdSensores = 1 "Número de Sensores de Leitura";
  // ENTRADAS DE DADOS
  Modelica.Blocks.Interfaces.BooleanInput start "Evento para Iniciar movimentacao"	  annotation(
    Placement(visible = true, transformation(origin = {-189, 69}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanVectorInput sensores[qtdSensores]	"Conecte Sensores Aqui"	  annotation(
    Placement(visible = true, transformation(origin = {-184, -6.66134e-16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput fdback_mov "Feedback da movimentacao"		  annotation(
    Placement(visible = true, transformation(origin = {-189, -69}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // SAIDA DE DADOS
  Modelica.Blocks.Interfaces.BooleanOutput gatilho										  annotation(
    Placement(visible = true, transformation(origin = {50, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // ESTADOS
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot								  annotation(
    Placement(visible = true, transformation(origin = {170, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.InitialStep COMECO(nIn = 1, nOut = 1)							  annotation(
    Placement(visible = true, transformation(origin = {-86, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal MOVENDO(nIn = 3, nOut = 2)						  annotation(
    Placement(visible = true, transformation(origin = {17, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.StateGraph.Step PAUSADO(nIn = 1, nOut = 1)									  annotation(
    Placement(visible = true, transformation(origin = {17, -57}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  Modelica.StateGraph.Step ATUALIZA(nIn = 1, nOut = 1)									  annotation(
    Placement(visible = true, transformation(origin = {17, 67}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  // TRANSICOES
  Modelica.StateGraph.Transition T1(condition = start)									  annotation(
    Placement(visible = true, transformation(origin = {-54, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.Transition T2(condition = notMov.y)								  annotation(
    Placement(visible = true, transformation(origin = {94, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.StateGraph.Transition T3(condition = true, enableTimer = true, waitTime = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-18, 68}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.StateGraph.Transition T4(condition = AlgumaCaptura)							  annotation(
    Placement(visible = true, transformation(origin = {58, -58}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.StateGraph.Transition T5(condition = NenhumaCaptura)						  annotation(
    Placement(visible = true, transformation(origin = {-18, -58}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  //
  Modelica.Blocks.Logical.Not notMov													  annotation(
    Placement(visible = true, transformation(origin = {-167, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
protected
  Boolean AlgumaCaptura;
  Boolean NenhumaCaptura;
equation
/* Para ativar a PAUSA da esteira algum dos sensores inicia o disparo
	 Para desativar a PAUSA nenhum sensor deve estar ativo*/
// Varredura em todos os sensores para captura de objetos
  AlgumaCaptura = if Modelica.Math.BooleanVectors.anyTrue(sensores) then true else false;
// Varredura em todos os sensores indica que nenhum captura objetos
  NenhumaCaptura = if Modelica.Math.BooleanVectors.anyTrue(sensores) then false else true;
//-------------------------------------------------------------------------------------
 connect(COMECO.outPort[1], T1.inPort) annotation(
    Line(points = {{-73, 0}, {-59, 0}}));
 connect(MOVENDO.active, gatilho) annotation(
    Line(points = {{18, -16}, {16, -16}, {16, -26}, {50, -26}}, color = {255, 0, 255}));
 connect(T1.outPort, MOVENDO.inPort[1]) annotation(
    Line(points = {{-52, 0}, {2, 0}, {2, 0}, {2, 0}}));
 connect(T3.outPort, MOVENDO.inPort[2]) annotation(
    Line(points = {{-20, 68}, {-30, 68}, {-30, 0}, {2, 0}, {2, 0}}));
 connect(T5.outPort, MOVENDO.inPort[3]) annotation(
    Line(points = {{-20, -58}, {-30, -58}, {-30, 0}, {2, 0}, {2, 0}}));
 connect(MOVENDO.outPort[1], T2.inPort) annotation(
    Line(points = {{30, 0}, {88, 0}, {88, 0}, {90, 0}}));
 connect(T4.inPort, MOVENDO.outPort[2]) annotation(
    Line(points = {{62, -58}, {68, -58}, {68, 0}, {30, 0}, {30, 0}}));
 connect(T4.outPort, PAUSADO.inPort[1]) annotation(
    Line(points = {{56, -58}, {32, -58}, {32, -56}, {32, -56}}));
 connect(T5.inPort, PAUSADO.outPort[1]) annotation(
    Line(points = {{-14, -58}, {2, -58}, {2, -56}, {4, -56}}));
 connect(ATUALIZA.inPort[1], T2.outPort) annotation(
    Line(points = {{32, 68}, {120, 68}, {120, 0}, {96, 0}, {96, 0}}));
 connect(T3.inPort, ATUALIZA.outPort[1]) annotation(
    Line(points = {{-14, 68}, {4, 68}, {4, 68}, {4, 68}}));
 connect(fdback_mov, notMov.u) annotation(
    Line(points = {{-188, -68}, {-176, -68}, {-176, -68}, {-176, -68}}, color = {255, 0, 255}));
 annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Documentation(info = "<html>
    <p>
    <b>ControladorEsteira</b> é um bloco que realiza o controle da esteira 
    deste mesmo pacote. ControladorEsteira foi implementado com a biblioteca 
    de estados StateGraph do Modelica.
    </p>
    <p>
    As entradas para este controlador são um booleano para <b>'start'</b> e para o 
    <b>'feedback'</b> e um vetor de booleano para os <b>'sensores'.</b> Podem ser 
    incluídos quantos sensores forem necessários para o controle da esteira.
    </p>
    <p>
    COMECO é definido como etapa inicial da máquina de estados. MOVENDO 
    é o estado seguinte, cuja ativação depende de uma entrada em 'start'. 
    No momento que ocorre a ativação, a transição T1 é disparada 
    e o estado passa a ser MOVENDO. <b>Devido a execução do estado MOVENDO o gatilho 
    que é enviado para a saída é ativado.</b>
    </p>
    <p>
    <b>Pode-se realizar também a pausa e a continuação do processo de movimentação 
    em função da entrada de sensores lidos pelo controlador.
    </b> Quando a etapa MOVENDO está ativada e a transição T4 é disparada por um 
    dos sensores, (qualquer sensor conectado pode ativar T4) a etapa passa para 
    PAUSADO. 
    Se nenhum sensor detectar objeto da esteira a transição 5 é disparada e a etapa 
    MOVENDO volta a ser executada.
    </p>
    <p>
    Para uma abordagem prática pode-se usar os dispositivos de entrada da 
    biblioteca <b>DeviceDrivers</b> para acionamento dos eventos de <b>START e 
    Sensores</b> com botões do teclado.
    </p>
    </html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Polygon(origin = {-76, 71}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = {{-12, 13}, {-12, -11}, {12, 1}, {-12, 13}}), Text(origin = {-55, -86}, extent = {{-57, 34}, {1, -6}}, textString = "F")}));
end ControladorEsteira;