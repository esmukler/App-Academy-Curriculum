var Student = function (fname, lname) {
  this.name = fname + " " + lname;
  this.courses = [];
};

Student.prototype.enroll = function (course) {
  var newCourse = true;
  for (i=0;i<this.courses.length;i++){
    if (course === this.courses[i]) {
      newCourse = false;
    };
  };

  if (newCourse) {
    this.courses.push(course);
  };
};

Student.prototype.courseLoad = function () {

  var load = {};

  for (i=0; i < this.courses.length; i++){
    if (load[this.courses[i].department]) {
      load[this.courses[i].department] += this.courses[i].numCredits;
    } else {
      load[this.courses[i].department] = this.courses[i].numCredits;
    };
  };

  return load;
};

var Course = function (cname, dept, credits) {
  this.name = cname;
  this.department = dept;
  this.numCredits = credits;
  this.students = [];
}

Course.prototype.add_student = function (student) {
  student.enroll(this);
  this.students.push(student);
}
