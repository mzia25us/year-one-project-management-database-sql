START TRANSACTION; 

-- This section was used by me for testing, to allow seamless repeats and improvements.
SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM pool_member_skills;
DELETE FROM project_required_skills;
DELETE FROM pool_members;
DELETE FROM projects;
DELETE FROM skills;
DELETE FROM clients;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------
-- Here, we insert the skills for the system. 

INSERT INTO skills(skill_name, skill_type) VALUES
('SQL', 'Database'),
('Java', 'Backend'),
('Project Management', 'Management'),
('UI/UX Design', 'Design'),
('Software testing', 'Software Development'),
('DevOps', 'Technical'),
('JavaScript', 'Frontend'),
('PHP', 'Backend'),
('JUnit', 'Testing'),
('Docker', 'DevOps');

-- -----------------------------------------------
-- This stores skill IDs into variables to user latter when
-- creating project requirements and assigning pool members to skills.
-- It stops anything being hardcoded. 

SELECT skill_id INTO @skill_sql
FROM skills WHERE skill_name = 'SQL' AND skill_type = 'Database';

SELECT skill_id INTO @skill_java 
FROM skills WHERE skill_name = 'Java' AND skill_type = 'Backend';

SELECT skill_id INTO @skill_project_management 
FROM skills WHERE skill_name = 'Project Management' AND skill_type = 'Management';

SELECT skill_id INTO @skill_UI_design
FROM skills WHERE skill_name = 'UI/UX Design' AND skill_type = 'Design';

SELECT skill_id INTO @skill_software_testing
FROM skills WHERE skill_name = 'Software testing' AND skill_type = 'Software Development';

SELECT skill_id INTO @skill_devops
FROM skills WHERE skill_name = 'DevOps' AND skill_type = 'Technical';

SELECT skill_id INTO @skill_js
FROM skills WHERE skill_name = 'JavaScript' AND skill_type = 'Frontend';

SELECT skill_id INTO @skill_php
FROM skills WHERE skill_name = 'PHP' AND skill_type = 'Backend';

SELECT skill_id INTO @skill_junit
FROM skills WHERE skill_name = 'JUnit' AND skill_type = 'Testing';

SELECT skill_id INTO @skill_docker
FROM skills WHERE skill_name = 'Docker' AND skill_type = 'DevOps';

-- ------------------------------------------------
-- Here, we generate our clients for the system and set 
-- them into variables too just as we did for skills above. 
INSERT INTO clients(organisation_name, first_name, last_name, email, address, contact_method)
VALUES ('Kingstanding Health Ltd', 'Chyanne', 'Roberts', 'chyanne.roberts@kingstandinghealth.com', '12 Colebrook Street, Birmingham, B1 1AA', 'email'),
('Lockbrook Retail Group', 'Danny', 'Latimer', 'danny.l24@lockbrookretail.co.uk', '44 Queens Avenue, Leeds, LS1 1AZ', 'post'),
('Bournvilla Education Centre', 'Amina', 'Hussain', 'amina.hussain365@bournvillaed.org', '18 Linden Road, Manchester, M30 1AA', 'email'),
('Emirates Instituition', 'Davina', 'McCall', 'davina.mccall@emiratesinstitute.org', '48 Clifton Green, Glasgow, G2 1JS', 'email');

SELECT client_id INTO @client1 FROM clients WHERE email = 'chyanne.roberts@kingstandinghealth.com';
SELECT client_id INTO @client2 FROM clients WHERE email = 'danny.l24@lockbrookretail.co.uk';
SELECT client_id INTO @client3 FROM clients WHERE email = 'amina.hussain365@bournvillaed.org';
SELECT client_id INTO @client4 FROM clients WHERE email = 'davina.mccall@emiratesinstitute.org';

-- ------------------------------------------------
-- MAKING THE PROJECTS --
-- ------------------------------------------------

-- Here, we generate our projects, for the clients. 
-- The stored variable (@project#) will link required
-- skills to a specific project using the project_required_skills
-- junction table. 

INSERT INTO projects (client_id, title, project_start_date, project_end_date, budget, project_description, phase)
VALUES 
(@client1, 'Patient Portal MVP', '2026-02-10', '2026-05-30', 75000.00, 'A secure patient portal with login, appointment viewing and messaging. Focus is on the user interface + database layer.',
'testing');

SELECT LAST_INSERT_ID() INTO @project1;

-- HERE, WE ARE GOING TO LINK THE REQUIRED SKILLS TO THE PROJECT ABOVE. 
INSERT INTO project_required_skills(project_id, skill_id)
VALUES
(@project1, @skill_sql),
(@project1, @skill_php);

-- --------
INSERT INTO projects (client_id, title, project_start_date, project_end_date, budget, project_description, phase)
VALUES 
(@client2, 'E-Commerce UI Refresh', '2026-03-05', '2026-04-25', 28000.00, 'A UI refresh for an online retail storefront with improved navigation and accessibility.', 'deployment');

SELECT LAST_INSERT_ID() INTO @project2;

INSERT INTO project_required_skills(project_id, skill_id)
VALUES
(@project2, @skill_js),
(@project2, @skill_UI_design);

-- Extra project for client 2 to demonstrate 1 client -> many projects
INSERT INTO projects (client_id, title, project_start_date, project_end_date, budget, project_description, phase)
VALUES
(@client2, 'E-Commerce Backend Optimisation', '2026-07-21', '2026-09-30', 45000.00,
 'Performance optimisation and backend refactoring to improve checkout speed and scalability.', 'development');

SELECT LAST_INSERT_ID() INTO @project4;
INSERT INTO project_required_skills(project_id, skill_id)
VALUES
(@project4, @skill_sql),
(@project4, @skill_devops);

-- ------------------
INSERT INTO projects (client_id, title, project_start_date, project_end_date, budget, project_description, phase)
VALUES 
(@client3, 'Internal QA Automation Suite', '2026-04-01', '2026-06-20', 36000.00, 'A Java-based automated regression suite for internal systems with unit testing and reporting.', 'testing');

SELECT LAST_INSERT_ID() INTO @project3;

INSERT INTO project_required_skills(project_id, skill_id)
VALUES
(@project3, @skill_java),
(@project3, @skill_junit);

-- ------------------------------------------------
-- Here we makepool memebers who are not assigned to any project yet.)
-- 'allocation_status' will be default to available until otherwise. 
INSERT INTO pool_members(first_name, last_name, email, phone, work_address, home_address, project_id)
VALUES
('Sofia', 'Kim','sofia.kim24@nexoratech.com', '+44 7700 900111', '1 Rowmore Industrial Park, London, L4 7AA', '8 Riverside Close, London, L15 2TT', NULL),
('Lucas', 'Bennet', 'lucas.bennet@nexoratech.com', '+44 7700 900222', '1 Rowmore Industrial Park, London, L4 7AA', '29 Orchard Drive, Manchester, MV1 3AB', NULL),
('Ethan', 'Cole', 'ethan.cole@nexoratech.com', '+44 7700 900444', '1 Rowmore Industrial Park, London, L4 7AA', '2 Seaview Road, London, LN1 4ZZ', NULL),
('Summer', 'Singh', 'summer.singh@nexoratech.com', '+44 7700 900333', '1 Rowmore Industrial Park, London, L4 7AA', '15 Brook Lane, London, LS6 2AB', NULL);

SELECT pool_member_id INTO @pm_sofia FROM pool_members WHERE email='sofia.kim24@nexoratech.com';
SELECT pool_member_id INTO @pm_lucas FROM pool_members WHERE email = 'lucas.bennet@nexoratech.com';
SELECT pool_member_id INTO @pm_ethan FROM pool_members WHERE email='ethan.cole@nexoratech.com';
SELECT pool_member_id INTO @pm_summer FROM pool_members WHERE email = 'summer.singh@nexoratech.com';

-- NOW WE INSERT SKILLS FOR THE POOL MEMBERS.
-- Skills for Sofia
INSERT INTO pool_member_skills (pool_member_id, skill_id, experience_level) 
VALUES 
(@pm_sofia, @skill_php, 'Expert'),
(@pm_sofia, @skill_UI_design, 'Senior'),
(@pm_sofia, @skill_sql, 'Senior'),
(@pm_sofia, @skill_docker, 'Mid');

-- Skills for Lucas
INSERT INTO pool_member_skills (pool_member_id, skill_id, experience_level)
VALUES
(@pm_lucas, @skill_js, 'Junior'),
(@pm_lucas, @skill_sql, 'Mid'),
(@pm_lucas, @skill_project_management, 'Junior'),
(@pm_lucas, @skill_junit, 'Senior');

-- Skills for Summer
INSERT INTO pool_member_skills (pool_member_id, skill_id, experience_level) 
VALUES 
(@pm_summer, @skill_js, 'Expert'),
(@pm_summer, @skill_UI_design, 'Mid');

-- Skills for Ethan
INSERT INTO pool_member_skills (pool_member_id, skill_id, experience_level)
VALUES
(@pm_ethan, @skill_java, 'Mid'),
(@pm_ethan, @skill_junit, 'Senior');


-- -----------------------------------------------
-- NOW WE MAKE OUR QUERIES. 
-- Here the skill matching query is shown. Returns pool members who match all
-- required skills for the selected project. 

SELECT pm.pool_member_id, pm.first_name, pm.last_name, pm.email
FROM pool_members pm
JOIN pool_member_skills pms
    ON pm.pool_member_id = pms.pool_member_id
JOIN project_required_skills prs
    ON prs.skill_id = pms.skill_id
WHERE prs.project_id = @project1
GROUP BY pm.pool_member_id, pm.first_name, pm.last_name, pm.email
HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project1);

-- -------------------------------------------------
-- NOW WE ASSIGN MATCHING POOL MEMBERS TO PROJECTS
-- Updates only to those who match all required skills. 

UPDATE pool_members
SET project_id = @project1,
    allocation_status = 'assigned'
WHERE pool_member_id IN (
    SELECT matched.pool_member_id
    FROM (
        SELECT pm.pool_member_id
        FROM pool_members pm
        JOIN pool_member_skills pms
            ON pm.pool_member_id = pms.pool_member_id
        JOIN project_required_skills prs
            ON prs.skill_id = pms.skill_id
        WHERE prs.project_id = @project1
        GROUP BY pm.pool_member_id
        HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project1)
    ) AS matched
);

-- PROJECT 2 ASSIGNMENT
-- Matching members for Project 2
SELECT pm.pool_member_id, pm.first_name, pm.last_name, pm.email
FROM pool_members pm
JOIN pool_member_skills pms ON pm.pool_member_id = pms.pool_member_id
JOIN project_required_skills prs ON prs.skill_id = pms.skill_id
WHERE prs.project_id = @project2
GROUP BY pm.pool_member_id, pm.first_name, pm.last_name, pm.email
HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project2);

-- Assign matches to Project 2
UPDATE pool_members
SET project_id = @project2,
    allocation_status = 'assigned'
WHERE pool_member_id IN (
    SELECT matched.pool_member_id
    FROM (
        SELECT pm.pool_member_id
        FROM pool_members pm
        JOIN pool_member_skills pms ON pm.pool_member_id = pms.pool_member_id
        JOIN project_required_skills prs ON prs.skill_id = pms.skill_id
        WHERE prs.project_id = @project2
        GROUP BY pm.pool_member_id
        HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project2)
    ) AS matched
);

-- PROJECT 3 ASSIGNMENT
-- Matching members for Project 3
SELECT pm.pool_member_id, pm.first_name, pm.last_name, pm.email
FROM pool_members pm
JOIN pool_member_skills pms ON pm.pool_member_id = pms.pool_member_id
JOIN project_required_skills prs ON prs.skill_id = pms.skill_id
WHERE prs.project_id = @project3
GROUP BY pm.pool_member_id, pm.first_name, pm.last_name, pm.email
HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project3);

-- Assign matches to Project 3
UPDATE pool_members
SET project_id = @project3,
    allocation_status = 'assigned'
WHERE pool_member_id IN (
    SELECT matched.pool_member_id
    FROM (
        SELECT pm.pool_member_id
        FROM pool_members pm
        JOIN pool_member_skills pms ON pm.pool_member_id = pms.pool_member_id
        JOIN project_required_skills prs ON prs.skill_id = pms.skill_id
        WHERE prs.project_id = @project3
        GROUP BY pm.pool_member_id
        HAVING COUNT(DISTINCT prs.skill_id) = (SELECT COUNT(*) FROM project_required_skills WHERE project_id = @project3)
    ) AS matched
);

-- THEN WE MAKE SURE THAT IT WORKED. 
SELECT pm.pool_member_id, pm.first_name, pm.last_name, pm.project_id, p.title AS assigned_project
FROM pool_members pm
LEFT JOIN projects p ON pm.project_id = p.project_id
ORDER BY pm.pool_member_id;

-- DEMONSTRATING THE 'PENDING' ON AN EMPLOYEE
UPDATE pool_members
SET project_id = @project2,
    allocation_status = 'pending'
WHERE pool_member_id = @pm_lucas;

COMMIT;
-- --------------------------------------------------
-- ADDITIONAL SELECT STATEMENTS

-- Report 1: Project overview which includes the client's details and current assigned team size.
SELECT p.project_id, p.title, CONCAT(c.first_name, ' ', c.last_name) AS client_contact, 
c.organisation_name, p.phase, p.budget, p.project_start_date, p.project_end_date, COUNT(pm.pool_member_id) AS team_size
FROM projects p
JOIN clients c
    ON p.client_id = c.client_id
LEFT JOIN pool_members pm
    ON pm.project_id = p.project_id
    AND pm.allocation_status = 'assigned'
GROUP BY p.project_id, p.title, client_contact, c.organisation_name, p.phase, p.budget, p.project_start_date, p.project_end_date
ORDER BY p.project_start_date DESC;

-- Report 2: An inventory of skills by pool member, including experience level. 
SELECT pm.pool_member_id, CONCAT(pm.first_name, ' ', pm.last_name) AS pool_member, s.skill_name, s.skill_type, pms.experience_level
FROM pool_members pm
JOIN pool_member_skills pms
    ON pm.pool_member_id = pms.pool_member_id
JOIN skills s
    ON pms.skill_id = s.skill_id
ORDER BY pm.pool_member_id, s.skill_type, s.skill_name;

-- Report 3: Skill coverage based on each project. Like for each required skill it counts which assigned members have it. 
SELECT p.project_id, p.title, s.skill_name, s.skill_type, COUNT(DISTINCT pms.pool_member_id) AS assigned_members_with_skill
FROM projects p
JOIN project_required_skills prs
    ON p.project_id = prs.project_id
JOIN skills s
    ON prs.skill_id = s.skill_id
LEFT JOIN pool_members pm
    ON pm.project_id = p.project_id
    AND pm.allocation_status = 'assigned'
LEFT JOIN pool_member_skills pms
    ON pms.pool_member_id = pm.pool_member_id
AND pms.skill_id = prs.skill_id
GROUP BY p.project_id, p.title, s.skill_name, s.skill_type
ORDER BY p.project_id, s.skill_type, s.skill_name;

-- Report 4: Demonstrates who are available and who are pending.
SELECT pm.pool_member_id, pm.first_name, pm.last_name, pm.email
FROM pool_members pm
LEFT JOIN projects p ON p.project_id = pm.project_id
WHERE pm.allocation_status IN ('available', 'pending')
ORDER BY pm.allocation_status, pm.last_name, pm.first_name;

-- Report 5: Candidate ranking for a given project based on the skill coverage. 
SELECT 
    p.project_id,
    p.title,
    pm.pool_member_id,
    CONCAT(pm.first_name, ' ', pm.last_name) AS pool_member,
    COUNT(DISTINCT prs.skill_id) AS required_skills_total,
    COUNT(DISTINCT pms.skill_id) AS required_skills_matched,
    ROUND((COUNT(DISTINCT pms.skill_id) / COUNT(DISTINCT prs.skill_id)) * 100, 0) AS match_percent
FROM projects p
JOIN project_required_skills prs ON prs.project_id = p.project_id
CROSS JOIN pool_members pm
LEFT JOIN pool_member_skills pms
    ON pms.pool_member_id = pm.pool_member_id
   AND pms.skill_id = prs.skill_id
WHERE p.project_id = 2
GROUP BY p.project_id, p.title, pm.pool_member_id, pool_member
ORDER BY match_percent DESC, pm.last_name, pm.first_name;

-- Report 6 -- Demonstrates that clients can offer as many projects. 
-- Here, it demonstrates more than one. 
SELECT c.organisation_name, COUNT(p.project_id) AS project_count
FROM clients c
LEFT JOIN projects p ON p.client_id = c.client_id
GROUP BY c.client_id, c.organisation_name
ORDER BY project_count DESC;

