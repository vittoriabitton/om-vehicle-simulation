within Vehicle.Powertrain;
model Motor "RL electrical load (educational stub)"
  parameter Modelica.Units.SI.Resistance R = 0.1 "Winding resistance";
  parameter Modelica.Units.SI.Inductance L = 1e-3 "Winding inductance";

  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));

protected
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = R)
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = L)
    annotation(Placement(transformation(extent = {{30, -10}, {50, 10}})));

equation
  connect(p, resistor.p);
  connect(resistor.n, inductor.p);
  connect(inductor.n, n);

  annotation(
    Documentation(info = "<html><p>Series RL; add rotational port and back-EMF later.</p></html>"),
    Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "Motor")}));
end Motor;
