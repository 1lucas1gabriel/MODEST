within MODEST.Componentes;

block Gate6_Or "Porta logica para usar com 6 'moving' de eixos diferentes. Retorno para o controlador"
  extends Modelica.Blocks.Icons.BooleanBlock;
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-70, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or2 annotation(
    Placement(visible = true, transformation(origin = {-70, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or3 annotation(
    Placement(visible = true, transformation(origin = {-70, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or4 annotation(
    Placement(visible = true, transformation(origin = {-70, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or5 annotation(
    Placement(visible = true, transformation(origin = {-70, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or6 annotation(
    Placement(visible = true, transformation(origin = {-70, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or7 annotation(
    Placement(visible = true, transformation(origin = {-30, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or8 annotation(
    Placement(visible = true, transformation(origin = {-30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or9 annotation(
    Placement(visible = true, transformation(origin = {-30, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression OFF(y = false)  annotation(
    Placement(visible = true, transformation(origin = {-130, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input1 annotation(
    Placement(visible = true, transformation(origin = {-149, -89}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input2 annotation(
    Placement(visible = true, transformation(origin = {-149, -59}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input3 annotation(
    Placement(visible = true, transformation(origin = {-149, -31}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input4 annotation(
    Placement(visible = true, transformation(origin = {-149, 1}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input5 annotation(
    Placement(visible = true, transformation(origin = {-149, 35}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Input6 annotation(
    Placement(visible = true, transformation(origin = {-149, 65}, extent = {{-9, -9}, {9, 9}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or10 annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or11 annotation(
    Placement(visible = true, transformation(origin = {50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(
    Placement(visible = true, transformation(origin = {106, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(OFF.y, or6.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, 74}, {-82, 74}, {-82, 74}}, color = {255, 0, 255}));
  connect(OFF.y, or5.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, 42}, {-82, 42}, {-82, 42}}, color = {255, 0, 255}));
  connect(OFF.y, or4.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, 12}, {-82, 12}, {-82, 12}}, color = {255, 0, 255}));
  connect(OFF.y, or3.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, -22}, {-82, -22}, {-82, -22}}, color = {255, 0, 255}));
  connect(OFF.y, or2.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, -54}, {-82, -54}, {-82, -54}}, color = {255, 0, 255}));
  connect(OFF.y, or1.u1) annotation(
    Line(points = {{-118, 84}, {-100, 84}, {-100, -86}, {-82, -86}, {-82, -86}}, color = {255, 0, 255}));
  connect(or1.u2, Input1) annotation(
    Line(points = {{-82, -94}, {-144, -94}, {-144, -88}, {-148, -88}}, color = {255, 0, 255}));
  connect(or2.u2, Input2) annotation(
    Line(points = {{-82, -62}, {-144, -62}, {-144, -58}, {-148, -58}}, color = {255, 0, 255}));
  connect(or3.u2, Input3) annotation(
    Line(points = {{-82, -30}, {-146, -30}, {-146, -30}, {-148, -30}}, color = {255, 0, 255}));
  connect(or4.u2, Input4) annotation(
    Line(points = {{-82, 4}, {-144, 4}, {-144, 2}, {-148, 2}}, color = {255, 0, 255}));
  connect(or5.u2, Input5) annotation(
    Line(points = {{-82, 34}, {-144, 34}, {-144, 36}, {-148, 36}}, color = {255, 0, 255}));
  connect(or6.u2, Input6) annotation(
    Line(points = {{-82, 66}, {-148, 66}, {-148, 66}, {-148, 66}}, color = {255, 0, 255}));
  connect(or6.y, or7.u1) annotation(
    Line(points = {{-58, 74}, {-44, 74}, {-44, 62}, {-42, 62}}, color = {255, 0, 255}));
  connect(or7.u2, or5.y) annotation(
    Line(points = {{-42, 54}, {-44, 54}, {-44, 42}, {-58, 42}, {-58, 42}}, color = {255, 0, 255}));
  connect(or4.y, or8.u1) annotation(
    Line(points = {{-58, 12}, {-42, 12}, {-42, -10}, {-42, -10}}, color = {255, 0, 255}));
  connect(or8.u2, or3.y) annotation(
    Line(points = {{-42, -18}, {-42, -18}, {-42, -22}, {-58, -22}, {-58, -22}}, color = {255, 0, 255}));
  connect(or2.y, or9.u1) annotation(
    Line(points = {{-58, -54}, {-44, -54}, {-44, -74}, {-42, -74}}, color = {255, 0, 255}));
  connect(or9.u2, or1.y) annotation(
    Line(points = {{-42, -82}, {-42, -82}, {-42, -86}, {-58, -86}, {-58, -86}}, color = {255, 0, 255}));
  connect(or7.y, or10.u1) annotation(
    Line(points = {{-18, 62}, {-2, 62}, {-2, 30}, {-2, 30}}, color = {255, 0, 255}));
  connect(or10.u2, or8.y) annotation(
    Line(points = {{-2, 22}, {-2, 22}, {-2, -10}, {-18, -10}, {-18, -10}}, color = {255, 0, 255}));
  connect(or9.y, or11.u2) annotation(
    Line(points = {{-18, -74}, {38, -74}, {38, -18}, {38, -18}}, color = {255, 0, 255}));
  connect(or11.u1, or10.y) annotation(
    Line(points = {{38, -10}, {36, -10}, {36, 30}, {22, 30}, {22, 30}}, color = {255, 0, 255}));
  connect(or11.y, y) annotation(
    Line(points = {{62, -10}, {100, -10}, {100, -12}, {106, -12}}, color = {255, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Text(origin = {-82, -83}, extent = {{-16, 9}, {16, -9}}, textString = "1"), Text(origin = {-82, -51}, extent = {{-16, 9}, {16, -9}}, textString = "2"), Text(origin = {-82, -19}, extent = {{-16, 9}, {16, -9}}, textString = "3"), Text(origin = {-82, 15}, extent = {{-16, 9}, {16, -9}}, textString = "4"), Text(origin = {-82, 49}, extent = {{-16, 9}, {16, -9}}, textString = "5"), Text(origin = {-82, 79}, extent = {{-16, 9}, {16, -9}}, textString = "6"), Text(origin = {28, 6}, extent = {{-52, 50}, {52, -50}}, textString = "or")}));
end Gate6_Or;
