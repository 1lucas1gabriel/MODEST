within MODEST.Componentes;

block Controlador2Step "Controlador de dois estados (Stopped e Moving). É ativado pelo Start e recebe feedback de movimento
					para desativar gatilho"
  
  extends Modelica.Blocks.Icons.Block;
  extends MODEST.Icons.Chip;
  
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot										  annotation(
    Placement(visible = true, transformation(origin = {-170, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.InitialStepWithSignal STOPPED(nIn = 1, nOut = 1)						  annotation(
    Placement(visible = true, transformation(origin = {-25, 23}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal MOVING(nIn = 1, nOut = 1)									  annotation(
    Placement(visible = true, transformation(origin = {85, 23}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  
  Modelica.StateGraph.Transition T1(condition = fallingEdgeStart, enableTimer = false)		  annotation(
    Placement(visible = true, transformation(origin = {33, 23}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.StateGraph.Transition T2(condition = notMov, enableTimer = false)					  annotation(
    Placement(visible = true, transformation(origin = {130, 24}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    
  Modelica.Blocks.Interfaces.BooleanInput start_mov	  "Evento para iniciar movimentacao"	  annotation(
    Placement(visible = true, transformation(origin = {-181, 51}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput fdback_moving "Feedback da movimentacao"			  annotation(
    Placement(visible = true, transformation(origin = {-181, 11}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.BooleanOutput gatilho		  "Gatilho para ativacao do movimento"	  annotation(
    Placement(visible = true, transformation(origin = {100, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
  Modelica.Blocks.Logical.Not notM																  annotation(
    Placement(visible = true, transformation(origin = {-150, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.FallingEdge fallingEdge												  annotation(
    Placement(visible = true, transformation(origin = {-150, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  output Boolean fallingEdgeStart;
  output Boolean notMov;
  
equation
  
  fallingEdgeStart = fallingEdge.y;
  notMov = notM.y;
  
  connect(STOPPED.outPort[1], T1.inPort)	annotation(
    Line(points = {{-5, 23}, {26, 23}}));
  connect(T1.outPort, MOVING.inPort[1])	annotation(
    Line(points = {{36, 23}, {64, 23}}));
  connect(MOVING.outPort[1], T2.inPort)	annotation(
    Line(points = {{105, 23}, {102, 23}, {102, 24}, {124, 24}}));
  connect(notM.u, fdback_moving)			annotation(
    Line(points = {{-162, 10}, {-181, 10}, {-181, 11}}, color = {255, 0, 255}));
  connect(fallingEdge.u, start_mov)		annotation(
    Line(points = {{-162, 50}, {-178, 50}, {-178, 51}, {-181, 51}}, color = {255, 0, 255}));
  connect(STOPPED.inPort[1], T2.outPort)	annotation(
    Line(points = {{-46, 24}, {-60, 24}, {-60, 66}, {156, 66}, {156, 24}, {132, 24}, {132, 24}}));
  connect(MOVING.active, gatilho)			annotation(
    Line(points = {{85, 2}, {85, -12}, {100, -12}}, color = {255, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-68, 31}, extent = {{-24, 37}, {-2, -17}}, textString = "S"), Text(origin = {-66, -68}, extent = {{-24, 28}, {-2, -14}}, textString = "F"), Text(origin = {82, -61}, extent = {{-12, 19}, {12, -19}}, textString = "G")},
    coordinateSystem(initialScale = 0.1)),
    Documentation(info="<html>
    <p>
    <b>Controlador2Step</b> é um bloco que utiliza a biblioteca StatGraph do padrão Modelica 3.2.2 
    para gerar dois estados representativos das etapas de movimentação e espera de algum sistema.
    </p>
    <p>
    STOPPED é definido como etapa inicial da máquina de estados. Enquanto MOVING é o estado
    seguinte, cuja ativação depende de uma entrada em 'start_mov'. No momento que ocorre a 
    uma borda de descida, então a transição T1 é disparada e o estado passa a ser MOVING.
    Devido a execução do estado MOVING <b> o gatilho que é enviado para a saída é ativado.</b>
    </p>
    <p>
    A <b>borda de descida</b> (fallingEdgeStart) é importante pois se a entrada 
    permanecesse ativa e 'notMov' também estivesse ativo (Ou seja, significando 
    não há movimento) <b>ocorreriam multiplos eventos instantaneamente e a simulação 
    falharia</b>. Logo, este é um problema evitado com fallingEdge. 
    </p>
    <p>
    Como já mencionado, 'notMov' indica que não há mais sinal de movimentação externa. 
    Isso ocorre pois um feedback passado ao controlador informa se há ou não tal movimentação.
    'fdback_moving' é barrado por um bloco lógico 'not' e <b>quando o sinal notMov se torna
    verdadeiro a transição T2 é disparada.</b>
    </p>
    <p>
    <b>Observação:</b> Se a transição T1 for disparada enquanto estiver ocorrendo a etapa
    MOVING nada ocorrerá, pois <b>só o evento em T2 tem capacidade de alterar o estado de 
    MOVING para STOPPED.
    </b>
    </p>
    </html>"));
end Controlador2Step;
