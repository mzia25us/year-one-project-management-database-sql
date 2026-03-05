# Project Management Database (SQL)

University coursework focused on designing a normalised relational database for a project management system using MySQL, including schema design and SQL queries.

## Overview

This project demonstrates the design and implementation of a relational database to support the project management activities of a software company.  

The database stores information about clients, employees, employee skills, and software projects. A team of employees with appropriate skills can be assigned to projects based on project requirements.

The database design follows **Third Normal Form (3NF)** principles to ensure efficient data organisation and reduce redundancy.

## Aims

The database is designed to store and manage information about:

1. **Clients** – organisation name, contact name, email, address, and preferred contact method.
2. **Pool members (employees)** – first name, last name, email, phone number, and addresses.
3. **Skills** – skill name and type (e.g. Java – Backend, JUnit – Testing).
4. **Projects** – title, start date, end date, budget, description, and development phase.

## Requirements

### schema.sql

Defines the relational database schema and constraints.

The schema ensures that:

- Clients can offer multiple projects.
- Pool members can be assigned to projects if they meet the required skills.
- Pool members may share the same skills but have different experience levels.
- Projects and employees may exist without being assigned to each other until allocation decisions are made.

### queries.sql

Contains SQL statements used to populate and test the database.

These queries:

- Insert at least six predefined skills.
- Create two pool members, each linked to multiple skills.
- Insert two client records.
- Create a project requiring specific skills.
- Query the database to identify suitable employees for the project.
- Include additional SELECT queries to generate useful project management reports.

## Skills Demonstrated

- Relational database design
- Third Normal Form (3NF)
- SQL schema creation
- Data insertion using SQL
- Query development with SELECT statements
- MySQL database management
