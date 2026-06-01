within Vehicle.Examples;
model Powertrain "Battery feeding RL motor (first runnable example)"
  Vehicle.Powertrain.Battery batt
    annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
  Vehicle.Powertrain.Motor motor
    annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation(Placement(transformation(extent = {{0, -30}, {20, -10}})));

equation
  connect(batt.p, motor.p);
  connect(batt.n, motor.n);
  connect(motor.n, ground.p);

  annotation(
    Documentation(info = "<html>
<p>Minimal DC link: 400 V battery, RL motor, single ground reference.</p>
</html>"),
    experiment(StopTime = 1, Interval = 0.001, Tolerance = 1e-6));
end Powertrain;
