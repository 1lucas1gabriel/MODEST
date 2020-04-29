within MODEST.Componentes;

block Esteira
  extends Modelica.Blocks.Icons.Block;
  import Const = Modelica.Constants;
  
  parameter Modelica.SIunits.Distance L = 10				"Comprimento da esteira (distancia das extremidades)" annotation(
  Dialog(group = "Dimensões"));
  parameter Modelica.SIunits.Radius  Raio = 0.1			"Raio do eixo da esteira"								annotation(
  Dialog(group = "Dimensões"));
  parameter Modelica.SIunits.Velocity Velocidade = 1		"Velocidade máxima da esteira"							annotation(
  Dialog(group = "Cinemática"));
  parameter Modelica.SIunits.Acceleration Aceleracao = 1	"Aceleração máxima da esteira"							annotation(
  Dialog(group = "Cinemática")); 
  output Integer qtd_rev									"Quantidade de revolucoes desde o inicio do processo";
  
  MODEST.Componentes.Kinematic kinematic(qd_max = Velocidade, qdd_max = Aceleracao, q_begin = 0)				annotation(
    Placement(visible = true, transformation(origin = {63, 3}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput gatilho			"if true, ativa o movimento da esteira"				annotation(
    Placement(visible = true, transformation(origin = {-150, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-115, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput posParticula	"Posicao de uma particula situada inicialmente na borda da esteira"annotation(
    Placement(visible = true, transformation(origin = {140, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {115, 59}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput velocidade			annotation(
    Placement(visible = true, transformation(origin = {140, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {115, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput moving annotation(
    Placement(visible = true, transformation(origin = {140, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {115, -61}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));

protected
  parameter Real ComprimentoDeRev = (2*(L-2*Raio))+(2*Const.pi*Raio); // Comprimento total da revolucao da esteira
  Boolean	RevCompleta(start = false, fixed = true);					// Indica se uma revolucao chegou ao fim
  Real		proximaPos(start = ComprimentoDeRev, fixed = true);		// Valor que define para onde a esteira deve ir
  Integer	i(start = 1, fixed = true);									// auxiliar para incrementar a proximaPos
  Real		erro;
  Real		epson = 1e-9;

equation
// EVENTO: Conclusao de uma revolucao
  when RevCompleta then
    i = pre(i) + 1;
    proximaPos = pre(ComprimentoDeRev) * i;					// Atualiza a proxima posicao quando uma revolucao é completada
  end when;
    
  kinematic.go2Pos = proximaPos;								// Passa o valor da proxima posicao para bloco cinematico
  qtd_rev = i - 1;
//	Calculo do erro que determina a conclusão da revolucao
  erro = abs(proximaPos - posParticula);
  if erro < epson then
	RevCompleta = true;
  else 
	RevCompleta =  false;
  end if;
  //-------------------------------------------------------
  
 connect(gatilho, kinematic.gatilho) annotation(
    Line(points = {{-150, -20}, {35.5, -20}, {35.5, -17}}, color = {255, 0, 255}));
 connect(kinematic.q, posParticula) annotation(
    Line(points = {{90, 24}, {108, 24}, {108, 60}, {140, 60}, {140, 60}}, color = {0, 0, 127}));
 connect(kinematic.qd, velocidade) annotation(
    Line(points = {{90, 10}, {140, 10}}, color = {0, 0, 127}));
 connect(moving, kinematic.moving) annotation(
    Line(points = {{140, -16}, {90, -16}}, color = {255, 0, 255}));
  annotation(
  Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Icon(graphics = {
	Rectangle(origin = {-84, -29}, fillColor = {211, 215, 207}, fillPattern = FillPattern.VerticalCylinder,
	extent = {{-6, 19}, {6, -35}}), 
	Rectangle(origin = {-5, 7}, extent = {{-83, -17}, {95, 7}}),
	Rectangle(origin = {101, -75}, fillColor = {186, 189, 182}, fillPattern = FillPattern.Forward,
	extent = {{-201, 11}, {-1, -25}}),
	Ellipse(origin = {-68, -19}, fillColor = {85, 87, 83}, fillPattern = FillPattern.Solid,
	extent = {{-32, 33}, {-8, 9}}, endAngle = 360), 
	Rectangle(origin = {86, -29}, fillColor = {211, 215, 207},
	fillPattern = FillPattern.VerticalCylinder, extent = {{-6, 19}, {6, -35}}),
	Ellipse(origin = {108, -19}, fillColor = {85, 87, 83}, fillPattern = FillPattern.Solid,
	extent = {{-32, 33}, {-8, 9}}, endAngle = 360), 
	Ellipse(origin = {-10, -19}, fillColor = {85, 87, 83}, fillPattern = FillPattern.Solid, 
	extent = {{-32, 33}, {-8, 9}}, endAngle = 360),
	Ellipse(origin = {50, -19}, fillColor = {85, 87, 83}, fillPattern = FillPattern.Solid,
	extent = {{-32, 33}, {-8, 9}}, endAngle = 360)},
	coordinateSystem(initialScale = 0.1)),
	Documentation(info = "<html>
	<p>
	<b>Esteira</b> é um bloco desenvolvido por meio do bloco Kinematic,
	representando as equações de posição, velocidade e aceleração de uma esteira.
	Esteira recebe como parâmetros o comprimento, o raio do eixo, velocidade
	e aceleração máxima desenvolvida. O movimento é ativado por gatilho.
	</p>
	<p>
	<img src=\"modelica://MODEST/Resources/esteira.png\">
	</p>
	<p>
	Um ponto <b>P</b> 'posParticula' representa uma <b>partícula</b> que ao 
	início da simulação	 encontra-se no ponto descrito na imagem. Com um 
	comprimento de L e o Raio, a esteira tem um <b>Comprimento de Revolução (CdR) 
	igual a 2*(L - 2*Raio) + 2*pi*Raio.</b>
	</p>
	<p>
	Quando a <b>partícula alcança uma revolução completa</b> (ou seja, CdR) um 
	EVENTO é gerado, <b>incrementando a próxima posição que é passada ao bloco 
	kinematic.</b>	No entanto, o bloco kinematic só atualiza a posição (go2Pos) 
	em um novo gatilho.
	Assim, <b>quando CdR é alcançado o gatilho deve ser desligado e religado</b> 
	(Novo EVENTO do gatilho) para atualizar a próxima posição.
	</p>	
	</html>"));
end Esteira;
