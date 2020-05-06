within MODEST.Examples;

model Sistema_Esteira "Ambiente com uma esteira e um
 controlador, com uma abordagem de interação do usuário"
 extends Modelica.Icons.Example;
 MODEST.Componentes.ControladorEsteira controladorEsteira annotation(
    Placement(visible = true, transformation(origin = {-67, -1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
 MODEST.Componentes.Esteira esteira(Aceleracao = 1, L = 2, Raio = 0.1, Velocidade = 1)  annotation(
    Placement(visible = true, transformation(origin = {19, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
 Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput Start(keyCode = "S")  annotation(
    Placement(visible = true, transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput Pause(keyCode = "P")  annotation(
    Placement(visible = true, transformation(origin = {-170, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput Continue(keyCode = "C")  annotation(
    Placement(visible = true, transformation(origin = {-170, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 ROS_Bridge.Blocks.ROS_Sampler rOS_Sampler(nin = 2, nout = 1, portNumber = 9091, startTime = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {146, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
 Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {84, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(controladorEsteira.gatilho, esteira.gatilho) annotation(
    Line(points = {{-42, 0}, {-8, 0}, {-8, -2}, {-6, -2}}, color = {255, 0, 255}));
 connect(esteira.moving, controladorEsteira.fdback_mov) annotation(
    Line(points = {{44, -14}, {52, -14}, {52, -38}, {-102, -38}, {-102, -16}, {-92, -16}, {-92, -16}}, color = {255, 0, 255}));
 connect(Start.keyState, controladorEsteira.start_mov) annotation(
    Line(points = {{-158, 30}, {-146, 30}, {-146, 14}, {-92, 14}, {-92, 16}}, color = {255, 0, 255}));
 connect(Pause.keyState, controladorEsteira.pause_mov) annotation(
    Line(points = {{-158, -10}, {-146, -10}, {-146, 6}, {-92, 6}, {-92, 4}}, color = {255, 0, 255}));
 connect(Continue.keyState, controladorEsteira.continue_mov) annotation(
    Line(points = {{-158, -50}, {-140, -50}, {-140, -6}, {-92, -6}, {-92, -6}}, color = {255, 0, 255}));
 connect(esteira.posParticula, rOS_Sampler.u[1]) annotation(
    Line(points = {{44, 12}, {120, 12}, {120, 0}, {122, 0}}, color = {0, 0, 127}));
 connect(booleanToReal.y, rOS_Sampler.u[2]) annotation(
    Line(points = {{90, -16}, {120, -16}, {120, 0}, {122, 0}}, color = {0, 0, 127}));
 connect(booleanToReal.u, esteira.moving) annotation(
    Line(points = {{76, -16}, {70, -16}, {70, -14}, {44, -14}, {44, -14}}, color = {255, 0, 255}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Documentation(info="<html>
    <p>
    <b>Sistema_Esteira é um modelo de uma ambiente com uma esteira e um controlador 
    associado a esta.</b> O Controlador coordena as ações de inicialização, pausa e 
    retomada da movimentação da esteira (cujo equacionamento é baseada no bloco 
    kinematic com adaptações).
    </p>
    <p>
    Para uma abordagem de interação do usuário com a simulação utiliza-se <b>botões de
    entrada de comando por meio do teclado</b>, disponibilizados graças a biblioteca 
    <b>Modelica_DeviceDrivers.</b><br>
    Outra abordagem é a comunicação da simulação com um nó do sistema ROS. Deve-se 
    utilizar a biblioteca <b>ROS_Bridge</b> para a ponte de comunicação.
    </p>
    <p>
    Informações mais específicas sobre o funcionamento da esteira e do controlador 
    podem ser encontradas na seção de informações dos blocos Esteira e do 
    Controlador_Esteira deste mesmo pacote.
    </p>
    <p>
    <b>OBSERVAÇÃO 1: Tenha certeza que 3 Bibliotecas</b> estão disponíveis: <b>
    Modelica_DeviceDrivers,ROS_Bridge e Modelica_Synchronous.</b> (Esta ultima é
    uma dependência para correto funcionamento da biblioteca Modelica_DeviceDrivers 
    para algumas funções e é requisitada devido operações de sincronização e tempo).
    </p>
	<p>
		<b>OBSERVAÇÃO 2:</b> <b>Simulações em Tempo Real</b> podem ser executadas com:
		<ol>
		  <li>flag de simulação <b>'-rt=1'</b> no setup de simulação [via 
		  OpenModelica].</li>
		  <li>Bloco <b>'SynchronizeRealtime'</b> da biblioteca 
		  <b>Modelica_DeviceDrivers.
		  </b></li>
		  <li>Interactive Simulation [via OpenModelica]</li> 
		</ol>
	  Existem bugs com a manipulação de eventos e/ou simulações longas por parte dos
	  Solvers do OpenModelica que podem causar erros. <b>EVITE Número de Intervalos
	  maiores de 220000</b> no setup de simulação.
      </p>
    </html>"));
end Sistema_Esteira;