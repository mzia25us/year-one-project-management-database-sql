# Project Management Database
University coursework: designing a normalised relational database for a project management system using MySQL, including schema design and SQL queries.

# Overview
You are hired to design, develop and deliver a normalised relational database that supports
the project management activities of a software company. The company offers bespoke
software solutions to its clients and has built a strong reputation for delivering its products on
time since its establishment.

The company maintains a pool of employees of different levels and expertise, ranging from
domain analysts and software engineers to web developers and graphic designers. After an
agreement on developing a new software solution for a client, the company's management
team uses the pool above to form and propose a new project team to undertake the
development.

# Aims
Design a database that is in the third normal form (3NF), and can be used
to store the following information:

1. For clients: organisation name, first and last name, email and address, as well as
the preferred method of contact (by post or via email).
2. For pool members: first and last name, contact email and phone number, work and home
address.
3. For pool members' skills: skill name and type, e.g.: name="Java", type="Backend" or
name=”Junit”, type=“Testing”. Note that you are expected to use your own combinations
of values when you insert data into the database.
4. For projects: title, start date, end date, budget, a short description and the phase.
Suggested values for the phase are: "design", "development", "testing", "deployment" and
"complete".

# Requirements
schema.sql
1. Clients can offer as many projects as they want.
2. Pool members can only be assigned to one project if they meet the skill requirements.
Note that this decision is to be made by the management team.
3. Pool members may share skills but the level of experience may differ. For instance, Jenny
may be an expert in developing backend software in JavaScript, whereas John may be a
junior JavaScript developer for frontend applications.
4. There may be projects not linked to any pool members and vice versa. These will be projects
(and pool members) for which the allocation decisions are pending.

queries.sql
1. Populate the database with a pre-defined list of at least SIX skills.
2. Create TWO pool members, each associated with at least TWO skills from the predefined list. Your dummy data should demonstrate a variety of levels of experience.
3. Populate the database with TWO client records.
4. Create ONE project that requires TWO of the pre-defined skills to complete.
5. Query the database to receive a list of pool members that match the project’s
requirements and assign them to the project.
6. Demonstrate your design strengths by including at least TWO additional SELECT
statements to generate different reports for the project management team.
