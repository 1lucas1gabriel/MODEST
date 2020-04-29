within MODEST.Componentes;

block Kinematic "Move o mais rapido possivel do angulo inicial até um angulo definido [go2Pos]"
  extends Modelica.Blocks.Icons.Block;
  import SI = Modelica.SIunits;
  
  parameter	Modelica.SIunits.Velocity qd_max = 1		"Velocidade Maxima" annotation(Dialog(group = "Cinematica"));
  parameter	Modelica.SIunits.Acceleration qdd_max = 1	"Aceleracao Maxima" annotation(Dialog(group = "Cinematica"));
  parameter Real tempoDelay = 1e-9						"Delay para sinal de entrada de comando" annotation(
	Dialog(group = "Comunicacao ROS_BRIDGE"));

  parameter Real q_begin = 0							"Angulo que indica a posicao inicial do eixo" annotation(
	Dialog(group = "Cinematica"));
  Modelica.Blocks.Interfaces.RealInput go2Pos			"Angulo para o qual o eixo deve se deslocar"  annotation(
    Placement(visible = true, transformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); 
  Modelica.Blocks.Interfaces.BooleanInput gatilho		"Gatilho Ativa a Movimentacao do Eixo"			annotation(
    Placement(visible = true, transformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Blocks.Interfaces.RealOutput q											annotation(
    Placement(visible = true, transformation(extent = {{100, 70}, {120, 90}}, rotation = 0), iconTransformation(extent = {{100, 70}, {120, 90}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput qd											annotation(
    Placement(visible = true, transformation(extent = {{100, 20}, {120, 40}}, rotation = 0), iconTransformation(extent = {{100, 20}, {120, 40}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput qdd										annotation(
    Placement(visible = true, transformation(extent = {{100, -40}, {120, -20}}, rotation = 0), iconTransformation(extent = {{100, -40}, {120, -20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput moving(start = false, fixed = true)	annotation(
    Placement(visible = true, transformation(extent = {{100, -90}, {120, -70}}, rotation = 0), iconTransformation(extent = {{100, -90}, {120, -70}}, rotation = 0)));

  output Modelica.SIunits.Time startTime				"Instante de tempo que o movimento comeca";
  output Modelica.SIunits.Time endTime					"Instante de tempo que o eixo conclui movimento";
  
protected
  // Delay de espera para comunicacao com ROS_Bridge -> Sem a espera o compilador falha
  Real angulo_dl = delay(go2Pos,tempoDelay);
  Real p_q_begin(start = q_begin);
  Real p_angulo;
  Real p_qd_max;
  Real p_qdd_max;
  Real p_deltaq;
  Real erro;
  Real erroTol = 1e-9; // Tolerancia no erro que indica se eixo alcancou valor de go2Pos
  constant Real eps=10*Modelica.Constants.eps;
  Real sd_max_inv;
  Real sdd_max_inv;
  Real sd_max;
  Real sdd_max;
  Real sdd;
  Real aux1;
  Real aux2;
  SI.Time Ta1;
  SI.Time Ta2;
  SI.Time Tv;
  SI.Time Te;
  Boolean noWphase;
  SI.Time Ta1s;
  SI.Time Ta2s;
  SI.Time Tvs;
  SI.Time Tes;
  Real sd_max2;
  Real s1;
  Real s2;
  Real s3;
  Real s;
  Real sd;
   
equation
  // EVENTO: Instante de tempo que o movimento comeca [instante de ativacao do gatilho]
  when gatilho then
    startTime = time;		  // captura o inicio -> borda de subida da transicao
    p_angulo = angulo_dl;	  // Angulo eh fixado ao angulo recebido na hora de gatilho [evita erro de alteracao do angulo]
	p_q_begin = pre(p_q_begin);
	p_deltaq = p_angulo - p_q_begin;
	p_qd_max = qd_max;
	p_qdd_max = qdd_max;
	aux1 = p_deltaq/p_qd_max;
	aux2 = p_deltaq/p_qdd_max;
	sd_max_inv = abs(aux1);
	sdd_max_inv = abs(aux2);

	elsewhen not gatilho then
	  
	  startTime = pre(startTime);		  
	  p_angulo = pre(p_angulo);	  
	  p_q_begin = pre(q);	  // Lembra o valor da ultima posicao para iniciar o proximo movimento
	  p_deltaq = pre(p_deltaq);
	  p_qd_max = pre(p_qd_max);
	  p_qdd_max = pre(p_qdd_max);
	  aux1 = pre(aux1);
	  aux2 = pre(aux2);
	  sd_max_inv = pre(sd_max_inv);
	  sdd_max_inv = pre(sdd_max_inv);
  end when;

  // Equacionamento em modo de espera [gatilho OFF] ----------------------------
  if not gatilho then 
	
	sd_max = 0;
	sdd_max = 0;
	Ta1 = 0;
	Ta2 = 0;
	noWphase = false;
	Tv = 0;
	Te = 0;
	Ta1s = 0;
	Ta2s = 0;
	Tvs = 0;
	Tes = 0;
	sd_max2 = 0;
	s1 = 0;
	s2 = 0;
	s3 = 0;
	s = 0;
	
  // Equacionamento em modo de movimentacao [gatilho ON] -----------------------
  else
	if sd_max_inv <= eps or sdd_max_inv <= eps then
	  sd_max = 0;
	  sdd_max = 0;
	  Ta1 = 0;
	  Ta2 = 0;
	  noWphase = false;
	  Tv = 0;
	  Te = 0;
	  Ta1s = 0;
	  Ta2s = 0;
	  Tvs = 0;
	  Tes = 0;
	  sd_max2 = 0;
	  s1 = 0;
	  s2 = 0;
	  s3 = 0;
	  s = 0;
	else
	  sd_max = 1/(abs(aux1));
	  sdd_max = 1/(abs(aux2));
	  Ta1 = sqrt(1/sdd_max);
	  Ta2 = sd_max/sdd_max;
	  noWphase = Ta2 >= Ta1;
	  Tv = if noWphase then Ta1 else 1/sd_max;
	  Te = if noWphase then Ta1 + Ta1 else Tv + Ta2;
	  Ta1s = Ta1 + startTime;
	  Ta2s = Ta2 + startTime;
	  Tvs = Tv + startTime;
	  Tes = Te + startTime;
	  sd_max2 = sdd_max*Ta1;
	  s1 = sdd_max*(if noWphase then Ta1*Ta1 else Ta2*Ta2)/2;
	  s2 = s1 + (if noWphase then sd_max2*(Te - Ta1) - (sdd_max/2)*(Te - Ta1)^2 else sd_max*(Tv - Ta2));
	  s3 = s2 + sd_max*(Te - Tv) - (sdd_max/2)*(Te - Tv)*(Te - Tv);
  
	  if time < startTime then
		s = 0;
	  elseif noWphase then
		if time < Ta1s then
		  s = (sdd_max/2)*(time - startTime)*(time - startTime);
		elseif time < Tes then
		  s = s1 + sd_max2*(time - Ta1s) - (sdd_max/2)*(time - Ta1s)*(time - Ta1s);
		else
		  s = s2;
		end if;
	  elseif time < Ta2s then
		s = (sdd_max/2)*(time - startTime)*(time - startTime);
	  elseif time < Tvs then
		s = s1 + sd_max*(time - Ta2s);
	  elseif time < Tes then
		s = s2 + sd_max*(time - Tvs) - (sdd_max/2)*(time - Tvs)*(time - Tvs);
	  else
		s = s3;
	  end if;
	end if;
  end if;
  //-----------------------------------------------------------------------------
  sd = der(s);
  sdd = der(sd);

  qdd = p_deltaq*sdd;
  qd = p_deltaq*sd;
  q = p_q_begin + p_deltaq*s;
  endTime = Tes;
  erro = abs((abs(p_angulo-p_q_begin)-abs(q-p_q_begin)));
  
  // report when axis is moving -------------------------------------------------
 if not gatilho then
	moving = false;
  else	  // gatilho ON
	if erro > erroTol then
	  moving = true;
	else 
	  moving = false;
	end if;  
  end if;
  
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {
	  Text(origin = {4, 0},extent = {{34, 96}, {94, 66}}, textString = "q"),
	  Text(origin = {2, 0},extent = {{40, 44}, {96, 14}}, textString = "qd"),
	  Text(extent = {{32, -18}, {99, -44}}, textString = "qdd"),
	  Text(origin = {0, 6},extent = {{14, -74}, {97, -96}}, textString = "moving"),
	  Text(origin = {-92, 8}, extent = {{-2, -64}, {75, -112}}, textString = "gatilho"),
	  Text(origin = {-128, 8}, extent = {{34, 96}, {108, 50}}, textString = "go2Pos"),
	  Rectangle(origin = {-81, -4}, lineColor = {186, 189, 182}, fillColor = {186, 189, 182},
		  fillPattern = FillPattern.Solid, extent = {{-1, 54}, {1, -54}}),
	  Rectangle(origin = {-23, -59}, lineColor = {186, 189, 182}, fillColor = {186, 189, 182},
		  fillPattern = FillPattern.Solid, extent = {{65, -1}, {-59, 1}}),
	  Polygon(origin = {-81, 57}, lineColor = {186, 189, 182}, fillColor = {186, 189, 182},
		  fillPattern = FillPattern.Solid, points = {{-1, 7}, {-7, -7}, {7, -7}, {-1, 7}, {-1, 7}}),
	  Polygon(origin = {48, -60}, lineColor = {186, 189, 182}, fillColor = {186, 189, 182},
		 fillPattern = FillPattern.Solid, points = {{8, 0}, {-8, 8}, {-8, -8}, {8, 0}}),
	  Polygon(origin = {-22, -4}, fillColor = {115, 210, 22}, fillPattern = FillPattern.Solid,
		 points = {{-58, -54}, {-40, -48}, {-26, -36}, {-18, -22}, {-6, 2}, {6, 22}, {18, 36},
		 {34, 46}, {52, 48}, {52, -54}, {32, -54}, {-58, -54}})},
	  coordinateSystem(preserveAspectRatio=true,extent={{-100,-100},{100,100}})),
	  Documentation(info="<html>
	  <p> 
	  Kinematic é um bloco adaptado do bloco da biblioteca padrão Modelica 3.2.2.
	  O bloco original pode ser encontrado em <b>Modelica.Blocks.Sources.kinematicPTP2</b>.
	  A adaptação do Bloco para <b>Kinematic</b> se deu devido a necessidade de receber
	  novas posições durante a simulação. Diferente de KinematicPTP2, <b>Kinematic trabalha
	  apenas com um eixo</b> ou grau de liberdade. Logo, para mais de um eixo devem ser
	  instanciados mais de um objeto de kinematic. 	  
	  </p>
	  <p>
	  Assim como KinematicPTP2, <b>Kinematic</b> gera a posição q(t), a velocidade qd(t) = der(q),
	  e a aceleração qdd = der(qd) como saída. <b>'Moving'</b> indica se o movimento chegou ao fim quando 
	  igual a FALSE.<b> Se o 'gatilho' for desativado durante o movimento o bloco 'lembra a ultima posição'
	  antes do evento de desativação. Em um próximo gatilho ON (true), se não forem 
	  alteradas as condições de entrada 'go2Pos', continua-se o movimento para 
	  a posição anteriormente definida.</b>
	  </p>
	  <p>
	  Um fato muito importante sobre <b>kinematic</b> é a de que <b>uma nova posição [go2Pos]
	  só é atualizada em um novo gatilho</b>. Assim, para ir para uma nova posição o gatilho tem de 
	  ser desligado [false] e religado [true]. Isso gera um novo evento que atualiza os 
	  dados dentro do código.
	  </p>
	  <p>
	  Kinematic pode ser associado com o controlador de estados presente neste mesmo pacote
	  para uma abordagem de automação.
	  </p>
	  </html>"));
end Kinematic;
