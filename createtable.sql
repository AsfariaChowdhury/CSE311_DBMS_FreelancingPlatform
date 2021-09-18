CREATE DATABASE freelancedb;

USE freelancedb;

CREATE TABLE freelancer(
	id INT PRIMARY KEY,
	name VARCHAR(100),
	samplework_filepath1 VARCHAR(100),
	samplework_filepath2 VARCHAR(100),
	samplework_filepath3 VARCHAR(100),
	skills VARCHAR(1000),
	profession VARCHAR(100)
);

INSERT INTO freelancer VALUES
(1, 'Ahmed Kobir', 'D:/Samples1/work1.ai', 'D:/Samples1/work2.ai', 'D:/Samples1/work3.ai', 'Adobe Illustrator, Adobe Photoshop', 'Graphic Designer'),
(2, 'Ahmed Khan', 'D:/Samples2/work1.psd', 'D:/Samples2/work2.psd', 'D:/Samples2/work3.psd', 'Adobe Illustrator, Adobe Photoshop', 'Logo Designer'),
(3, 'Ameera Zareen', 'D:/Samples3/work1.pdf', 'D:/Samples3/work2.pdf', 'D:/Samples3/work3.pdf', 'Content Writing, Food Blogging, SEO Optimization', 'Blogger'),
(4, 'Tahmid Ahsan', 'D:/Samples4/work1.js', 'D:/Samples4/work2.php', 'D:/Samples4/work3.js', 'JS, PhP, Bootstrap, SQL', 'Full Stack Web Developer'),
(5, 'Tanisha Fatema', 'D:/Samples5/work1.js', 'D:/Samples5/work2.php', 'D:/Samples5/work3.css', 'JS, PhP, Bootstrap, CSS Animations', 'Front-end Web Developer');

CREATE TABLE client(
	id INT PRIMARY KEY,
	name VARCHAR(100),
	profession VARCHAR(100),
	needs VARCHAR(1000)
);

CREATE TABLE jobpost(
	id INT PRIMARY KEY,
	titleofpost VARCHAR(100),
	posttext VARCHAR(5000),
	deadline DATE,
);

ALTER TABLE client
ADD jid INT FOREIGN KEY REFERENCES jobpost(id) ON DELETE SET NULL;

CREATE TABLE listofjobpost(
	id INT PRIMARY KEY,
	fid INT FOREIGN KEY REFERENCES freelancer(id) ON DELETE SET NULL,
	accepted VARCHAR(50),
	filepath VARCHAR(100)
);

ALTER TABLE jobpost
ADD lid INT FOREIGN KEY REFERENCES listofjobpost(id) ON DELETE SET NULL;

INSERT INTO client(id, name, profession, needs) VALUES
(1, 'Kobirul Hasan', 'Book Shop Manager', 'Adobe Illustrator, Adobe Photoshop for book covers'),
(2, 'Hosne Akhter', 'Dina Cafe', 'Logo Designer'),
(3, 'Rofik Ali', 'Rofik E-market', 'Web Developer to build website'),
(4, 'Rofik Jobbar', 'Deshi Eats', 'Food reviewer for our Facebook page'),
(5, 'Dolly Ziana', 'Dolly Designs', 'Adobe Photoshop, Adobe Aftereffects for photoediting')

INSERT INTO jobpost(id, titleofpost, posttext, deadline) VALUES
(1, 'Need a Full Stack Developer', 'Rofik E-market is an online shop. We are currently looking for freelancers who will build our website.', '2021-10-30'),
(2, 'A Good Logo Design', 'Diana Cafe is looking for a good logo designer. The logo be meaningful and must contain the picture of a coffee mug.', '2021-11-10'),
(3, 'Book Cover', 'Make a suitable book cover in Adobe Photoshop. Need multiple cover designs - a total of 11.', '2021-11-22'),
(4, 'Content Writer', 'Rofik E-market is looking for a content writer for our Instagram and Facebook pages.', '2021-10-29'),
(5, 'Give Food Review', 'Deshi Eats is hiring a team of freelancers - a photoeditor and a food blogger - to market our food.', '2021-12-10');

UPDATE client
SET jid = 1
WHERE id = 3;

UPDATE client
SET jid = 2
WHERE id = 2;

UPDATE client
SET jid = 3
WHERE id = 1;

UPDATE client
SET jid = 5
WHERE id = 4;

INSERT INTO listofjobpost VALUES
(1, 1, 'yes', 'D:/Work/work1.ai'),		--graphic designer
(2, 2, 'no', 'D:/Work/work2.psd'),		--logo designer
(3, 3, 'no', 'D:/Work/work3.pdf'),		--blogger
(4, 4, 'yes', 'D:/Work/work4.js'),		--full stack
(5, 5, 'no', 'D:/Work/work5,js');		--front end

UPDATE jobpost
SET lid = 2
WHERE id = 2;

UPDATE jobpost
SET lid = 1
WHERE id = 3;

UPDATE jobpost
SET lid = 3
WHERE id = 4;

UPDATE jobpost
SET lid = 4
WHERE id = 1;

CREATE TABLE review(
	id INT PRIMARY KEY,
	lid INT FOREIGN KEY REFERENCES listofjobpost(id) ON DELETE SET NULL,
	reviewtext VARCHAR(5000)
);

INSERT INTO review VALUES
(1, 1, 'This is a superb graphic designer. Fabulous book covers - matches with the story theme.'),
(2, 2, 'Logo is not good at all. Just submitted an edited logo template from online. No originality.'),
(3, 3, 'The right type of content writer. Could effectively handle writing about events.'),
(4, 4, 'The perfect go to person.');

CREATE TABLE clientpaid(
	id INT PRIMARY KEY,
	lid INT FOREIGN KEY REFERENCES listofjobpost(id) ON DELETE SET NULL,
	money DECIMAL
);

INSERT INTO clientpaid VALUES
(1, 1, 2000),
(2, 2, 0),
(3, 3, 5000),
(4, 4, 8000),
(5, 5, 0);

CREATE TABLE freelancerreceived(
	id INT PRIMARY KEY,
	lid INT FOREIGN KEY REFERENCES listofjobpost(id) ON DELETE SET NULL,
	money DECIMAL
);

INSERT INTO freelancerreceived VALUES
(1, 1, 2000),
(2, 2, 0),
(3, 3, 5000),
(4, 4, 8000),
(5, 5, 0);