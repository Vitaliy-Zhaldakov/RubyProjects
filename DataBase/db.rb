require 'sqlite3'

db = SQLite3::Database.open 'PC_firm.db'

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS posts (
    postID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    post_name TEXT NOT NULL,
    salary INTEGER NOT NULL
  );
SQL

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS employees (
    employeeID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    surname TEXT NOT NULL,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    birthdate TEXT NOT NULL,
    address TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT NOT NULL,
    postID INTEGER,
    FOREIGN KEY(postID) REFERENCES posts(postID)
  );
SQL

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS work_experience (
    employeeID INTEGER NOT NULL,
    postID INTEGER NOT NULL,
    hiredate TEXT NOT NULL,
    firedate TEXT,
    FOREIGN KEY(postID) REFERENCES posts(postID),
    FOREIGN KEY(employeeID) REFERENCES employees(employeeID),
    PRIMARY KEY(employeeID, postID, hiredate)
  );
SQL

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS department (
    departmentID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    phone INTEGER NOT NULL,
    postID INTEGER NOT NULL,
    duties TEXT NOT NULL,
    FOREIGN KEY(postID) REFERENCES posts(postID)
  );
SQL

# db.execute("INSERT INTO posts(post_name, salary)
# VALUES ('Продавец-консультант', 35000)")
# db.execute("INSERT INTO posts(post_name, salary)
# VALUES ('Менеджер', 40000)")
# db.execute("INSERT INTO posts(post_name, salary)
# VALUES ('Логист', 64000)")
# db.execute("INSERT INTO posts(post_name, salary)
# VALUES ('Грузчик', 30000)")
#
db.execute("select * from posts") do |row|
  puts row
end

# db.execute("INSERT INTO employees(surname, firstname, lastname, birthdate, address, phone, email, postID)
#   VALUES ('Берегов', 'Юрий', 'Викторович', '1990-01-20', 'г.Краснодар', '79094568721', 'urbereg@mail.ru', 1)")
# db.execute("INSERT INTO employees(surname, firstname, lastname, birthdate, address, phone, email, postID)
#   VALUES ('Власов', 'Владимир', 'Александрович', '1999-11-01', 'г.Ставрополь', '79183020129', 'vvlas@gmail.com', 1)")
# db.execute("INSERT INTO employees(surname, firstname, lastname, birthdate, address, phone, email, postID)
#   VALUES ('Либова', 'Кристина', 'Владимировна', '2000-06-23', 'г.Краснодар', '79904631290', 'libkr@gmail.com', 3)")
#
# db.execute("select * from employees") do |row|
#   puts row
# end

# db.execute("INSERT INTO work_experience(employeeID, postID, hiredate, firedate)
# VALUES (1, 1, '2020-01-24', NULL)")
# db.execute("INSERT INTO work_experience(employeeID, postID, hiredate, firedate)
# VALUES (2, 1, '2020-12-05', '2021-05-18')")
# db.execute("INSERT INTO work_experience(employeeID, postID, hiredate, firedate)
# VALUES (3, 3, '2019-01-20', NULL)")
#
# db.execute("select * from work_experience") do |row|
#   puts row
# end

# db.execute("INSERT INTO department(name, phone, postID, duties)
# VALUES ('Отдел кадров', '261-55-11', 2, 'Приём на работу')")
# db.execute("INSERT INTO department(name, phone, postID, duties)
# VALUES ('Отдел логистики', '261-46-89', 3, 'Построить маршрут')")
# db.execute("INSERT INTO department(name, phone, postID, duties)
# VALUES ('Отдел финансов', '261-99-66', 2, 'Сформировать отчёт')")
# db.execute("INSERT INTO department(name, phone, postID, duties)
# VALUES ('Отдел обслуживания', '261-32-12', 1, 'Оформить заказ')")
#
# db.execute("select * from department") do |row|
#   puts row
# end

db.close
