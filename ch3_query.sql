USE freelancedb;

-- See all freelancers' names
SELECT name FROM freelancer;

-- See all categories of job posts available so far using "distinct", in ascending order
SELECT DISTINCT titleofpost 'Categories' FROM jobpost ORDER BY titleofpost;

-- View all information on the clients
SELECT * FROM client;

-- View a specific profession of freelancer
SELECT name FROM freelancer WHERE profession = 'Graphic Designer';

/*
	View a specific profession with specific skills
*/
SELECT name FROM freelancer WHERE profession = 'Graphic Designer' AND skills LIKE '%Adobe Illustrator%';

/*
	View client name and his corresponding post.
*/
SELECT client.name, jobpost.posttext
FROM client, jobpost
WHERE client.jid = jobpost.id;

/*
	View client name and his corresponding post, and post title has word 'Content Writer'
*/
SELECT client.name, jobpost.posttext
FROM client, jobpost
WHERE client.jid = jobpost.id AND jobpost.titleofpost LIKE '%Content Writer%';


/*
	Viewing freelancer's payment within 5000 to 8000
*/
SELECT * FROM freelancerreceived WHERE money BETWEEN 5000 AND 8000;

-- set operations
/*
	Viewing freelancers and clients of specific service
*/
(SELECT name, skills FROM freelancer WHERE skills LIKE '%JS%')
UNION
(SELECT name, needs FROM client WHERE needs LIKE '%Web Developer%');

/*
	Exclude any backend freelancer
*/
(SELECT name, skills FROM freelancer WHERE skills LIKE '%JS%')
EXCEPT
(SELECT name, skills FROM freelancer WHERE skills LIKE '%SQL%');

/*
	See job posts where lid is null - no freelancer submitted work
*/
SELECT * FROM jobpost WHERE lid IS NULL;

-- Agregate
-- View average amount paid by client
SELECT AVG(money) AS 'Average Paid Amount' FROM clientpaid;

-- See the maximum and sum of money in freelancerreceived
SELECT MAX(money) 'Maximium', SUM(money) 'Sum' FROM freelancerreceived;

-- See review of freelancers whose work was accepted, using subquery
SELECT review.reviewtext FROM review WHERE review.lid IN(
	SELECT listofjobpost.id 
	FROM listofjobpost
	WHERE listofjobpost.accepted = 'yes'
);

/*
	Seeing which designers use Adobe products using 'exists'
*/
SELECT name FROM freelancer AS F1
WHERE skills LIKE '%Adobe%' AND EXISTS (
	SELECT * FROM freelancer AS F2
	WHERE profession LIKE '%Designer%' AND F1.id = F2.id
);

-- A complex query - joining 4 tables
SELECT client.name, jobpost.posttext, listofjobpost.accepted, freelancer.name
FROM client JOIN jobpost ON client.jid = jobpost.id 
JOIN listofjobpost ON jobpost.lid = listofjobpost.fid 
JOIN freelancer ON listofjobpost.fid = freelancer.id
WHERE	freelancer.profession LIKE '%Designer%' 
		AND jobpost.deadline LIKE '2021-%' 
		OR listofjobpost.accepted = 'yes'
ORDER BY client.name;

-- using 'case' and joining 3 tables to view payment status
SELECT freelancerreceived.money, listofjobpost.filepath, freelancer.name, 
(CASE	WHEN freelancerreceived.money >= 5000 
		then 'High' 
		ELSE 'Low' 
		END
) AS paymentstatus
FROM freelancerreceived JOIN listofjobpost ON freelancerreceived.lid = listofjobpost.id
JOIN freelancer ON listofjobpost.fid = freelancer.id;
