within MODEST.Componentes;

block ControladorEsteira "Controlador do bloco Esteira"
  extends Modelica.Blocks.Icons.Block;
  extends MODEST.Icons.Chip;
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot									annotation(
    Placement(visible = true, transformation(origin = {170, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.InitialStep BEGIN(nIn = 1, nOut = 1)									annotation(
    Placement(visible = true, transformation(origin = {-78, 18}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal MOVING(nIn = 3, nOut = 2)								annotation(
    Placement(visible = true, transformation(origin = {34, 18}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.StateGraph.Step CHANGE(nIn = 1, nOut = 1)										annotation(
    Placement(visible = true, transformation(origin = {81, 75}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  Modelica.StateGraph.Step PAUSED(nIn = 1, nOut = 1)										annotation(
    Placement(visible = true, transformation(origin = {35, -59}, extent = {{13, -13}, {-13, 13}}, rotation = 0)));
  
  Modelica.StateGraph.Transition T1(condition = fallingEdgeStart)							annotation(
    Placement(visible = true, transformation(origin = {-22, 18}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.StateGraph.Transition T2(condition = notMov)									annotation(
    Placement(visible = true, transformation(origin = {85, 17}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.StateGraph.Transition T3(condition = true, enableTimer = true, waitTime = 0.1)annotation(
    Placement(visible = true, transformation(origin = {28, 76}, extent = {{18, -18}, {-18, 18}}, rotation = 0)));
  Modelica.StateGraph.Transition T4(condition = fallingEdgePause)							annotation(
    Placement(visible = true, transformation(origin = {74, -58}, extent = {{14, -14}, {-14, 14}}, rotation = 0)));
  Modelica.StateGraph.Transition T5(condition = fallingEdgeContinue)						annotation(
    Placement(visible = true, transformation(origin = {-4, -58}, extent = {{14, -14}, {-14, 14}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.BooleanOutput gatilho "Gatilho para ativacao do movimento"	annotation(
    Placement(visible = true, transformation(origin = {56, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.BooleanInput start_mov "Evento para Iniciar movimentacao"	annotation(
    Placement(visible = true, transformation(origin = {-189, 69}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput fdback_mov "Feedback da movimentacao"			annotation(
    Placement(visible = true, transformation(origin = {-187, 31}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput pause_mov "Pausar a movimentacao"				annotation(
    Placement(visible = true, transformation(origin = {-189, -9}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput continue_mov "Continuar movimentacao Anterior" annotation(
    Placement(visible = true, transformation(origin = {-189, -49}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Logical.FallingEdge fallingEdge1											annotation(
    Placement(visible = true, transformation(origin = {-150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.FallingEdge fallingEdge2											annotation(
    Placement(visible = true, transformation(origin = {-150, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.FallingEdge fallingEdge3											annotation(
    Placement(visible = true, transformation(origin = {-150, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Not notM															annotation(
    Placement(visible = true, transformation(origin = {-150, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
  output Boolean fallingEdgeStart;
  output Boolean fallingEdgePause;
  output Boolean fallingEdgeContinue;
  output Boolean notMov;
  
equation

  fallingEdgeStart = fallingEdge1.y;
  fallingEdgePause = fallingEdge2.y;
  fallingEdgeContinue = fallingEdge3.y;
  notMov = notM.y;
  
  connect(BEGIN.outPort[1], T1.inPort)	 annotation(
    Line(points = {{-61, 18}, {-28, 18}}));
  connect(MOVING.active, gatilho)		 annotation(
    Line(points = {{34, 0}, {34, -14}, {56, -14}}, color = {255, 0, 255}));
  connect(fallingEdge1.u, start_mov)	 annotation(
    Line(points = {{-162, 70}, {-184, 70}, {-184, 70}, {-188, 70}}, color = {255, 0, 255}));
  connect(notM.u, fdback_mov)			 annotation(
    Line(points = {{-162, 30}, {-187, 30}, {-187, 31}}, color = {255, 0, 255}));
  connect(T3.outPort, MOVING.inPort[2]) annotation(
    Line(points = {{26, 76}, {2, 76}, {2, 20}, {16, 20}, {16, 18}}));
  connect(T1.outPort, MOVING.inPort[1]) annotation(
    Line(points = {{-20, 18}, {16, 18}, {16, 18}, {16, 18}}));
  connect(CHANGE.outPort[1], T3.inPort) annotation(
    Line(points = {{67, 75}, {36, 75}, {36, 76}}));
  connect(T2.outPort, CHANGE.inPort[1]) annotation(
    Line(points = {{88, 18}, {116, 18}, {116, 74}, {96, 74}, {96, 76}}));
  connect(PAUSED.inPort[1], T4.outPort) annotation(
    Line(points = {{50, -58}, {72, -58}}));
  connect(T5.inPort, PAUSED.outPort[1]) annotation(
    Line(points = {{2, -58}, {22, -58}}));
  connect(pause_mov, fallingEdge2.u)	 annotation(
    Line(points = {{-188, -8}, {-164, -8}, {-164, -10}, {-162, -10}}, color = {255, 0, 255}));
  connect(continue_mov, fallingEdge3.u) annotation(
    Line(points = {{-188, -48}, {-164, -48}, {-164, -50}, {-162, -50}}, color = {255, 0, 255}));
  connect(T5.outPort, MOVING.inPort[3]) annotation(
    Line(points = {{-6, -58}, {-28, -58}, {-28, -32}, {2, -32}, {2, 16}, {16, 16}, {16, 18}}));
  connect(MOVING.outPort[1], T2.inPort) annotation(
    Line(points = {{50, 18}, {78, 18}, {78, 18}, {80, 18}}));
  connect(T4.inPort, MOVING.outPort[2]) annotation(
    Line(points = {{80, -58}, {94, -58}, {94, -32}, {70, -32}, {70, 18}, {50, 18}, {50, 18}}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Documentation(info="<html>
    <p>
    <b>ControladorEsteira</b> é um bloco que realiza o controle da esteira 
    deste mesmo pacote. ControladorEsteira foi implementado com a biblioteca 
    de estados StateGraph do Modelica.
    </p>
    <p>
    BEGIN é definido como etapa inicial da máquina de estados. MOVING 
    é o estado seguinte, cuja ativação depende de uma entrada em 'start_mov'. 
    No momento que ocorre a uma borda de descida, então a transição T1 é disparada 
    e o estado passa a ser MOVING. <b>Devido a execução do estado MOVING o gatilho 
    que é enviado para a saída é ativado.</b>
    </p>
    <p>
    <b>Pode-se realizar também a pausa e a continuação do processo de movimentação.
    </b> Quando a etapa MOVING está ativada e a transição T4 é disparada (por uma 
    borda de descida em pause_mov) a etapa passa para PAUSE. Se a transição 
    T5 é disparada a etapa MOVING volta a ser executada.
    </p>
    <p>
    Para uma abordagem prática pode-se usar os dispositivos de entrada da 
    biblioteca <b>DeviceDrivers</b> para acionamento dos eventos de <b>START, 
    PAUSE e CONTINUE</b> com botões do teclado.
    </p>
    </html>"),
  Icon(graphics = {
  Polygon(origin = {-82, 70}, fillColor = {115, 210, 22}, fillPattern = FillPattern.Solid, 
  points = {{-10, 10}, {-10, -10}, {10, 0}, {6, 2}, {-10, 10}}), 
  Rectangle(origin = {-87, 26}, fillColor = {0, 12, 255}, fillPattern = FillPattern.Solid, 
  extent = {{-3, 10}, {3, -10}}), 
  Rectangle(origin = {-75, 26}, fillColor = {0, 12, 255}, fillPattern = FillPattern.Solid, 
  extent = {{-3, 10}, {3, -10}}), 
  Rectangle(origin = {-75, -22}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, 
  extent = {{-3, 10}, {3, -10}}), 
  Polygon(origin = {-85, -21}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, 
  points = {{-7, 9}, {-7, -11}, {7, -1}, {7, -1}, {-7, 9}}), 
  Text(origin = {-94, -61}, extent = {{-8, 9}, {30, -27}}, textString = "F")}));
end ControladorEsteira;
