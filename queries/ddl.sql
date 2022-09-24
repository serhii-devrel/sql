-- tables creation
CREATE TABLE teacher (
	teacher_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar,
	title varchar
);

CREATE TABLE exam (
	exam_id serial,
	exam_name varchar(256),
	exam_date date
);

-- adjusting
ALTER TABLE teacher
ADD COLUMN middle_name varchar;

ALTER TABLE teacher
DROP COLUMN middle_name;

ALTER TABLE teacher
RENAME birthday TO birth_date;

ALTER TABLE teacher
ALTER COLUMN phone SET DATA TYPE varchar(32);

INSERT INTO exam(exam_name, exam_date)
VALUES 
	('first', '03-08-2022'),
	('second', '03-08-2022'),
	('third', '03-08-2022');
