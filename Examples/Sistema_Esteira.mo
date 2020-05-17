within MODEST.Examples;

model Sistema_Esteira "Ambiente com uma esteira e um
 controlador, com uma abordagem de interação do usuário"
 extends Modelica.Icons.Example;
 MODEST.Componentes.Esteira esteira(Aceleracao = 0.5, Velocidade = 0.2)  annotation(
    Placement(visible = true, transformation(origin = {10, 34}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
 MODEST.Componentes.ControladorEsteira controladorEsteira(qtdSensores = 4)  annotation(
    Placement(visible = true, transformation(origin = {-76, 34}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
 Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput Start(keyCode = "S")  annotation(
    Placement(visible = true, transformation(origin = {-168, 52}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
 ROS_Bridge.Blocks.ROS_Sampler rOS_Sampler(nin = 2, nout = 4, portNumber = 9091, startTime = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {139, 35}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
 Modelica.Blocks.Math.BooleanToReal converteMoving "Converte Moving de Booleano para Real" annotation(
    Placement(visible = true, transformation(origin = {73, 17}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
 Modelica.Blocks.Math.RealToBoolean converteS1(threshold = 1)  "Converte informacao do Sensor de Real para Booleano" annotation(
    Placement(visible = true, transformation(origin = {-173, -67}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
 Modelica.Blocks.Math.RealToBoolean converteS2(threshold = 1)  "Converte informacao do Sensor de Real para Booleano" annotation(
    Placement(visible = true, transformation(origin = {-153, -67}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
 Modelica.Blocks.Math.RealToBoolean converteS3(threshold = 1)  "Converte informacao do Sensor de Real para Booleano" annotation(
    Placement(visible = true, transformation(origin = {-133, -67}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
 Modelica.Blocks.Math.RealToBoolean converteS4(threshold = 1)  "Converte informacao do Sensor de Real para Booleano" annotation(
    Placement(visible = true, transformation(origin = {-113, -67}, extent = {{-7, -7}, {7, 7}}, rotation = 90)));
equation
  connect(esteira.velocidade, rOS_Sampler.u[1]) annotation(
    Line(points = {{40, 34}, {112, 34}, {112, 36}, {114, 36}}, color = {0, 0, 127}));
 connect(esteira.moving, converteMoving.u) annotation(
    Line(points = {{40, 18}, {64, 18}, {64, 18}, {64, 18}}, color = {255, 0, 255}));
 connect(rOS_Sampler.u[2], converteMoving.y) annotation(
    Line(points = {{114, 36}, {112, 36}, {112, 18}, {80, 18}, {80, 18}}, color = {0, 0, 127}));
 connect(Start.keyState, controladorEsteira.start) annotation(
    Line(points = {{-153, 52}, {-104, 52}}, color = {255, 0, 255}));
 connect(controladorEsteira.gatilho, esteira.gatilho) annotation(
    Line(points = {{-48, 34}, {-20, 34}, {-20, 34}, {-20, 34}}, color = {255, 0, 255}));
 connect(converteS1.y, controladorEsteira.sensores[1]) annotation(
    Line(points = {{-172, -60}, {-172, -60}, {-172, -40}, {-140, -40}, {-140, 34}, {-106, 34}, {-106, 34}}, color = {255, 0, 255}));
 connect(converteS2.y, controladorEsteira.sensores[2]) annotation(
    Line(points = {{-152, -60}, {-154, -60}, {-154, -40}, {-140, -40}, {-140, 34}, {-106, 34}, {-106, 34}}, color = {255, 0, 255}));
 connect(converteS3.y, controladorEsteira.sensores[3]) annotation(
    Line(points = {{-132, -60}, {-132, -60}, {-132, -40}, {-140, -40}, {-140, 34}, {-106, 34}, {-106, 34}}, color = {255, 0, 255}));
 connect(converteS4.y, controladorEsteira.sensores[4]) annotation(
    Line(points = {{-112, -60}, {-112, -60}, {-112, -40}, {-140, -40}, {-140, 34}, {-106, 34}, {-106, 34}}, color = {255, 0, 255}));
 connect(controladorEsteira.fdback_mov, esteira.moving) annotation(
    Line(points = {{-104, 16}, {-114, 16}, {-114, -8}, {40, -8}, {40, 18}, {40, 18}}, color = {255, 0, 255}));
 connect(converteS1.u, rOS_Sampler.y[1]) annotation(
    Line(points = {{-172, -76}, {-174, -76}, {-174, -92}, {174, -92}, {174, 34}, {162, 34}, {162, 36}}, color = {0, 0, 127}));
 connect(converteS2.u, rOS_Sampler.y[2]) annotation(
    Line(points = {{-152, -76}, {-154, -76}, {-154, -92}, {174, -92}, {174, 34}, {162, 34}, {162, 36}}, color = {0, 0, 127}));
 connect(converteS3.u, rOS_Sampler.y[3]) annotation(
    Line(points = {{-132, -76}, {-134, -76}, {-134, -92}, {174, -92}, {174, 34}, {162, 34}, {162, 36}}, color = {0, 0, 127}));
 connect(converteS4.u, rOS_Sampler.y[4]) annotation(
    Line(points = {{-112, -76}, {-112, -76}, {-112, -92}, {174, -92}, {174, 34}, {162, 34}, {162, 36}}, color = {0, 0, 127}));
protected
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
    As entradas para o Controlador são um booleano para <b>'start'</b> e para o 
    <b>'feedback'</b> de movimentação da esteira e um vetor de booleano para os 
    <b>'sensores'.</b> Podem ser incluídos quantos sensores forem necessários 
    para o controle da esteira.
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