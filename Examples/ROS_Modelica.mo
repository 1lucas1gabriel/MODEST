within MODEST.Examples;
  model ROS_Modelica "Exemplo para a comunicação com ROS"
    extends Modelica.Icons.Example;
  ROS_Bridge.Blocks.ROS_Sampler rOS_Sampler(nin = 4, nout = 1, portNumber = 9091, startTime = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {108, -12}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic(q_begin = 0, qd_max = 1, qdd_max = 1)  annotation(
    Placement(visible = true, transformation(origin = {-51, -11}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 5, startValue = false)  annotation(
    Placement(visible = true, transformation(origin = {-130, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  equation
  connect(booleanStep.y, kinematic.gatilho) annotation(
    Line(points = {{-118, -30}, {-84, -30}, {-84, -34}, {-82, -34}}, color = {255, 0, 255}));
  connect(booleanToReal.u, kinematic.moving) annotation(
    Line(points = {{18, -50}, {-18, -50}, {-18, -34}, {-20, -34}}, color = {255, 0, 255}));
  connect(booleanToReal.y, rOS_Sampler.u[4]) annotation(
    Line(points = {{42, -50}, {76, -50}, {76, -12}, {76, -12}}, color = {0, 0, 127}));
  connect(kinematic.q, rOS_Sampler.u[1]) annotation(
    Line(points = {{-20, 12}, {76, 12}, {76, -12}, {76, -12}}, color = {0, 0, 127}));
  connect(kinematic.qd, rOS_Sampler.u[2]) annotation(
    Line(points = {{-20, -2}, {74, -2}, {74, -12}, {76, -12}}, color = {0, 0, 127}));
  connect(kinematic.qdd, rOS_Sampler.u[3]) annotation(
    Line(points = {{-20, -20}, {74, -20}, {74, -12}, {76, -12}}, color = {0, 0, 127}));
  connect(kinematic.go2Pos, rOS_Sampler.y[1]) annotation(
    Line(points = {{-82, 12}, {-96, 12}, {-96, 50}, {154, 50}, {154, -12}, {136, -12}, {136, -12}}, color = {0, 0, 127}));

annotation(
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Documentation(info = "<html>
      <p>
      Este modelo trata de um exemplo para a <b>ponte de comunicação entre a simulação
      no OpenModelica e o sistema ROS</b>, com a utilização do bloco Sampler da 
      biblioteca ROS_Bridge.
      </p>
		<ul>
		  <li>O bloco kinematic gera equações de posição, velocidade e aceleração 
		  para o eixo específico.</li>
		  <li>O movimento é ativado quando ocorre a ativação do step Booleano 
		  em 5s de simulação.</li> 
		  <li>O angulo ou posição final é pre-determinado pela informação 
		  vinda do ros_Sampler para go2Pos durante a simulação.</li>
		  <li>A informação é enviada ao ros_Sampler para 
		  ser publicada no tópico /model_values do nó Mod_ros do sistema ROS.</li>
		  <li>A informação de movimentação é convertida de booleano para Real antes
		  de ser enviada ao ros_Sampler. (Que só aceita entradas de Reais).</li> 
		</ul>
      <p>
      <b>OBSERVAÇÃO 1: Tenha certeza que 3 Bibliotecas</b> estão disponíveis: <b>
	  Modelica_DeviceDrivers, ROS_Bridge e Modelica_Synchronous.</b> (Esta ultima é 
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
  end ROS_Modelica;