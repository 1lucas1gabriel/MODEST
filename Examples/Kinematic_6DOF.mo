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
  MODEST.Componentes.Gate6_Or gate6_Or annotation(
    Placement(visible = true, transformation(origin = {-89, -51}, extent = {{11, -11}, {-11, 11}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.InputDevices.KeyboardKeyInput BotaoStart(keyCode = "A") annotation(
    Placement(visible = true, transformation(origin = {-171, 24}, extent = {{-11, -10}, {11, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime annotation(
    Placement(visible = true, transformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ROS_Bridge.Blocks.ROS_Sampler rOS_Sampler(nin = 6, nout = 6, portNumber = 9091, startTime = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MODEST.Componentes.Controlador2Step controlador2Step annotation(
    Placement(visible = true, transformation(origin = {-103, 17}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
equation
  connect(gate6_Or.Input6, kinematic6.moving) annotation(
    Line(points = {{-76, -42}, {-60, -42}, {-60, 62}, {-18, 62}, {-18, 68}, {-18, 68}}, color = {255, 0, 255}));
  connect(gate6_Or.Input5, kinematic5.moving) annotation(
    Line(points = {{-76, -46}, {-60, -46}, {-60, 32}, {-20, 32}, {-20, 38}, {-18, 38}}, color = {255, 0, 255}));
  connect(gate6_Or.Input4, kinematic4.moving) annotation(
    Line(points = {{-76, -50}, {-60, -50}, {-60, 0}, {-18, 0}, {-18, 6}, {-18, 6}}, color = {255, 0, 255}));
  connect(gate6_Or.Input3, kinematic3.moving) annotation(
    Line(points = {{-76, -52}, {-60, -52}, {-60, -30}, {-18, -30}, {-18, -26}, {-18, -26}}, color = {255, 0, 255}));
  connect(gate6_Or.Input2, kinematic2.moving) annotation(
    Line(points = {{-76, -56}, {-60, -56}, {-60, -62}, {-20, -62}, {-20, -56}, {-18, -56}}, color = {255, 0, 255}));
  connect(gate6_Or.Input1, kinematic1.moving) annotation(
    Line(points = {{-76, -60}, {-60, -60}, {-60, -92}, {-18, -92}, {-18, -88}, {-18, -88}}, color = {255, 0, 255}));
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
  connect(controlador2Step.fdback_moving, gate6_Or.y) annotation(
    Line(points = {{-122, 6}, {-128, 6}, {-128, -52}, {-102, -52}, {-102, -50}}, color = {255, 0, 255}));
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
	  Os valores são transmitidos pelo bloco ROS_SAMPLER, que envia os valores de posição
	  para o nó Mod_Ros, que por sua vez <b>publica os valores no tópico /model_values.</b>
	  Os valores de go2Pos são recebidos do mesmo ROS_SAMPLER e são obtidos (um valor para 
	  cada	posição) do tópico <b>/control_values</b>.
	  </p>
	  </html>"));
end Kinematic_6DOF;
