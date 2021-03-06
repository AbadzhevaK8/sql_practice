===========================================================
Tutorial
===========================================================
SELECT class, COUNT(student) AS count
FROM Student_in_class
GROUP BY class
ORDER BY count DESC;
===========================================================
SELECT status, MIN(birthday) AS birthday
FROM FamilyMembers
GROUP BY status ORDER BY birthday;
===========================================================
SELECT plane, AVG(TIMESTAMPDIFF(second, time_out, time_in)) AS time
FROM Trip
GROUP by plane;
===========================================================
select room_id, AVG(price) as avg_price, count(room_id) as count
from Reservations
group by room_id order by count desc, avg_price desc;
===========================================================
select room_id, AVG(price) as avg_price, count(room_id) as count
from Reservations
group by room_id
HAVING avg_price > 150
order by count desc, avg_price desc;
===========================================================
SELECT (SELECT COUNT(trip)
        FROM Pass_in_trip
        WHERE Passenger.id=Pass_in_trip.passenger) as count,name
FROM Passenger
ORDER BY count DESC;
===========================================================
SELECT time_in FROM Trip
JOIN Pass_in_trip ON Trip.id=Pass_in_trip.trip
JOIN Passenger ON Pass_in_trip.passenger=Passenger.id
WHERE name='Steve Martin' AND town_to='London';
===========================================================
SELECT good, (unit_price*amount) AS sum  FROM Payments
WHERE good = (
    SELECT good from Goods
    WHERE good = good_id
) ORDER BY sum DESC;
===========================================================
SELECT good, (unit_price*amount) AS sum
FROM Payments, Goods
WHERE Payments.good = Goods.good_id
ORDER BY sum DESC;
===========================================================
SELECT * FROM FamilyMembers
WHERE member_name LIKE '% Quincey'
ORDER BY status,member_name;
===========================================================
Exercises
===========================================================
#01
SELECT name FROM Passenger;
===========================================================
#02
SELECT name FROM Company;
===========================================================
#03
SELECT * FROM Trip
WHERE town_from='Moscow';
===========================================================
#04
SELECT name FROM Passenger
WHERE name LIKE '%man';
===========================================================
#05
SELECT COUNT(plane) AS count FROM Trip
WHERE plane='TU-154';
===========================================================
#06
SELECT name FROM Company
JOIN Trip ON Company.id=Trip.company
WHERE plane='Boeing'
GROUP BY name;
===========================================================
#07
SELECT plane FROM Trip
WHERE town_to='Moscow'
GROUP BY plane;
===========================================================
#08
SELECT town_to, SEC_TO_TIME(TIMESTAMPDIFF(second, time_out, time_in)) AS flight_time
FROM Trip
WHERE town_from='Paris';
===========================================================
#09
SELECT name FROM Company
JOIN Trip ON Trip.company=Company.id
WHERE town_from='Vladivostok';
===========================================================
#10
SELECT * FROM Trip
WHERE time_out >= '1900-01-01T10:00:00.000Z'
    AND time_out <= '1900-01-01T14:00:00.000Z';
===========================================================
#11
SELECT name
FROM Passenger
ORDER BY CHAR_LENGTH(name) DESC
LIMIT 0, 1;
===========================================================
#12
SELECT trip, COUNT(passenger) AS count
FROM Pass_in_trip
GROUP BY trip;
===========================================================
#13
SELECT DISTINCT name FROM Passenger
WHERE name=(SELECT name
FROM Passenger
GROUP BY name
HAVING COUNT(name)>1);
===========================================================
#14
SELECT town_to FROM Trip
JOIN Pass_in_trip ON Pass_in_trip.trip=Trip.id
JOIN Passenger ON Pass_in_trip.passenger=Passenger.id
WHERE name='Bruce Willis';
===========================================================
#16
SELECT name, COUNT(trip) AS count FROM Pass_in_trip
JOIN Passenger ON Pass_in_trip.passenger=Passenger.id
GROUP BY passenger ORDER BY count DESC;
===========================================================
#17
SELECT member_name, status, SUM(amount*unit_price) as costs FROM FamilyMembers
JOIN Payments ON Payments.family_member=FamilyMembers.member_id
WHERE date LIKE '2005%'
GROUP BY member_name;
===========================================================
#18
SELECT member_name FROM FamilyMembers
WHERE birthday=(SELECT MIN(birthday) AS birthday
                FROM FamilyMembers);
===========================================================
#19
SELECT DISTINCT status FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id=Payments.family_member
JOIN Goods ON Payments.good=Goods.good_id
WHERE good_name='potato';
===========================================================
#20
SELECT status, member_name, SUM(amount*unit_price) AS costs FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id=Payments.family_member
JOIN Goods ON Payments.good=Goods.good_id
JOIN GoodTypes ON Goods.type=GoodTypes.good_type_id
WHERE good_type_name='entertainment'
GROUP BY status, member_name;
===========================================================
#21
SELECT good_name FROM Goods
JOIN Payments ON Goods.good_id=Payments.good
GROUP BY good_name
HAVING COUNT(good)>1;
===========================================================
#22
SELECT member_name FROM FamilyMembers
WHERE status='mother';
===========================================================
#23
SELECT good_name, unit_price FROM Payments
JOIN Goods ON Goods.good_id = Payments.good
JOIN GoodTypes ON Goods.type = GoodTypes.good_type_id
WHERE GoodTypes.good_type_name = 'delicacies' AND unit_price =
(SELECT MAX(unit_price) FROM Payments
JOIN Goods ON Goods.good_id = Payments.good
JOIN GoodTypes ON Goods.type = GoodTypes.good_type_id
WHERE GoodTypes.good_type_name = 'delicacies');
===========================================================
#24
SELECT member_name, SUM(amount*unit_price) AS costs
FROM Payments
JOIN FamilyMembers ON FamilyMembers.member_id=Payments.family_member
WHERE Payments.date LIKE '2005-06%'
GROUP BY member_name;
===========================================================
#25
SELECT good_name FROM Goods
JOIN Payments ON Payments.good=Goods.good_id
WHERE YEAR(date)!= '2005';
===========================================================
#26
SELECT good_type_name FROM GoodTypes
WHERE good_type_name NOT IN (SELECT good_type_name
                              FROM GoodTypes
                              JOIN Goods ON GoodTypes.good_type_id=Goods.type
                              JOIN Payments ON Goods.good_id=Payments.good
                              WHERE YEAR(date)='2005');
===========================================================
#27
SELECT good_type_name, SUM(amount*unit_price) AS costs FROM Payments
JOIN Goods ON Payments.good=Goods.good_id
JOIN GoodTypes ON Goods.type=GoodTypes.good_type_id
WHERE YEAR(date)='2005'
GROUP BY good_type_name;
===========================================================
#28
SELECT COUNT(*) AS count FROM Trip
WHERE town_from='Rostov' AND town_to='Moscow';
===========================================================
#29
SELECT DISTINCT name FROM Passenger
JOIN Pass_in_trip ON Passenger.id=Pass_in_trip.passenger
JOIN Trip ON Pass_in_trip.trip=Trip.id
WHERE town_to='Moscow' AND plane='TU-134';
===========================================================
#30
SELECT trip, COUNT(passenger) AS count
FROM Pass_in_trip
GROUP BY trip
ORDER BY count DESC;
===========================================================
#31
SELECT * FROM FamilyMembers
WHERE member_name LIKE '% Quincey';
===========================================================
#32
SELECT FLOOR(AVG(YEAR(CURRENT_DATE)-YEAR(birthday))) AS age
FROM FamilyMembers;
===========================================================
#33
SELECT AVG(unit_price) AS cost FROM Payments
JOIN Goods ON Payments.good=Goods.good_id
WHERE good_name IN ('red caviar', 'black caviar');
===========================================================
#34
SELECT COUNT(name) AS count FROM Class
WHERE name LIKE "10 %";
===========================================================
#35
SELECT COUNT(classroom) as count
FROM Schedule
WHERE date='2019-09-02%'
===========================================================
#36
SELECT * FROM Student
WHERE address LIKE 'ul. Pushkina%'
===========================================================
#37
SELECT MIN(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE())) as year
FROM Student;
===========================================================
#38
SELECT COUNT(first_name) AS count
FROM Student
WHERE first_name='Anna';
===========================================================
#39
SELECT COUNT(student) AS count
FROM Student_in_class
JOIN Class ON Student_in_class.class=Class.id
WHERE name='10 B';
===========================================================
#40
SELECT name AS subjects
FROM Subject
JOIN Schedule ON Schedule.subject=Subject.id
JOIN Teacher ON Teacher.id=Schedule.teacher
WHERE last_name='Romashkin';
===========================================================
#41
SELECT start_pair
FROM Timepair
WHERE id=4;
===========================================================
#42
SELECT TIMEDIFF(
  (SELECT end_pair FROM Timepair WHERE id=4),
  (SELECT start_pair FROM Timepair WHERE id=2)
) AS time
===========================================================
#43
SELECT last_name FROM Teacher
JOIN Schedule ON Teacher.id=Schedule.teacher
JOIN Subject ON Schedule.subject=Subject.id
WHERE name='Physical Culture'
ORDER BY last_name;
===========================================================
#44
SELECT MAX(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE())) as max_year
FROM Student
JOIN Student_in_class ON Student_in_class.student=Student.id
JOIN Class ON Class.id=Student_in_class.class
WHERE name LIKE '10%';
===========================================================
#45
SELECT classroom FROM Schedule
GROUP BY classroom
ORDER BY COUNT(classroom) DESC
LIMIT 0, 2;
======================
SELECT max(count) FROM
  (SELECT COUNT(*) as count FROM Schedule
  GROUP BY classroom) as tbl;
===========================================================
#46
SELECT name FROM Class
JOIN Schedule ON Schedule.class=Class.id
JOIN Teacher ON Schedule.teacher=Teacher.id
WHERE last_name='Krauze'
GROUP BY name;
===========================================================
#47
SELECT COUNT(teacher) AS count FROM Schedule
JOIN Teacher ON Schedule.teacher=Teacher.id
WHERE last_name='Krauze' AND date='2019-08-30T00:00:00.000Z';
===========================================================
#48
SELECT name, COUNT(student) AS count FROM Student_in_class
JOIN Class ON Class.id=Student_in_class.class
GROUP BY class
ORDER BY count DESC;
===========================================================
#49
SELECT (SELECT COUNT(student) FROM Student_in_class
        JOIN Class ON Class.id=Student_in_class.class
        WHERE name='10 A') / ((SELECT COUNT(student) FROM Student_in_class) / 100)
        AS percent;
===========================================================
#50
SELECT FLOOR((SELECT COUNT(id) FROM Student WHERE birthday LIKE '2000-%')
              / ((SELECT COUNT(id) FROM Student) / 100))
              AS percent;
===========================================================
#51
INSERT INTO Goods (good_id, good_name, type)
VALUES (17 , 'Cheese', 2);
===========================================================
#52
INSERT INTO GoodTypes (good_type_id, good_type_name)
VALUES (9 , 'auto');
===========================================================
#53
UPDATE FamilyMembers
SET member_name = "Andie Anthony"
WHERE member_name = "Andie Quincey";
===========================================================
#54
DELETE FROM FamilyMembers
WHERE member_name LIKE '% Quincey';
===========================================================
#55
DELETE FROM Company
WHERE id IN (
  SELECT company
  FROM Trip
  GROUP BY company
  HAVING COUNT(*) <= ALL (SELECT COUNT(*)
                          FROM Trip
                          GROUP BY company
    )
  )
==============================
DELETE FROM Company
WHERE id IN (
  SELECT company
  FROM Trip
  GROUP BY company
  HAVING COUNT(*) = (SELECT COUNT(*)
                      FROM Trip
                      GROUP BY company
                      ORDER BY 1 LIMIT 1))

===========================================================
#56
DELETE FROM Trip
WHERE town_from='Moscow'
===========================================================
#57
UPDATE Timepair
SET start_pair = start_pair + INTERVAL 30 MINUTE,
    end_pair = end_pair + INTERVAL 30 MINUTE;
===========================================================
#58
INSERT INTO Reviews
  SELECT COUNT(id) + 1,
  (SELECT Reservations.id FROM Reservations JOIN Users
    ON  Users.id=Reservations.user_id
    JOIN Rooms ON  Rooms.id=Reservations.room_id
    WHERE name LIKE "George Clooney" AND address LIKE "11218, Friel Place, New York"),
  5
FROM Reviews;
===========================================================
#59
SELECT * FROM Users
WHERE phone_number LIKE '+375%';
===========================================================
#60
SELECT Teacher
FROM
        (SELECT Teacher, COUNT(*)
        FROM Schedule JOIN Class
        ON Schedule.class = Class.id
        WHERE class.name = '11 A'
        Group by Teacher
        HAVING COUNT(*) >= '1') AS i8
HAVING EXISTS
        (SELECT Teacher, COUNT(*)
        FROM Schedule JOIN Class
        ON Schedule.class = Class.id
        WHERE class.name = '11 B' AND teacher = i8.teacher
        Group by Teacher
        HAVING COUNT(*) >= '1')
Order by Teacher;
============================
SELECT DISTINCT teacher
FROM
  (SELECT teacher
  FROM Schedule JOIN Class
  ON Schedule.class = Class.id
  WHERE Class.name = '11 A') i8
WHERE EXISTS
(SELECT Teacher
  FROM Schedule JOIN Class
  ON Schedule.class = Class.id
  WHERE Class.name = '11 B'
  AND teacher = i8.teacher)

============================
SELECT teacher
FROM Schedule
WHERE class IN
  (SELECT id FROM Class
  WHERE name LIKE '11%')
GROUP BY teacher
HAVING count(DISTINCT class) >=
  (SELECT COUNT(DISTINCT id)
  FROM Class
  WHERE name LIKE '11%')
===========================================================
#61
SELECT Rooms.* FROM Rooms
JOIN Reservations ON Rooms.id=Reservations.room_id
WHERE WEEK(start_date) = 11;
===========================================================
#62
SELECT domain, count(domain) AS count
FROM (SELECT substring(email, (LOCATE('@', email)+1)) as domain FROM users) AS t1
GROUP BY domain
ORDER BY count desc, domain asc;

===========================================================
#63
SELECT CONCAT(
  last_name,
  '.',
  LEFT(first_name, 1),
  '.',
  LEFT(middle_name, 1),
  '.'
) name FROM Student
ORDER BY name;

===========================================================
#64

WITH newTab1 AS(
  SELECT passenger.id, trip, name AS passengerName1
  FROM pass_in_trip
  JOIN passenger ON passenger.id = pass_in_trip.passenger
  GROUP BY trip, passenger),
newTab2 AS(
  SELECT passenger.id, trip, name AS passengerName2
  FROM pass_in_trip
  JOIN passenger ON passenger.id = pass_in_trip.passenger
  GROUP BY trip, passenger)
SELECT newTab1.passengerName1, newTab2.passengerName2, count(*) AS count
FROM newTab1, newTab2
WHERE newTab2.trip = newTab1.trip AND newTab2.passengerName2 != newTab1.passengerName1 AND newTab1.id < newTab2.id
GROUP BY newTab1.passengerName1, newTab2.passengerName2
HAVING count >1
===========================================================
#65
SELECT room_id, FLOOR(AVG(rating)) AS rating
FROM Reservations
JOIN Reviews ON Reviews.reservation_id=Reservations.id
GROUP BY room_id;
===========================================================
#66
SELECT  home_type,
    address,
    IFNULL(SUM(dateDIFF(end_date, start_date)) ,0) AS days,
    IFNULL(SUM(dateDIFF(end_date, start_date)*Reservations.price) , 0) AS total_fee
FROM Rooms
LEFT OUTER JOIN Reservations ON Reservations.room_id = Rooms.id
WHERE has_tv=1 AND has_internet=1 AND has_kitchen=1 AND has_air_con=1
GROUP BY address, home_type;

===========================================================
-
-
-
-
-
-
-
-
-
-
