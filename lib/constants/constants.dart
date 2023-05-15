import '../models/models.dart';

const baseUrl = '192.168.0.21:3000';

final Employee defaultemployee = Employee(
  id: "",
  name: "",
  dni: "",
  password: "",
  company: "",
  contract: 0,
  admin: false,
  image: "",
  email: "",
  v: 0,
  token: null,
);

final Schedule defaultschedule = Schedule(
  id: "",
  employee: "",
  day: "",
  hours: [""],
  hoursCount: 0,
  v: 0,
);

final List<Task> defaulttask = [
  Task(
    id: "";
    title: "",
    content: "",
    day: "",
    employee: "",
    status: "",
    date: "",
    v: 0,
  ),
];
