within Vehicle.Powertrain;
model Battery "Ideal DC battery with series resistance (educational stub)"
  parameter Modelica.Units.SI.Voltage V_nom = 400 "Nominal voltage";
  parameter Modelica.Units.SI.Resistance R_int = 0.01 "Internal resistance";

  Modelica.Electrical.Analog.Interfaces.PositivePin p
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));

protected
  Modelica.Electrical.Analog.Sources.ConstantVoltage source(V = V_nom)
    annotation(Placement(transformation(extent = {{-30, -10}, {-10, 10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = R_int)
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));

equation
  connect(source.p, resistor.p);
  connect(resistor.n, p);
  connect(source.n, n);

  annotation(
    Documentation(info = "<html><p>Voltage source and <code>R_int</code>; SOC and inverter later.</p></html>"),
    Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "Battery")}));
end Battery;
