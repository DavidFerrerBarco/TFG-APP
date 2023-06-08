import '../models/models.dart';

const mobileUrl = '192.168.0.21:3000';
const virtualMobileUrl = '10.0.2.2:3000';
const baseUrl = virtualMobileUrl;
final Employee defaultemployee = Employee(
  id: "",
  name: "",
  dni: "",
  password: "",
  company: "",
  contract: 0,
  admin: false,
  email: "",
  v: 0,
  token: null,
);

final Schedule defaultschedule = Schedule(
  id: "",
  employee: "",
  day: "",
  hours: [],
  realHours: [],
  hoursCount: 0,
  v: 0,
);

final News defaultnews = News(
  id: '',
  title: '',
  content: '',
  date: '',
  v: 0,
);

final Announcement defaultannouncement = Announcement(
  id: '',
  title: '',
  content: '',
  company: '',
  date: '',
  v: 0,
);

final Message defaultmessage = Message(
  id: '',
  sender: '',
  receiver: '',
  content: '',
  date: '',
  v: 0,
);

final Request defaultrequest = Request(
  title: '',
  content: '',
  employee: '',
  id: '',
  date: '',
  v: 0,
);

final List<Task> defaulttasks = [];

final List<Employee> defaultemployees = [];
