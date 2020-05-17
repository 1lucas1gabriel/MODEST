within MODEST.Examples;

model Kinematic_6DOF "Equacoes cinematicas para 6 eixos diferentes"
  extends Modelica.Icons.Example;
  MODEST.Componentes.Kinematic kinematic2(q_begin = 0, qd_max = 25, qdd_max = 5)  annotation(
    Placement(visible = true, transformation(origin = {-30, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic1(q_begin = 0, qd_max = 20, qdd_max = 5)  annotation(
    Placement(visible = true, transformation(origin = {-30, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic3(q_begin = 0, qd_max = 30, qdd_max = 5)  annotation(
    Placement(visible = true, transformation(origin = {-30, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic4(q_begin = 0, qd_max = 35, qdd_max = 5)  annotation(
    Placement(visible = true, transformation(origin = {-30, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic5(q_begin = 0, qd_max = 40, qdd_max = 10)  annotation(
    Placement(visible = true, transformation(origin = {-30, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Kinematic kinematic6(q_begin = 0, qd_max = 45, qdd_max = 15)  annotation(
    Placement(visible = true, transformation(origin = {-30, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput BotaoStart(keyCode = "S") annotation(
    Placement(visible = true, transformation(origin = {-171, 24}, extent = {{-11, -10}, {11, 10}}, rotation = 0)));
  ROS_Bridge.Blocks.ROS_Sampler rOS_Sampler(nin = 6, nout = 6, portNumber = 9091, startTime = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Controlador2Step controlador2Step annotation(
    Placement(visible = true, transformation(origin = {-103, 17}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.Or Gate6Or(nu = 6)  annotation(
    Placement(visible = true, transformation(origin = {-102, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(kinematic6.q, rOS_Sampler.u[6]) annotation(
    Line(points = {{-18, 84}, {30, 84}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(kinematic1.q, rOS_Sampler.u[1]) annotation(
    Line(points = {{-18, -72}, {30, -72}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(kinematic2.q, rOS_Sampler.u[2]) annotation(
    Line(points = {{-18, -40}, {30, -40}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(kinematic3.q, rOS_Sampler.u[3]) annotation(
    Line(points = {{-18, -10}, {30, -10}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(kinematic4.q, rOS_Sampler.u[4]) annotation(
    Line(points = {{-18, 22}, {30, 22}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(kinematic5.q, rOS_Sampler.u[5]) annotation(
    Line(points = {{-18, 54}, {30, 54}, {30, 0}, {78, 0}, {78, 0}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[1], kinematic1.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, -72}, {-40, -72}, {-40, -72}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[2], kinematic2.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, -40}, {-40, -40}, {-40, -40}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[3], kinematic3.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, -10}, {-40, -10}, {-40, -10}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[4], kinematic4.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, 22}, {-40, 22}, {-40, 22}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[5], kinematic5.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, 54}, {-40, 54}, {-40, 54}}, color = {0, 0, 127}));
  connect(rOS_Sampler.y[6], kinematic6.go2Pos) annotation(
    Line(points = {{102, 0}, {108, 0}, {108, 96}, {-46, 96}, {-46, 84}, {-40, 84}, {-40, 84}}, color = {0, 0, 127}));
  connect(BotaoStart.keyState, controlador2Step.start_mov) annotation(
    Line(points = {{-158, 24}, {-122, 24}, {-122, 24}, {-122, 24}}, color = {255, 0, 255}));
  connect(controlador2Step.gatilho, kinematic1.gatilho) annotation(
    Line(points = {{-84, 6}, {-52, 6}, {-52, -88}, {-40, -88}, {-40, -88}}, color = {255, 0, 255}));
  connect(controlador2Step.gatilho, kinematic2.gatilho) annotation(
    Line(points = {{-84, 6}, {-52, 6}, {-52, -56}, {-40, -56}, {-40, -56}}, color = {255, 0, 255}));
  connect(kinematic3.gatilho, controlador2Step.gatilho) annotation(
    Line(points = {{-40, -26}, {-52, -26}, {-52, 6}, {-84, 6}, {-84, 6}, {-84, 6}}, color = {255, 0, 255}));
  connect(controlador2Step.gatilho, kinematic4.gatilho) annotation(
    Line(points = {{-84, 6}, {-42, 6}, {-42, 6}, {-40, 6}}, color = {255, 0, 255}));
  connect(controlador2Step.gatilho, kinematic5.gatilho) annotation(
    Line(points = {{-84, 6}, {-52, 6}, {-52, 38}, {-40, 38}, {-40, 38}}, color = {255, 0, 255}));
  connect(controlador2Step.gatilho, kinematic6.gatilho) annotation(
    Line(points = {{-84, 6}, {-52, 6}, {-52, 68}, {-40, 68}, {-40, 68}}, color = {255, 0, 255}));
  connect(controlador2Step.fdback_moving, Gate6Or.y) annotation(
    Line(points = {{-122, 6}, {-128, 6}, {-128, -30}, {-114, -30}, {-114, -30}}, color = {255, 0, 255}));
  connect(kinematic1.moving, Gate6Or.u[1]) annotation(
    Line(points = {{-18, -88}, {-18, -88}, {-18, -92}, {-70, -92}, {-70, -36}, {-92, -36}, {-92, -30}}, color = {255, 0, 255}));
  connect(kinematic2.moving, Gate6Or.u[2]) annotation(
    Line(points = {{-18, -56}, {-18, -56}, {-18, -60}, {-70, -60}, {-70, -34}, {-92, -34}, {-92, -30}}, color = {255, 0, 255}));
  connect(kinematic3.moving, Gate6Or.u[3]) annotation(
    Line(points = {{-18, -26}, {-18, -26}, {-18, -32}, {-92, -32}, {-92, -30}, {-92, -30}}, color = {255, 0, 255}));
  connect(kinematic4.moving, Gate6Or.u[4]) annotation(
    Line(points = {{-18, 6}, {-18, 6}, {-18, 2}, {-70, 2}, {-70, -30}, {-92, -30}, {-92, -30}}, color = {255, 0, 255}));
  connect(kinematic5.moving, Gate6Or.u[5]) annotation(
    Line(points = {{-18, 38}, {-18, 38}, {-18, 34}, {-70, 34}, {-70, -28}, {-92, -28}, {-92, -30}}, color = {255, 0, 255}));
  connect(kinematic6.moving, Gate6Or.u[6]) annotation(
    Line(points = {{-18, 68}, {-18, 68}, {-18, 64}, {-70, 64}, {-70, -26}, {-92, -26}, {-92, -30}}, color = {255, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100},{200,100}})), Documentation(
	  info="<html>
	  <p>
	  <b>Kinematic_6DOF é um modelo de como gerar e transmitir equações cinemáticas
	  de 6 eixos diferentes</b>. Cada instancia do bloco kinematic gera equações de 
	  posição, velocidade e aceleração para seu eixo específico. Os parâmetros 
	  de velocidade e aceleração máxima são definidos de acordo com cada eixo.
	  </p>
	  <p>
	  <b>O movimento só é efetuado quando ocorre a ativação do botão de Start 
	  (letra 'S' do teclado do computador) durante a simulação do modelo.</b>
	  </p>
	  <p>
	  Os valores são transmitidos pelo bloco ROS_SAMPLER, que envia os valores de 
	  posição para o nó Mod_Ros, que por sua vez <b>publica os valores no tópico 
	  /model_values.</b>
	  Os valores de go2Pos são recebidos do mesmo ROS_SAMPLER e são obtidos 
	  (um valor para cada posição) do tópico <b>/control_values</b>.
	  </p>
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
end Kinematic_6DOF;